import 'package:flutter/material.dart';

class SliverAppBarPage extends StatefulWidget {
  @override
  _SliverAppBarPageState createState() => _SliverAppBarPageState();
}

class _SliverAppBarPageState extends State<SliverAppBarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[

          SliverAppBar(
            pinned: true,
            floating: true,
            leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.search), onPressed: () {}),
              IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
            ],
             expandedHeight: 300,
             flexibleSpace: FlexibleSpaceBar(
               title: Text("Slivers with flutter"),
               centerTitle: true,
               background: Stack(
                 fit: StackFit.expand,
                 children: <Widget>[
                   Image.network(
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                    fit: BoxFit.cover,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                         colors: [Colors.black26, Colors.black54],
                         begin: Alignment.topCenter,
                         end: Alignment.bottomCenter
                      )
                    )
                  )
                 ]
               )
             )
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate((_, index) {
              return ListTile(
                title: Text("item $index"),
              );
            }),
          )

        ]
      )
    );
  }
}