// domain/entities/cat_breed.dart
  import 'weight.dart';

  class CatBreed {
    final Weight? weight;
    final String? id;
    final String? name;
    final String? temperament;
    final String? origin;
    final String? description;
    final String? lifeSpan;
    final int? adaptability;
    final int? intelligence;
    final String? referenceImageId;
    final String? imageUrl;

    const CatBreed({
      this.weight,
      this.id,
      this.name,
      this.temperament,
      this.origin,
      this.description,
      this.lifeSpan,
      this.adaptability,
      this.intelligence,
      this.referenceImageId,
      this.imageUrl,
    });
  }