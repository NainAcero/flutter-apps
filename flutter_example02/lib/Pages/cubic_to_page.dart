import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CubicPage extends StatefulWidget {
  @override
  _CubicPageState createState() => _CubicPageState();
}

class _CubicPageState extends State<CubicPage> with SingleTickerProviderStateMixin {
  
  AnimationController? _controller;
  Animation<double>? _startAngle;

  @override
  void initState() {
    super.initState();
     _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 14),
    );

    _startAngle = Tween<double>(begin: -0.2, end: 1).animate(_controller!);
    _controller?.repeat();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Center(
        child: Column(
          children: [
            AppBar(
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => print('hi on menu icon'),
                  );
                },
              ), 
              title: Text('TRAVEL '),
              actions: <Widget>[
                IconButton(
                  icon: new Icon(Icons.merge_type),
                  onPressed: () => print('hi on icon action'),
                ),
              ],
            ),
            AnimatedBuilder(
              animation: _startAngle!,
              child: Container(
                width: double.infinity,
                height: 300,
                child: Image.asset(
                  'assets/usuarios.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              builder: (_, child) {
                return ClipPath(
                  clipper: CubicToClipper(
                    startWidth: _startAngle!.value,
                  ),
                  child: child,
                );
              }
             ),

            Transform.translate(
              offset: Offset(0, -30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CupertinoButton(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                  ),

                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    pressedOpacity: 0.8,
                    child: Container(
                      width: 60,
                      height: 60,
                      child: Icon(
                        Icons.people,
                        color: Colors.blueAccent,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            blurRadius: 5,
                            offset: Offset(0, 2)
                          )
                        ]
                      )
                    ),
                    onPressed: () {},
                  ),

                  CupertinoButton(
                    child: Icon(
                      Icons.share,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                    padding: EdgeInsets.all(10),
                  ),
                ]
              )
            ),
            
          ],
        ),
      ),
    );
  }
}

class CubicToClipper extends CustomClipper<Path> {

  final double startWidth;

  CubicToClipper({ required this.startWidth});

  @override
  Path getClip(Size size) {

    final Path path = Path();
    path.lineTo(0, size.height*0.85);
    final Offset n1 =Offset(size.width*0.50,size.height);
    final Offset n2 =Offset(size.width*startWidth,size.height*0.3);
    path.cubicTo(n1.dx, n1.dy, n2.dx, n2.dy, size.width, size.height*0.85);

    path.lineTo(size.width,0);
    return path;
  }
  
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;

}