import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvatarButton extends StatelessWidget {
  final double imageSize;
  const AvatarButton({Key key, this.imageSize = 100}) : super(key: key);
  @override
  Widget build(BuildContext context) {
  return  Stack(
    children: <Widget>[
      Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black26,
              offset: Offset(0, 20)
            ),
          ],
        ),
        child: ClipOval(
        child: Image.network(
          'https://codahosted.io/docs/IZn3UNbEOU/blobs/bl-137mEqTBzf/8e04b9feef4481efc0616766fb5547e099f3b5a7ecf18c5d6e1b03bbacdb9c9d74ac9f8cc0b5457d5ea1700a7cd5f866942616013c01cff01c2641e5ce293e4f9733859c5858dc1c3f1738355e8591ffd8fca9311e1e2283bb8ea449f5307c52c0dec951',
          width: this.imageSize,
          height: this.imageSize
        ),
      ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            child: Icon(
              Icons.add,
              color: Colors.white
            ),
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              color: Colors.pinkAccent,
              shape: BoxShape.circle,
            ),
          ),
          onPressed: () {},
        ),
      ),
    ],
  );
  }
}