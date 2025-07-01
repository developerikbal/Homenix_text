// lib/models/relationship_model.dart
class RelationshipModel {
  final String name;
  final String type;

  RelationshipModel({required this.name, required this.type});

  factory RelationshipModel.fromJson(Map<String, dynamic> json) {
    return RelationshipModel(
      name: json['name'] ?? '',
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
    };
  }
}
