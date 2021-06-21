import 'package:flutter/material.dart';
import 'package:flutter_ingles/utils/constants.dart';
import 'package:line_icons/line_icons.dart';

class AppBarComp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text('Inglés'),
              SizedBox(width: 5,),
              Icon(LineIcons.angleDown, size: 15,)
            ],
          ),
          Icon(LineIcons.alternateExchange),
          Row(
            children: [
              Text('Español'),
              SizedBox(width: 5,),
              Icon(LineIcons.angleDown, size: 15,)
            ],
          )
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              } ).toList();
            },
          ),
        )
      ],
    );
  }

  void choiceAction(String choice) {
    print("$choice");
  }
}