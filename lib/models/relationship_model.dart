class RelationshipModel {
  final String type;
  final String remedy;

  RelationshipModel({required this.type, required this.remedy});

  factory RelationshipModel.fromJson(Map<String, dynamic> json) {
    return RelationshipModel(
      type: json['type'] ?? '',
      remedy: json['remedy'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'remedy': remedy,
    };
  }
}
