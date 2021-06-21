
import 'package:flutter/material.dart';
import 'package:flutter_nike/nike_shoes.dart';
import 'package:flutter_nike/nike_shopping_cart.dart';
import 'package:flutter_nike/shake_transition.dart';

class NikeShoesDetails extends StatelessWidget {

  final NikeShoes nikeShoes;
  final ValueNotifier<bool> notifierBottomBarVisible = ValueNotifier(false);

  NikeShoesDetails({Key? key,required this.nikeShoes}) : super(key: key);

  void _openShoppingCart(BuildContext context) async{

    notifierBottomBarVisible.value = false;
    await Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
      pageBuilder: (_, animation1, __) {
        return FadeTransition(
          opacity: animation1,
          child: NikeShopping(
            shoes: nikeShoes,
          ),
         );
      })
    );
    notifierBottomBarVisible.value = true;
  }
    
  Widget _build_carousel(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return  SizedBox(
      height: size.height * 0.5,
      child: Stack(
        children: [
          Positioned.fill(
            child: Hero(
              tag: 'background_${nikeShoes.model}',
              child: Container(
                color: Color(nikeShoes.color),
              ),
            ),
          ),

          Positioned(
            left: 70,
            right: 70,
            top: 10,
            child: Hero(
              tag: 'number_${nikeShoes.model}',
              child: ShakeTransition(
                duration: Duration(milliseconds: 1400),
                axis: Axis.vertical,
                offset: 15,
                child: Material(
                  color: Colors.transparent,
                  child: FittedBox(
                    child: Text(
                      nikeShoes.modelNumbers.toString(),
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

          PageView.builder(
            itemCount: nikeShoes.images.length,
            itemBuilder: (context, index) {

            final tag = index == 0? 'image_${nikeShoes.model}' : 'image_${nikeShoes.model}_$index';

            return Container(
              alignment: Alignment.center,
              child: ShakeTransition(
                duration: index == 0 ? const Duration(milliseconds: 900) : Duration.zero,
                axis: Axis.vertical,
                offset: 10,
                child: Hero(
                  tag: tag,
                  child: Image.asset(
                    nikeShoes.images[index],
                    height: 240,
                    width: 240,
                  ),
                ),
              ),
            );
          },)
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      notifierBottomBarVisible.value = true;
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset(
          'assets/nike_logo.png',
          height: 40,
        ),
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [

            Positioned.fill(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _build_carousel(context),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ShakeTransition(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  nikeShoes.model,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),

                                const Spacer(),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '\$${nikeShoes.oldPrice.toInt().toString()}',
                                        style: TextStyle(
                                          color: Colors.red,
                                          decoration: TextDecoration.lineThrough,
                                          fontSize: 12,
                                        ),
                                      ),

                                      Text(
                                        '\$${nikeShoes.curentPrice.toInt().toString()}',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          ShakeTransition(
                            duration: const Duration(milliseconds: 1100),
                            child: Text(
                              'AVAILABLE SIZES',
                              style: TextStyle(
                                fontSize: 11
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          ShakeTransition(
                            duration: const Duration(milliseconds: 1100),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _ShoesSizeItem(text: '6'),
                                _ShoesSizeItem(text: '7'),
                                _ShoesSizeItem(text: '8'),
                                _ShoesSizeItem(text: '9'),
                                _ShoesSizeItem(text: '10'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20,),
                          ShakeTransition(
                            duration: const Duration(milliseconds: 1100),
                            child: Text(
                              'DESCRIPTION',
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          ShakeTransition(
                            duration: const Duration(milliseconds: 1100),
                            child: Text(
                              'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen.',
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                          const SizedBox(height: kToolbarHeight,),
                          
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

          ValueListenableBuilder<bool>(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  FloatingActionButton(
                    heroTag: 'fav_1',
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.favorite,
                      color: Colors.black,
                    ),
                    onPressed: (){},
                  ),
                  Spacer(),
                  FloatingActionButton(
                    heroTag: 'fav_2',
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.shopping_cart,
                    ),
                    onPressed: (){
                    _openShoppingCart(context);
                    },
                  ),
                ],
              ),
            ),
            valueListenable: notifierBottomBarVisible,
            builder: (context, value, child) {
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                left: 0,
                right: 0,
                bottom: value ? 0.0 : -kToolbarHeight * 1.5,
                child: child!
              );
            }
          )
        ],
      ),
    );
  }
}

class _ShoesSizeItem extends StatelessWidget {
  
  final String text;

  const _ShoesSizeItem({Key? key,required  this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Text(
        'US $text',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }
}