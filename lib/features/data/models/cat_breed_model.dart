// data/models/cat_breed_model.dart
    import '../../domain/entities/cat_breed.dart';
    import 'weight_model.dart';

    class CatBreedModel extends CatBreed {
      const CatBreedModel({
        WeightModel? weight,
        String? id,
        String? name,
        String? temperament,
        String? origin,
        String? description,
        String? lifeSpan,
        int? adaptability,
        int? intelligence,
        String? referenceImageId,
        String? imageUrl,
      }) : super(
              weight: weight,
              id: id,
              name: name,
              temperament: temperament,
              origin: origin,
              description: description,
              lifeSpan: lifeSpan,
              adaptability: adaptability,
              intelligence: intelligence,
              referenceImageId: referenceImageId,
              imageUrl: imageUrl,
            );

      factory CatBreedModel.fromJson(Map<String, dynamic> json) => CatBreedModel(
            weight: json["weight"] == null ? null : WeightModel.fromJson(json["weight"]),
            id: json["id"],
            name: json["name"],
            temperament: json["temperament"],
            origin: json["origin"],
            description: json["description"],
            lifeSpan: json["life_span"],
            adaptability: json["adaptability"],
            intelligence: json["intelligence"],
            referenceImageId: json["reference_image_id"],
            imageUrl: json["image_url"],
          );

      Map<String, dynamic> toJson() => {
            "weight": (weight as WeightModel?)?.toJson(),
            "id": id,
            "name": name,
            "temperament": temperament,
            "origin": origin,
            "description": description,
            "life_span": lifeSpan,
            "adaptability": adaptability,
            "intelligence": intelligence,
            "reference_image_id": referenceImageId,
            "image_url": imageUrl,
          };
    }