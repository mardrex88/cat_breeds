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
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_isSearching &&_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      context.read<BreedsBloc>().add(LoadMoreBreeds());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat Breeds'),
        centerTitle: true,
      ),
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
              onChanged: (value){
                setState(() {
                  _isSearching = value.isNotEmpty;
                });
                if (value.isEmpty) {
                  context.read<BreedsBloc>().add(LoadBreeds());
                } else {
                  context.read<BreedsBloc>().add(SearchBreeds(value));
                }
              },
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
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                            builder: (_) => BreedDetailPage(
                                              name: breed.name ?? '',
                                              imageUrl: breed.imageUrl ?? '',
                                              description: breed.description ?? '',
                                              origin: breed.origin ?? '',
                                              temperament: breed.temperament ?? '',
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Text('Ver más'),
                                    ),
                                  ],
                                ),
                              ),
                              if (breed.imageUrl != null)
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                  child: Image.network(
                                    breed.imageUrl!,
                                    height: 180,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
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