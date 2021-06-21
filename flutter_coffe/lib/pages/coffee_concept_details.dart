import 'package:flutter/material.dart';
import 'package:flutter_coffe/coffee.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:url_launcher/url_launcher.dart';

class CoffeeConceptDeatails extends StatelessWidget {

  final Coffee coffee;

  const CoffeeConceptDeatails({Key? key,required this.coffee}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    void launchWhatsApp() async {
      final link = WhatsAppUnilink(
        phoneNumber: '+51-931375941',
        text: "*Café: ${coffee.name} \n *Precio: \$${coffee.price.toStringAsFixed(2)} \n *Tamaño: S ",
      );
      await launch('$link');
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
            child: Hero(
              tag: coffee.name,
              child: Material(
                child: Text(
                  "text_${coffee.name}",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30,),
          SizedBox(
            height: size.height * 0.40,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Hero(
                    tag: coffee.image,
                    child: Image.asset(
                      coffee.image,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Positioned(
                  left: size.width * 0.05,
                  bottom: 0,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 1.0, end: 0.0),
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(-100 * value , 240 * value),
                        child: child,
                      );
                    },
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      '\$${coffee.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        shadows: [
                          BoxShadow(
                            color: Colors.black45,
                            blurRadius: 10,
                            spreadRadius: 20,
                          )
                        ]
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: size.width * 0.15,
                  top: 0,
                  child: FloatingActionButton(
                    backgroundColor: Colors.white70,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        "assets/whatsapp.png"
                      ),
                    ),
                    onPressed: launchWhatsApp,
                  )
                )
              ],
            ),
          ),
          SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/taza_s.png",
                      width: 50,
                      color: Colors.black87,
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "S",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black87
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/taza_m.png",
                      width: 50,
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "M",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.grey[500]
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/taza_l.png",
                      width: 50,
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "B",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.grey[500]
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Expanded(
            child: Container(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      "Hot / War Man",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                  ),
                )
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: RaisedButton(
                    color: Colors.white,
                    textColor: Colors.black87,
                    child: Text(
                      "Cold / Ice",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                    
                  onPressed: () {
                  // codigo del la acción a realizar
                  }),
                )
              )
            ],
          )
        ],
      ),
    );
  }
}