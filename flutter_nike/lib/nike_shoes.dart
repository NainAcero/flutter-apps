
class NikeShoes {

  NikeShoes({
    required this.model, 
    required this.oldPrice, 
    required this.curentPrice, 
    required this.images, 
    required this.modelNumbers,
    required this.color
  });

  final String model;
  final double oldPrice;
  final double curentPrice;
  final List<String> images;
  final int modelNumbers;
  final int color;

}

final shoes = <NikeShoes>[
  NikeShoes(
    model: 'AIR MAX 90 EZ BLACK',
    curentPrice: 149,
    oldPrice: 299,
    images: [
      'assets/shoes1_1.png',
      'assets/shoes1_2.png',
      'assets/shoes1_3.png',
    ],
    modelNumbers: 90,
    color: 0XFFF6F6F6
  ),

  NikeShoes(
    model: 'AIR MAX 270 Gold',
    curentPrice: 199,
    oldPrice: 349,
    images: [
      'assets/shoes2_1.png',
      'assets/shoes2_2.png',
      'assets/shoes2_3.png',
    ],
    modelNumbers: 270,
    color: 0XFFFCF5EB
  ),

  NikeShoes(
    model: 'AIR MAX 95 red',
    curentPrice: 299,
    oldPrice: 399,
    images: [
      'assets/shoes3_1.png',
      'assets/shoes3_2.png',
      'assets/shoes3_3.png',
    ],
    modelNumbers: 95,
    color: 0XFFFEEEEF
  ),

  NikeShoes(
    model: 'AIR MAX 98 FREE',
    curentPrice: 149,
    oldPrice: 299,
    images: [
      'assets/shoes4_1.png',
      'assets/shoes4_2.png',
      'assets/shoes4_3.png',
    ],
    modelNumbers: 98,
    color: 0XFFEDF3FE
  ),
];