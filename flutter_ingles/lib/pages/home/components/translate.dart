import 'package:flutter/material.dart';
import 'package:flutter_ingles/pages/camera/camera.dart';
import 'package:flutter_ingles/widgets/icon.dart';

class Translate extends StatefulWidget {
  @override
  _TranslateState createState() => _TranslateState();
}

class _TranslateState extends State<Translate> {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withOpacity(0.2))
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration.collapsed(
              hintText: "Search",
              border: InputBorder.none,
            ),
            minLines: 8,
            maxLines: 8,
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconWidget(
                    padding: const EdgeInsets.symmetric(horizontal: 10), 
                    icon: Icons.camera_alt, 
                    onTap: (){
                      Navigator.pushNamed(context, CameraPage.routeName);
                    }
                  ),
                  IconWidget(
                    padding: const EdgeInsets.symmetric(horizontal: 10), 
                    icon: Icons.keyboard_voice, 
                    onTap: (){

                    }
                  ),
                  IconWidget(
                    padding: const EdgeInsets.symmetric(horizontal: 10), 
                    icon: Icons.volume_up_outlined, 
                    onTap: (){

                    }
                  ),
                ],
              ),
              InkWell(
                onTap: (){
                  
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red,
                  ),
                  child: Text(
                    "Translate",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}