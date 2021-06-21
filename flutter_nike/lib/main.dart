import 'package:flutter/material.dart';
import 'package:flutter_nike/nike_shoes.dart';
import 'package:flutter_nike/nike_shoes_details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NikeShoesStoreHome()
    );
  }
}

class NikeShoesStoreHome extends StatelessWidget {

  final ValueNotifier<bool> notifierBottomBarVisible = ValueNotifier(true);

  void _shoesPressed(NikeShoes nikeShoes, BuildContext context) async{
    notifierBottomBarVisible.value = false;
    await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) {
          return FadeTransition(
            opacity: animation1,
            child: NikeShoesDetails(
              nikeShoes: nikeShoes,
            ),
          );
        }
      )
    );
    notifierBottomBarVisible.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset('assets/nike_logo.png', height: 40,),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 40),
                        itemCount: shoes.length,
                        itemBuilder: (context, index){
                          final shoesItem = shoes[index];
                          return NikeShoesItem(
                            shoesItem: shoesItem,
                            onTap: () {
                              _shoesPressed(shoesItem, context);
                            },
                          );
                        }
                      ),
                    ),
                  ],
                ),
              ),
              ValueListenableBuilder<bool>(
                child: Container(
                  color: Colors.white.withOpacity(0.7),
                  child: Row(
                    children: [
                      Expanded(
                        child: Icon(Icons.home),
                      ),
                      Expanded(
                        child: Icon(Icons.search),
                      ),
                      Expanded(
                        child: Icon(Icons.favorite_border),
                      ),
                      Expanded(
                        child: Icon(Icons.shopping_cart),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {}, 
                          child: Center(
                            child: CircleAvatar(
                              radius: 13,
                              backgroundImage: AssetImage(
                                'assets/nain.jpg'
                              ),
                            ),
                          )
                        )
                      ),
                    ],
                  ),
                ),
                valueListenable: notifierBottomBarVisible,
                builder: (context, value, child) {
                  return AnimatedPositioned(
                    duration: const Duration(milliseconds: 200),
                    left: 0,
                    right: 0,
                    bottom: value ? 0.0 : -kToolbarHeight,
                    height: kToolbarHeight,
                    child: child!
                  );
                }
              )
            ],
          )
        ),
      );
  }
}

class NikeShoesItem extends StatelessWidget {

  final NikeShoes shoesItem;
  final VoidCallback onTap;

  const NikeShoesItem({Key? key,required this.shoesItem,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    const itemHeight = 320.0;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: SizedBox(
          height: itemHeight,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: Hero(
                  tag: 'background_${shoesItem.model}',
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Color(shoesItem.color),
                    ),
                  ),
                )
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Hero(
                  tag: 'number_${shoesItem.model}',
                  child: SizedBox(
                    height: itemHeight * 0.6,
                    child: Material(
                      color: Colors.transparent,
                      child: FittedBox(
                        child: Text(
                          shoesItem.modelNumbers.toString(),
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.05),
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 20, 
                left: 100,
                height: itemHeight * 0.65,
                child: Hero(
                  tag: 'image_${shoesItem.model}',
                  child: Image.asset(shoesItem.images.first, 
                    fit: BoxFit.contain,),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.grey
                ),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.grey
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      shoesItem.model,
                      style: TextStyle(
                        color: Colors.grey
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      '\$${shoesItem.oldPrice.toInt().toString()}',
                      style: TextStyle(
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      '\$${shoesItem.curentPrice.toInt().toString()}',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}