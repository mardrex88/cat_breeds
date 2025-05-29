import 'package:flutter/material.dart';

import 'breed_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Ejemplo de datos estáticos, luego se reemplazarán por datos reales
    final breeds = [
      {
        'title': 'Abyssinian',
        'image': 'https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg',
      },
      {
        'title': 'Bengal',
        'image': 'https://cdn2.thecatapi.com/images/O3btzLlsO.jpg',
      },
    ];

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
            ),
          ),
          Expanded(
            child: ListView.builder(
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
                                breed['title']!,
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
                                        name: breed['title']!,
                                        imageUrl: breed['image']!,
                                        description: 'Descripción de ejemplo', // Reemplaza por el dato real
                                        origin: 'Origen de ejemplo',           // Reemplaza por el dato real
                                        temperament: 'Temperamento de ejemplo',// Reemplaza por el dato real
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('Ver más'),
                              ),
                            ],
                          ),
                        ),
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                          child: Image.network(
                            breed['image']!,
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
            ),
          ),
        ],
      ),
    );
  }
}