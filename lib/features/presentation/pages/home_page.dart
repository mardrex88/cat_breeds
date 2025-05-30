import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/cat_api_datasource.dart';
import '../bloc/breeds_bloc.dart';
import 'breed_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _isSearching = false;
  Timer? _debounce;
  final CatApiDatasource _datasource = CatApiDatasource();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_isSearching &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200) {
      context.read<BreedsBloc>().add(LoadMoreBreeds());
    }
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 1200), () {
      setState(() {
        _isSearching = value.isNotEmpty;
      });
      if (value.isEmpty) {
        context.read<BreedsBloc>().add(LoadBreeds());
      } else {
        context.read<BreedsBloc>().add(SearchBreeds(value));
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cat Breeds'), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar raza...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: _onSearchChanged,
            ),
          ),
          Expanded(
            child: BlocBuilder<BreedsBloc, BreedsState>(
              builder: (context, state) {
                if (state is BreedsLoading && (state is! BreedsLoaded)) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is BreedsLoaded) {
                  final breeds = state.breeds;
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: breeds.length,
                    itemBuilder: (context, index) {
                      final breed = breeds[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      breed.name ?? '',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder:
                                                (_) => BreedDetailPage(
                                                  name: breed.name ?? '',
                                                  imageUrl:
                                                      breed.imageUrl ?? '',
                                                  description:
                                                      breed.description ?? '',
                                                  origin: breed.origin ?? '',
                                                  temperament:
                                                      breed.temperament ?? '',
                                                  intelligence:
                                                      breed.intelligence ?? 0,
                                                  adaptability:
                                                      breed.adaptability ?? 0,
                                                  lifeSpan:
                                                      breed.lifeSpan ?? '',
                                                  referenceImageId:
                                                      breed.referenceImageId,
                                                ),
                                          ),
                                        );
                                      },
                                      child: const Text('Ver más'),
                                    ),
                                  ],
                                ),
                              ),
                              if (breed.referenceImageId != null)
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                  child: FutureBuilder<String?>(
                                    future: _datasource.fetchImageUrl(
                                      breed.referenceImageId!,
                                    ),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Container(
                                          height: 180,
                                          color: Colors.grey[300],
                                          child: const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      } else if (snapshot.hasData &&
                                          snapshot.data != null) {
                                        return Image.network(
                                          snapshot.data!,
                                          height: 180,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        );
                                      } else {
                                        return Container(
                                          height: 180,
                                          color: Colors.grey[300],
                                          child: const Center(
                                            child: Icon(
                                              Icons.image_not_supported,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                child: Row(
                                  children: [
                                    const Text(
                                      'País de origen: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(breed.origin ?? ''),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is BreedsError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
