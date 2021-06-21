
class TravelPhoto {
  const TravelPhoto({
    required this.backImage,
    required this.frontImage,
    required this.name,
    required this.photos
  });

  final String backImage;
  final String frontImage;
  final String name;
  final int photos;
}

final travelPhotos = [
  TravelPhoto(
    backImage: 'assets/imagen01.jpg', 
    frontImage: 'assets/imagen01.jpg', 
    name: 'Chichén Itzá', 
    photos: 001
  ),
  TravelPhoto(
    backImage: 'assets/imagen02.jpg', 
    frontImage: 'assets/imagen02.jpg', 
    name: 'El Coliseo de Roma', 
    photos: 002
  ),
  TravelPhoto(
    backImage: 'assets/imagen03.jpg', 
    frontImage: 'assets/imagen03.jpg', 
    name: 'Cristo Redentor', 
    photos: 003
  ),
  TravelPhoto(
    backImage: 'assets/imagen04.jpg', 
    frontImage: 'assets/imagen04.jpg', 
    name: 'La Gran Muralla', 
    photos: 004
  ),
  TravelPhoto(
    backImage: 'assets/imagen05.jpg', 
    frontImage: 'assets/imagen05.jpg', 
    name: 'Machu Picchu', 
    photos: 005
  ),
  TravelPhoto(
    backImage: 'assets/imagen06.jpg', 
    frontImage: 'assets/imagen06.jpg', 
    name: 'Petra', 
    photos: 006
  ),
  TravelPhoto(
    backImage: 'assets/imagen07.jpg', 
    frontImage: 'assets/imagen07.jpg', 
    name: 'El Taj Mahal', 
    photos: 007
  ),
];