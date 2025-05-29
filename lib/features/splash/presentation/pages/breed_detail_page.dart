import 'package:flutter/material.dart';

class BreedDetailPage extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String description;
  final String origin;
  final String temperament;

  const BreedDetailPage({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.origin,
    required this.temperament,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Column(
        children: [
          Image.network(
            imageUrl,
            width: double.infinity,
            height: 220,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Descripción',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(description),
                  const SizedBox(height: 16),
                  Text(
                    'Origen: $origin',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Temperamento: $temperament',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}