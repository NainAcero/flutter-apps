import 'package:flutter/material.dart';

class PersistentHeaderPage extends StatefulWidget {
  @override
  _PersistentHeaderPageState createState() => _PersistentHeaderPageState();
}

class _PersistentHeaderPageState extends State<PersistentHeaderPage> {
  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: CustomScrollView(

        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: MyPersistentHeaderDelegate(
              username: "Nain Acero",
              statusBarHeight: statusBarHeight,
              maxExtentHeight: 400
            )
          ),

          
          SliverList(
            delegate: SliverChildBuilderDelegate((_, index) {
              return ListTile(
                title: Text("index $index"),
              );
            }, childCount: 100),
          ),

        ]

      )
    );
  }
}

class MyPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {

  final String username;
  final double maxExtentHeight, statusBarHeight;
  double minExtentHeight = 0;
  final double appBarSize = 60;

  MyPersistentHeaderDelegate({
    required this.username,
    required this.maxExtentHeight,
    required this.statusBarHeight,
  }) {
    minExtentHeight = this.appBarSize + this.statusBarHeight;
  }

  @override
  Widget build(BuildContext context, double offset, bool overlapsContent) {
      double headerHeight = this.maxExtent - offset;

      if (headerHeight < this.minExtent) {
        headerHeight = this.minExtent;
      }

      final tmp1 = headerHeight - this.minExtent;
      final tmp2 = this.maxExtent - this.minExtent;
      double delta = tmp1 / tmp2;

      double avatarSize = delta * 120 * 2;
      if (avatarSize < this.appBarSize) {
        avatarSize = this.appBarSize;
      }
      final double deviceWidth = MediaQuery.of(context).size.width;
      final double avatarOffsetX =
        (delta - 1) * (deviceWidth / 2 - avatarSize / 2);
      
      return SizedBox.expand(
        child: Container(
          color: Colors.blue,
          padding: EdgeInsets.only(top: this.statusBarHeight),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Transform.translate(
                offset: Offset(avatarOffsetX, 0),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage("https://scontent.ftcq1-1.fna.fbcdn.net/v/t1.6435-9/86806997_2528368077381517_7655119652762157056_n.jpg?_nc_cat=105&ccb=1-3&_nc_sid=174925&_nc_ohc=NYnleiWMp1gAX-CY_zi&_nc_ht=scontent.ftcq1-1.fna&oh=ad619dec194175a72ce2b3270f8a9df6&oe=608C303A"),
                    radius: avatarSize / 2,
                    backgroundColor: Colors.white,
                  ),
                ),
              ),

              Positioned(
                bottom: 20,
                child: Transform.scale(
                  scale: delta,
                  child: Opacity(
                    opacity: delta,
                    child: Text(
                    this.username,
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  )
                )
              )
            ]
          )
        )
      );
    }
  
    @override
    double get maxExtent => this.maxExtentHeight;
  
    @override
    double get minExtent => this.minExtentHeight;
  
    @override
    bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

}