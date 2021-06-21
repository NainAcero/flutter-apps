import 'package:flutter/material.dart';
import '../../style.dart';

class MyMessageCard extends StatelessWidget {

  const MyMessageCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310,
      padding: EdgeInsets.all(21),
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          color: Style.darkColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
            bottomLeft: Radius.circular(28),
          )),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              'Cuando quieres crear un widget de un tamaño específico le agregas como parent ',
            ),
          ),
        ],
      ),
    );
  }
}