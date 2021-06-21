import 'package:flutter/material.dart';
import 'package:flutter_design/utils/covid_2/colors.dart';

class CardStatus extends StatelessWidget {
  final IconData iconName;
  final Color colorCard;
  final String newCases;
  final String totalCases;
  final String status;

  const CardStatus({Key? key,
    required this.iconName, 
    required this.colorCard, 
    required this.newCases, 
    required this.totalCases, 
    required this.status
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: textWhite.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: colorCard.withOpacity(0.5),
                  border: Border.all(
                    color: colorCard,
                    width: 2
                  ),
                  borderRadius: BorderRadius.circular(40/2)
                ),
                child: Icon(iconName, color: colorCard),
              ),
              SizedBox(height: 15,),
              Text("[$newCases]",style: TextStyle(color: colorCard,fontSize: 15),),
              SizedBox(height: 15,),
              Text("$totalCases",style: TextStyle(color: colorCard,fontSize: 25,fontWeight: FontWeight.bold),),
              SizedBox(height: 15,),
              Text("$status",style: TextStyle(color: colorCard,fontSize: 16),),
            ],
          ),
        ),
      ),
    );
  }
}