import 'package:flutter/material.dart';
import 'package:flutter_design/utils/covid_2/colors.dart';
import 'package:flutter_design/utils/covid_2/constant.dart';

class DetailPage extends StatefulWidget {
  static final routeName = 'detail';

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: getBody(),
    );
  }

  Widget getBody(){
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: 50),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Icon(Icons.arrow_back_ios, color: bgColor,),
              ),
            ),
            Container(
              height: size.height,
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Self Check up \nfor Covid19",style: appTitle,),
                          Image.asset("assets/covid2/image_2.png")
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 170),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(70))
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 170,
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 4,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          color: textWhite,
                                          borderRadius: BorderRadius.circular(4)
                                        ),
                                      ),
                                      Container(
                                        height: 3,
                                        width: size.width - 130,
                                        decoration: BoxDecoration(
                                          color: textWhite.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(4)
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text("1/10",style: TextStyle(color: textWhite),),
                              ],
                            ),
                            SizedBox(height: 40,),
                            Text("Have you\nexperienced any\nof the following\nsymptoms:",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold,color: textWhite,height: 1.6),),
                            SizedBox(height: 40,),
                            Text("Fever,Cough,Sneezing,\nSor Throat, Difficult in Breasthing",style: TextStyle(
                              height: 1.7,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: textWhite
                            ),),
                            SizedBox(height: 40,),
                            Row(
                              children: [
                                Container(
                                  width: (size.width -120) /2,
                                  child: FlatButton(
                                    color: textWhite,
                                    onPressed: (){},
                                    child: Text("No",style: TextStyle(fontSize: 18),),
                                  ),
                                ),
                                SizedBox(width: 40,),
                                Container(
                                  width: (size.width -120) /2  ,
                                  child: FlatButton(
                                    color: textWhite,
                                    onPressed: (){}, 
                                    child: Text("Yes",style: TextStyle(fontSize: 18),)
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}