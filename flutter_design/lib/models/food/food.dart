class Food {
  const Food({
    required this.name, 
    required this.imagePath,
    required this.weight, 
    required this.star, 
  });

  final String imagePath;
  final String name;
  final String weight;
  final double star;
}