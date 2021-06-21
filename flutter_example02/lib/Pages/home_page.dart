import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black12,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverSafeArea(
              bottom: false,
              sliver: SliverGrid.count(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: <Widget>[
                  Container(
                    color: Colors.red,
                  ),
                  Container(
                    color: Colors.red,
                  ),
                  Container(
                    color: Colors.red,
                  ),
                  Container(
                    color: Colors.red,
                  ),
                  Container(
                    color: Colors.red,
                  ),
                  Container(
                    color: Colors.red,
                  ),
                ]
              )
            ),

            SliverList(
              delegate: SliverChildListDelegate(
                [
                   Container(
                    height: 100,
                    color: Colors.red,
                    margin: EdgeInsets.only(top: 10),
                  ),
                  Container(
                    height: 100,
                    color: Colors.blue,
                  ),
                  Container(
                    height: 100,
                    color: Colors.green,
                  ),
                  Container(
                    height: 100,
                    color: Colors.yellow,
                  ),
                ],
              ),
            ),

            SliverGrid(
              delegate: SliverChildBuilderDelegate((_, index) {
                return Container(
                  color: Colors.purple,
                );
              }, childCount: 50, ),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 50,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 16/9
              )
            ),

            SliverToBoxAdapter(
              child: Container(
                height: 200,
                margin: EdgeInsets.all(10),
                color: Colors.redAccent,
                child: Row(
                  children: <Widget>[
                    CupertinoButton(
                      color: Colors.blue,
                      child: Text("Button 1", style: TextStyle(color: Colors.white)),
                      onPressed: () {},
                    ),
                    CupertinoButton(
                      color: Colors.blue,
                      child: Text("Button 1", style: TextStyle(color: Colors.white)),
                      onPressed: () {},
                    ),
                  ]
                )
              )
            ),

            SliverSafeArea(
              top: false,
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, index) {
                    return Container(
                      color: Colors.black38,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(15),
                      child: Text("sliverList 2: $index"),
                    );
                  },
                  childCount: 40,
                )
              )
            )
          ]
        )
      )
    );
  }
}