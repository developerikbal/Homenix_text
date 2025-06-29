class OnboardingItem {
  final String image;
  final String title;
  final String description;

  OnboardingItem({
    required this.image,
    required this.title,
    required this.description,
  });

  factory OnboardingItem.fromJson(Map<String, dynamic> json) {
    return OnboardingItem(
      image: json['image'],
      title: json['title'],
      description: json['description'],
    );
  }
}