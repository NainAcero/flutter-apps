class Menu {
  const Menu({
    required this.img, 
    required this.is_liked,
    required this.name,
    required this.description,
    required this.time,
    required this.delivery_fee,
    this.rate,
    this.rate_number,
  });

  final String img;
  final bool is_liked;
  final String name;
  final String description;
  final String time;
  final String delivery_fee;
  final double? rate;
  final int? rate_number;
}