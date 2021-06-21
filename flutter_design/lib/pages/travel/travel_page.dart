import 'package:flutter/material.dart';
import 'package:flutter_design/models/travel_model.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class TravelPage extends StatefulWidget {
  static final routeName = 'travel';

  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> {
  
  TravelPhoto _selected = travelPhotos.last;
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final topCardHeight = size.height / 2;
    final horizontalListHeight = 160.0;

    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column( // adicional list Abajo
        children: [
          Expanded( // adicional list Abajo
            flex: 2, // adicional list Abajo
            child: Stack(
              children: [
                Positioned(
                  height: topCardHeight,
                  left: 0,
                  right: 0,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 700),
                    child: TravelPhotoDetails(
                      key: Key(_selected.name),
                      travelPhoto : _selected
                    ),
                  )
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: topCardHeight - horizontalListHeight / 2,
                  height: horizontalListHeight,
                  child: TravelPhotosList(
                    onPhotoSelected: (item){
                      setState(() {
                        _selected = item;
                      });
                    }
                  )
                ),
                Positioned(
                  top: topCardHeight - horizontalListHeight / 2 + horizontalListHeight ,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recomendation',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded( // adicional list Abajo
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:10.0),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: travelPhotos.length,
                itemBuilder: (_, int index) {
                  final  travelPhoto = travelPhotos[index];
                  return ListTile(
                    title: Text(travelPhoto.name, style: TextStyle(color: Colors.white),),
                    subtitle: Text('${travelPhoto.photos.toString()} photos', style: TextStyle(color: Colors.white),),
                    leading: Image.asset(travelPhoto.backImage),
                    onTap: (){
                      setState(() {
                        _selected = travelPhoto;
                      });
                    },
                  );
                }
              ),
            )
          )
        ],
      ),
    );
  }
}

class TravelPhotoDetails extends StatefulWidget {
  
  final TravelPhoto travelPhoto;

  const TravelPhotoDetails({Key? key,required this.travelPhoto}) : super(key: key);

  @override
  _TravelPhotoDetailsState createState() => _TravelPhotoDetailsState();
}

class _TravelPhotoDetailsState extends State<TravelPhotoDetails> with SingleTickerProviderStateMixin {

  AnimationController? _controller;
  final _movement = -100.0;
  
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    _controller!.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller!,
      builder: (context, _) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              left: _movement * _controller!.value,
              right: _movement * (1 - _controller!.value),
              child: Image.asset(
                widget.travelPhoto.backImage,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 40,
              left: 10,
              right: 10,
              height: 100,
              child: FittedBox(
                child: Text(
                  widget.travelPhoto.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}

class TravelPhotosList extends StatefulWidget {

  final ValueChanged<TravelPhoto> onPhotoSelected;

  const TravelPhotosList({Key? key,required this.onPhotoSelected}) : super(key: key);

  @override
  _TravelPhotosListState createState() => _TravelPhotosListState();
}

class _TravelPhotosListState extends State<TravelPhotosList> {

  final _animatedListKey = GlobalKey<AnimatedListState>();
  final _pageController = PageController();
  double page = 0.0;

  void _listenScroll() {
    setState(() {
      page = _pageController.page!;
    });
  }

  @override
  void initState() {
    _pageController.addListener(_listenScroll);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_listenScroll);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _animatedListKey,
      controller: _pageController,
      physics: PageScrollPhysics(),
      itemBuilder: (context, index, animation) {
        final travelPhoto = travelPhotos[index];
        final percent = page - page.floor();
        final factor = percent > 0.5 ? (1-percent) : percent ; 

        return InkWell(
          onTap: (){
            travelPhotos.insert(travelPhotos.length, travelPhoto);
            _animatedListKey.currentState!.insertItem(travelPhotos.length - 1);
            widget.onPhotoSelected(travelPhoto);

            final itemToDelete = travelPhoto;
            travelPhotos.removeAt(index);
            _animatedListKey.currentState!.removeItem(
              index, 
              (context, animation) => FadeTransition(
                opacity: animation,
                child: SizeTransition(
                  sizeFactor: animation,
                  axis: Axis.horizontal,
                  child: TravelPhotoListItem(travelPhoto: itemToDelete)
                ),
              )
            );
          },
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(
                vector.radians(
                  90 * (factor),
                ),
              ),
            child: TravelPhotoListItem(
              travelPhoto: travelPhoto,
            ),
          ),
        );
      },
      scrollDirection: Axis.horizontal,
      initialItemCount: travelPhotos.length,
    );
  }
}

class TravelPhotoListItem extends StatelessWidget {
  final TravelPhoto travelPhoto;

  const TravelPhotoListItem({Key? key,required this.travelPhoto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          width: 130,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  travelPhoto.backImage,
                  fit: BoxFit.cover
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spacer(),
                      Text(
                        travelPhoto.name,
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      Text(
                        '${travelPhoto.photos} photos',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}