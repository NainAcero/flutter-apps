import 'package:flutter/material.dart';
import 'package:flutter_design/models/travel2_model.dart';
import 'package:flutter_design/pages/travel_2/destination_detail.dart';
import 'package:flutter_design/pages/travel_2/style.dart';
import 'package:flutter_design/utils/travel_2/colors.dart';
import 'package:flutter_design/utils/travel_2/constant.dart';

class Travel2_Page extends StatelessWidget {
  static final routeName = 'travel2';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: Container(
        width: size.width - 80,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColor.darkSecondaryColor,
              AppColor.lightTertiaryColor
            ],
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: (){}, 
              icon: Icon(Icons.home, color: Colors.white38, size: 40,),
            ),
            IconButton(
              onPressed: (){}, 
              icon: Icon(Icons.place, color: AppColor.primaryColor, size: 40,),
            ),
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/nain.jpg'),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColor.secondaryColor,
              AppColor.tertiaryColor,
            ]
          )
        ),
        child: ListView(
          children: [
            customAppBar(),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: destination.length,
                itemBuilder: (context, index) {

                  final destino = destination[index];
                  return Padding(
                    padding: EdgeInsets.only(left: index == 0? 30: 0),
                    child: DestiantionCard(size: size, destino: destino),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25, right: 25, bottom: 30, top: 50
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryText(
                    text: 'Hot Destination',
                    size: 24,
                  ),
                  PrimaryText(
                    text: 'More',
                    size: 16,
                    color: Colors.white38,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: hotDestination.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final destino = hotDestination[index];
                  return Padding(
                    padding: EdgeInsets.only(left: index == 0 ? 30 : 0),
                    child: hotDestiantionCard(size: size,destino: destino),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25, right: 25, bottom: 30, top: 50
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryText(
                    text: 'Visitier Reviews',
                    size: 18,
                  ),
                  PrimaryText(
                    text: '22 Reviews',
                    size: 16,
                    color: Colors.white38,
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 25, right: 25, bottom: 30
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                        image: AssetImage('assets/nain.jpg')
                      )
                    ),
                  ),
                  SizedBox(width: 20,),
                  SizedBox(
                    width: size.width - 100,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PrimaryText(
                              text: 'Nain Acero',
                              size: 14,
                            ),
                            PrimaryText(
                              text: 'Jan 25',
                              size: 12,
                              color: Colors.white38,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        PrimaryText(
                          text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries',
                          size: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.white38
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 70,)
          ],
        ),
      ),
    );
  }

  Padding customAppBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 50, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PrimaryText(
            text: 'Destination',
            size: 32,
            fontWeight: FontWeight.w700,
          ),
          RawMaterialButton(
            constraints: BoxConstraints(minWidth: 0),
            onPressed: null,
            elevation: 2.0,
            fillColor: Colors.white10,
            padding: EdgeInsets.all(8),
            child: Icon(Icons.search_rounded,
            color: AppColor.primaryColor, size: 30),
            shape: CircleBorder(),
          )
        ],
      ),
    );
  }
}

class DestiantionCard extends StatelessWidget {
  
  const DestiantionCard({
    Key? key,
    required this.size, required this.destino,
  }) : super(key: key);

  final Size size;
  final Travel2 destino;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          width: size.width - 60,
          margin: EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(destino.imagePath),
              fit: BoxFit.cover
            )
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            height: 200,
            width: size.width - 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  AppColor.secondaryColor,
                  Colors.transparent
                ]
              )
            ),
          ),
        )
      ],
    );
  }
}


class hotDestiantionCard extends StatelessWidget {

  const hotDestiantionCard({
    Key? key,
    required this.size, required this.destino,
  }) : super(key: key);

  final Size size;
  final Travel2 destino;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => DestinationDetail(
          destino: destino,
        )));
      },
      child: Stack(
        children: [
          Hero(
            tag: destino.imagePath,
            child: Container(
              height: 200,
              width: 160,
              margin: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(destino.imagePath),
                  fit: BoxFit.cover
                )
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              height: 200,
              width: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    AppColor.secondaryColor,
                    Colors.transparent
                  ]
                )
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            left: 25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimaryText(
                  text: destino.placeName,
                  size: 14,
                ),
                SizedBox(height: 5,),
                PrimaryText(
                  text: '${destino.placeCount} Tourist Places',
                  size: 10,
                  color: Colors.white54,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
