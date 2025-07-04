class OnboardingItem {
  final String title;
  final String description;
  final String imageAsset;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.imageAsset,
  });
}

final List<OnboardingItem> onboardingItems = [
  OnboardingItem(
    title: 'Welcome to Homeonix',
    description:
        'Your intelligent companion for homeopathic remedy selection and analysis.',
    imageAsset: 'assets/images/onboarding1.png',
  ),
  OnboardingItem(
    title: 'Smart Remedy Finder',
    description:
        'Input symptoms in English or Bengali and get expert-level remedy suggestions.',
    imageAsset: 'assets/images/onboarding2.png',
  ),
  OnboardingItem(
    title: 'Developer & Doctor Features',
    description:
        'Upload books, analyze rubrics, and manage premium packages securely.',
    imageAsset: 'assets/images/onboarding3.png',
  ),
];
