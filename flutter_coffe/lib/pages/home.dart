import 'package:flutter/material.dart';
import 'package:flutter_coffe/coffee.dart';
import 'package:flutter_coffe/pages/coffe_bloc.dart';
import 'package:flutter_coffe/pages/coffee_concept_details.dart';

const _duration = Duration(milliseconds: 300);
const _initialPage = 8.0;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    final bloc = CoffeeProvider.of(context).bloc;
    bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final bloc = CoffeeProvider.of(context).bloc;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            left: 20,
            right: 20,
            bottom: -size.height * 0.22,
            height: size.height * 0.3,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown,
                    blurRadius: 90,
                    spreadRadius: 45
                  )
                ]
              ),
            ),
          ),
          ValueListenableBuilder<double>(
              valueListenable: bloc.currentPage,
              builder: (context, currentPage, _) {
                return Transform.scale(
            scale: 1.6,
            alignment: Alignment.bottomCenter,
            child: PageView.builder(
                  controller: bloc.pageCoffeeController,
                  scrollDirection: Axis.vertical,
                  itemCount: coffees.length + 1,
                  onPageChanged: (value) {
                    if(value < coffees.length) {
                      bloc.pageTextController.animateToPage(
                        value, 
                        duration: _duration, 
                        curve: Curves.easeOut
                      );
                    }
                  },
                  itemBuilder: (BuildContext context, int index) {  
                    if(index == 0){
                      return const SizedBox.shrink();
                    }
                    final coffee = coffees[index - 1];
                    final result = currentPage - index + 1;
                    final value = -0.4 * result + 1;
                    final opacity = value.clamp(0.0, 1.0);

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            transitionDuration: const Duration(milliseconds: 650),
                            pageBuilder: (context, animation, _) {
                              return FadeTransition(
                                opacity: animation,
                                child: CoffeeConceptDeatails(coffee: coffee,),
                              );
                            }
                          )
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Transform(
                          alignment: Alignment.bottomCenter,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..translate(0.0, size.height / 2.6 * (1 - value).abs())
                            ..scale(value),
                          child: Opacity(
                            opacity: opacity,
                            child: Hero(
                              tag: coffee.name,
                              child: Image.asset(
                                coffee.image,
                                fit: BoxFit.fitHeight,
                              ),
                            )
                          )
                        ),
                      ),
                    );
                  
              }),
            );
          }),
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            height: 100,
            child: CoffeeHeader()
          ),
        ],
      ),
    );
  }
}

class CoffeeHeader extends StatelessWidget {

  const CoffeeHeader();

  @override
  Widget build(BuildContext context) {

    final bloc = CoffeeProvider.of(context).bloc;
    final size = MediaQuery.of(context).size;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: 0.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0.0 , -100 * value),
          child: child,
        );
      },
      duration: _duration,
      child: ValueListenableBuilder<double>(
        valueListenable: bloc.textPage,
        builder: (context, textPage, _) {
          return Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: coffees.length,
                  controller: bloc.pageTextController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final opacity = (1 - (index - textPage).abs()).clamp(0.0, 1.0);
                    return Opacity(
                      opacity: opacity,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
                        child: Hero(
                          tag: "text_${coffees[index].name}",
                          child: Material(
                            child: Text(
                              coffees[index].name,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w800
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 15,),
              AnimatedSwitcher(
                duration: _duration,
                child: Text(
                  '\$${coffees[textPage.toInt()].price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                  key: Key(coffees[textPage.toInt()].name),
                ),
              )
            ],
          );
        }
      ),
    );
  }
}