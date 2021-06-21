
import 'package:flutter_design/models/ebook/book.dart';

const _bookAsset = 'assets/ebook';
final bookAppBackground = '$_bookAsset/Bg.png';

final books = const [
  Book(
    title: 'Wink Poppy Midnight', 
    author: 'April Genevieve Tucholke', 
    image: '$_bookAsset/book1.jpg'
  ),
  Book(
    title: 'Walking with Miss Millie', 
    author: 'Tamara Bundy', 
    image: '$_bookAsset/book2.jpg'
  ),
  Book(
    title: 'Trio', 
    author: 'Sarah Tolmie', 
    image: '$_bookAsset/book3.jpg'
  ),
  Book(
    title: 'The Junble Book', 
    author: 'Rudyard Kipling', 
    image: '$_bookAsset/book4.jpg'
  ),
  Book(
    title: 'The Maker of Swans', 
    author: 'Paraig O\'Donnell', 
    image: '$_bookAsset/book5.jpg'
  ),
];