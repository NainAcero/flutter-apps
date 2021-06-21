import 'package:flutter/material.dart';
import 'package:flutter_design/models/travel2_model.dart';
import 'package:flutter_design/pages/travel_2/style.dart';
import 'package:flutter_design/utils/travel_2/colors.dart';
import 'package:flutter_design/utils/travel_2/constant.dart';

class DestinationDetail extends StatefulWidget {
  final Travel2 destino;

  const DestinationDetail({Key? key,required this.destino}) : super(key: key);

  @override
  _DestinationDetailState createState() => _DestinationDetailState();
}

class _DestinationDetailState extends State<DestinationDetail> with SingleTickerProviderStateMixin{

  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    _controller?.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DestinationPage(
      controller: _controller,
      destino: widget.destino,
    );
  }
}

class DestinationPage extends StatelessWidget {

  final destino;
  DestinationPage(
      {Key? key, required AnimationController? controller,required this.destino})
      : animation = DestinationPageEnterAnimation(controller!),
        super(key: key);
  final DestinationPageEnterAnimation animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation.controller,
      builder: (context, child) => _buildAnimation(context),
    );
  }

  Hero _buildAnimation(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Hero(
      tag: destino.imagePath,
      child: Scaffold(
        floatingActionButton: ButtonTheme(
          minWidth: size.width - 60,
          height: 56,
          child: RaisedButton(
            onPressed: () {},
            color: AppColor.lightSecondary,
            child: PrimaryText(
              text: 'Select Location',
              size: 20,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: ListView(
          children: [
            Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(destino.imagePath),
                  fit: BoxFit.cover
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomAppBar(),
                  Container(
                    padding: EdgeInsets.only(top: 30, left: 30, right: 30),
                    height: animation.barHeight.value,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColor.secondaryColor,
                          AppColor.lightTertiaryColor
                        ]
                      )
                    ),
                    child: ListView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PrimaryText(
                              text: destino.placeName,
                              size: 24),
                            SizedBox(height: 10),
                            PrimaryText(
                              text:
                                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries.',
                              size: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white38),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PrimaryText(
                                  text: 'Tourist Places',
                                  size: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                                PrimaryText(
                                  text: destino.placeCount.toString(),
                                  size: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white24
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              height: 160,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: hotDestination.length,
                                itemBuilder: (context, index) {
                                  final destino = hotDestination[index];
                                  return Padding(
                                    padding: EdgeInsets.only(left: index == 0 ? 30 : 0),
                                    child: hotDestiantionCard(size: size, destino: destino,),

                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 5, right: 6, top: 20
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context), 
            icon: Icon(
              Icons.chevron_left,
              color: Colors.white70,
              size: 40,
            ),
          ),
          RawMaterialButton(
            onPressed: null,
            elevation: 2.0,
            shape: CircleBorder(),
            fillColor: Colors.white24,
            padding: EdgeInsets.all(8),
            child: Image.asset('assets/travel_2/info.png', width: 4,),
          )
        ],
      ),
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
          Container(
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

class DestinationPageEnterAnimation {
  DestinationPageEnterAnimation(this.controller)
       : barHeight = Tween<double>(begin: 0, end: 600).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0, 0.5),
          ),
        );

  final AnimationController controller;
  final Animation<double> barHeight;
}