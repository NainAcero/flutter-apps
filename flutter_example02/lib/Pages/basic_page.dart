import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasicPage extends StatefulWidget {
  @override
  _BasicPageState createState() => _BasicPageState();
}

class _BasicPageState extends State<BasicPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 16 / 11,
                child: LayoutBuilder(
                  builder: (_, constraints) {
                    return Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        ClipPath(
                          clipper: HeaderClipper(),
                          child: Container(
                            width: double.infinity,
                            color: Colors.black12,
                            child: Image.asset(
                              'assets/usuarios.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        Positioned(
                          bottom: 0,
                          right: 0,
                          width: constraints.maxWidth / 2,
                          child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            child: ClipPath(
                              clipper: ButtonCLipper(),
                              child: Container(
                                color: Colors.orangeAccent,
                                height: constraints.maxHeight * 0.4,
                                child: Align(
                                  alignment: Alignment(0.5, 0.0),
                                  child: Icon(
                                    Icons.play_arrow,
                                    size: 40,
                                    color: Colors.white,
                                  )
                                )
                              )
                            )
                          )
                        )
                      ]
                    );
                  }
                )
              )
            ]
          )
        ),
      )
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    path.lineTo(0, size.height / 2);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
    }
  
    @override
    bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

}

class ButtonCLipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
      final Path path = Path();
      path.moveTo(size.width * 0.1, size.height * 0.44);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
      return path;
    }
  
    @override
    bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

}