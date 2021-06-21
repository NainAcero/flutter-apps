import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:flutter_face_detector/utils/face_detector_painter.dart';
import 'package:flutter_face_detector/utils/utils_scanner.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CameraController? cameraController;
  late CameraDescription cameraDescription;
  late FaceDetector faceDetector;
  CameraLensDirection cameraLensDirection = CameraLensDirection.back;
  bool isworking = false;
  Size? size;
  late List<Face> faceList;

  initCamera() async {
    cameraDescription = await UtilScanner.getCamera(
      cameraLensDirection
    );

    cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.medium
    );

    faceDetector = FirebaseVision.instance.faceDetector(
      FaceDetectorOptions(
        enableClassification: true,
        minFaceSize: 0.1,
        mode: FaceDetectorMode.fast
      )
    );

    cameraController!.initialize().then((value) {
      if(!mounted) return;

      cameraController!.startImageStream((imageFromStream) {
        if(!isworking) {
          isworking = true;

          // implementar faceDetection
          performDetectionOnStreamFrame(imageFromStream);
        }
      });
    });
  }

  dynamic? scannResult;

  performDetectionOnStreamFrame(CameraImage imageFromStream) {
    UtilScanner.detect(
      image: imageFromStream, 
      detectInImage: faceDetector.processImage, 
      imageRotation: cameraDescription.sensorOrientation
    ).then((dynamic result) {
      setState(() {
        scannResult = result;
      });
    }).whenComplete(() {
      isworking = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  @override
  void dispose() {
    cameraController?.dispose();
    faceDetector.close();
    super.dispose();
  }

  toggleCamera() async {
    if(cameraLensDirection == CameraLensDirection.back) {
      cameraLensDirection = CameraLensDirection.front;
    } else {
      cameraLensDirection = CameraLensDirection.back;
    }

    await cameraController!.stopImageStream();
    await cameraController!.dispose();

    setState(() {
      cameraController = null;
    });

    initCamera();
  }

  Widget buildResult(){
    if(scannResult == null || cameraController == null || !cameraController!.value.isInitialized) {
      return Container();
    }

    final Size imageSize = Size(
      cameraController!.value.previewSize.height,
      cameraController!.value.previewSize.width
    );

    // customPainter
    CustomPainter customPainter = FaceDetectorPainter(
      imageSize, 
      scannResult, 
      cameraLensDirection
    );

    return CustomPaint(
      painter: customPainter,
    );
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> stackWidgetChildren = [];
    late final size = MediaQuery.of(context).size;

    if(cameraController != null){
      stackWidgetChildren.add(
        Positioned(
          top: 30,
          left: 0,
          width: size.width,
          height: size.height,
          child: Container(
            child: (cameraController!.value.isInitialized)
              ? AspectRatio(
                aspectRatio: cameraController!.value.aspectRatio,
                child: CameraPreview(cameraController),)
              : Container(),
          ),
        )
      );
    }

    stackWidgetChildren.add(
      Positioned(
        top: size.height - 250,
        left: size.width / 2 - 100,
        width: 200,
        height: 250,
        child: Container(
          margin: EdgeInsets.only(bottom: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    onPressed: (){
                      toggleCamera();
                    },
                    child: const Icon(Icons.camera, color: Colors.black, size: 40,),
                    backgroundColor: Colors.white,
                  ),
                  FloatingActionButton(
                    onPressed: (){
                      toggleCamera();
                    },
                    child: const Icon(Icons.people_alt_rounded, color: Colors.blue, size: 40,),
                    backgroundColor: Colors.white,
                  ),
                  FloatingActionButton(
                    onPressed: (){
                      toggleCamera();
                    },
                    child: const Icon(Icons.delete, color: Colors.red, size: 40,),
                    backgroundColor: Colors.white,
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Container(
                width: 160,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset("assets/nain.jpg", width: 25,),
                    Text("Nain Developer", style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),),
                  ],
                )
              ),
              SizedBox(height: 10,),
            ],
          ),
        ),
      )
    );

    stackWidgetChildren.add(
      Positioned(
        top: 30,
        left: 0.0,
        width: size.width,
        height: size.height,
        child: buildResult(),
      )
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 0),
        color: Colors.black,
        child: Stack(
          children: stackWidgetChildren,
        ),
      )
    );
  }
}