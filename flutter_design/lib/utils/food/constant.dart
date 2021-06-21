
import 'package:flutter_design/models/categoria.dart';
import 'package:flutter_design/models/food/food.dart';
import 'package:flutter_design/models/food/ingredient.dart';

const foodCategoryList = [
  Categoria(name: 'Pizza', imagePath: 'assets/food/pizza.svg'),
  Categoria(name: 'Seafood', imagePath: 'assets/food/sea-food.svg'),
  Categoria(name: 'Soft Drinks', imagePath: 'assets/food/coke.svg'),
  Categoria(name: 'Pizza', imagePath: 'assets/food/pizza.svg'),
];

const popularFoodList = [
  Food(imagePath: 'assets/food/pizza.png', star: 5.0, name: 'Primavera Pizza', weight: 'Weight 540 gr'),
  Food(imagePath: 'assets/food/pizza-1.png', star: 4.5, name: 'Cheese Pizza', weight: 'Weight 200 gr'),
  Food(imagePath: 'assets/food/salad.png', star: 4.5, name: 'Healthy Salad', weight: 'Weight 200 gr'),
  Food(imagePath: 'assets/food/sandwhich.png', star: 4.0, name: 'Grilled Sandwhich', weight: 'Weight 250 gr'),
  Food(imagePath: 'assets/food/chowmin.png', star: 4.0, name: 'Cheese Chowmin', weight: 'Weight 500 gr'),
];

const ingredients = [
  Ingredient(imagePath: 'assets/food/tomato.png'),
  Ingredient(imagePath: 'assets/food/onion.png'),
  Ingredient(imagePath: 'assets/food/tomato.png'),
  Ingredient(imagePath: 'assets/food/onion.png'),
  Ingredient(imagePath: 'assets/food/tomato.png'),
  Ingredient(imagePath: 'assets/food/onion.png'),
];