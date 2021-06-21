
import 'package:flutter/material.dart';
import 'package:flutter_nike/nike_shoes.dart';

const _bottonSizeWidth = 180.0;
const _bottonSizeHeight = 60.0;
const _buttonCircularSize = 60.0;
final _finalImageSize = 30.0;
final _imageSize = 140.0;

class NikeShopping extends StatefulWidget {

  final NikeShoes shoes;

  const NikeShopping({Key? key,required this.shoes}) : super(key: key);

  @override
  _NikeShoppingState createState() => _NikeShoppingState();
}

class _NikeShoppingState extends State<NikeShopping> with SingleTickerProviderStateMixin{

  AnimationController? _controller;
  Animation? _animationResize;
  Animation? _animationMovementIn;
  Animation? _animationMovementOut;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
    _animationResize = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller!, 
        curve: Interval(
          0.0,
          0.3
        ),
      )
    );

    _animationMovementIn = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller!, 
        curve: Interval(
          0.3,
          0.6,
          curve: Curves.fastLinearToSlowEaseIn
        ),
      )
    );

    _animationMovementOut = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller!, 
        curve: Interval(
          0.6,
          1.0,
          curve: Curves.bounceIn
        ),
      )
    );

    _controller!.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        Navigator.of(context).pop(true);
      }
    });
    super.initState();
  }

  @override
  void dispose(){
    _controller?.dispose();
    super.dispose();
  }

  Widget _buildPanel() {
    final size = MediaQuery.of(context).size;
    final currentImageSize = (_imageSize * _animationResize!.value).clamp(_finalImageSize, _imageSize);
    
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
      tween: Tween(begin: 1.0, end: 0.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(
            0.0,
            value * size.height * 0.6
          ),
          child: child,
        );
      },
      child: Container(
      height: (size.height * 0.6 * _animationResize!.value).clamp(
        _buttonCircularSize,
        size.height * 0.6
      ),
      width: (size.width * _animationResize!.value).clamp(
        _buttonCircularSize,
        size.width
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
          bottomLeft: _animationResize!.value == 1 ? Radius.circular(0) : Radius.circular(30),
          bottomRight: _animationResize!.value == 1 ? Radius.circular(0) : Radius.circular(30),
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment:_animationResize!.value == 1 ? MainAxisAlignment.start : MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Image.asset(
                  widget.shoes.images.first,
                  height: currentImageSize,
                ),
                if(_animationResize!.value == 1)
                ...[
                const SizedBox(width: 20,),
                Column(
                  children: [
                    Text(
                      widget.shoes.model,
                      style: TextStyle(
                        fontSize: 12
                      ),
                    ),
                    Text(
                      '\$${widget.shoes.curentPrice.toInt().toString()}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                      ),
                    )
                  ],
                ),
                ]
              ],
            ),
          )
        ],
      ),
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Material(
      color: Colors.transparent,
      child: AnimatedBuilder(
        animation: _controller!,
        builder: (context, child) {
          final buttonSizeWidth = ( _bottonSizeWidth * _animationResize!.value ).clamp(_buttonCircularSize, _bottonSizeWidth);
          final panelSizeWidth = (size.width * _animationResize!.value).clamp(_buttonCircularSize, size.width);
          
          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    color: Colors.black54,
                  ),
                ),
              ),
              Positioned.fill(
                child: Stack(
                  children: [
                    if(_animationMovementIn!.value != 1)
                    Positioned(
                      top: size.height * 0.4 + (_animationMovementIn!.value * size.height * 0.48),
                      left: size.width / 2 - panelSizeWidth / 2,
                      width: panelSizeWidth,
                      child: _buildPanel(),
                    ),
                    Positioned(
                      bottom: 40.0 - (_animationMovementOut!.value * 100),
                      left:( size.width / 2 ) - ( buttonSizeWidth / 2),
                      child: TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn,
                        tween: Tween(begin: 1.0, end: 0.0),
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(
                              0.0,
                              value * size.height * 0.6 
                            ),
                            child: child,
                          );
                        },
                        child: InkWell(
                          onTap: () {
                            _controller!.forward();
                          },
                          child: Container(
                            width: buttonSizeWidth,
                            height: ( _bottonSizeHeight * _animationResize!.value ).clamp(_buttonCircularSize, _bottonSizeHeight),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical:12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: Icon(
                                      Icons.shopping_cart,
                                      color: Colors.white,
                                    ),
                                  ),
                                  if(_animationResize!.value == 1) ...[
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      'ADD TO CART',
                                      style: TextStyle(
                                        color: Colors.white
                                      ),
                                    ),
                                  ),
                                  ]
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        }
      ),
    );
  }
}