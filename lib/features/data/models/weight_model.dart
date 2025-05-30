
import '../../domain/entities/weight.dart';

class WeightModel extends Weight  {
  const WeightModel({
    required String imperial,
    required String metric,
  }) : super(imperial: imperial, metric: metric);

  factory WeightModel.fromJson(Map<String, dynamic> json) => WeightModel(
    imperial: json["imperial"],
    metric: json["metric"],
  );

  Map<String, dynamic> toJson() => {
    "imperial": imperial,
    "metric": metric,
  };
}
