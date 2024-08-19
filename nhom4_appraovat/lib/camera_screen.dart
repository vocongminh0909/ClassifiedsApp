import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScreen({Key? key, required this.camera}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late dynamic chuoihinh = '';
  late dynamic image;
  int imagenum = 0;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quét hình ảnh'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.72,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    // Hiển thị CameraPreview
                      child: Column(
                        children: [
                          Expanded(
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.79,
                                width: MediaQuery.of(context).size.width * 0.95,
                                child: CameraPreview(_controller),
                              ))
                        ],
                      ));
                } else {
                  // Nếu CameraController chưa được khởi tạo xong
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Text(
            'Số trang đã chụp:$imagenum',
            style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.019),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
                    ),
                    child: Icon(
                      Icons.folder,
                      size: MediaQuery.of(context).size.height * 0.04,
                    ),
                    onPressed: () async {
                      print(chuoihinh);
                      try {
                        final anhlay = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 100);
                        if (anhlay == null) return;
                        setState(() {
                          chuoihinh = chuoihinh + '|' + anhlay.path;
                          setState(() {
                            imagenum = imagenum + 1;
                          });
                        });
                      } on PlatformException catch (e) {
                        print('Fail to pick a picture: $e');
                      }
                    }),
              ),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: MediaQuery.of(context).size.height * 0.04,
                    ),
                    onPressed: () async {
                      await _initializeControllerFuture;
                      // Chụp ảnh
                      image = await _controller.takePicture();
                      AwesomeDialog(
                        context: context,
                        animType: AnimType.scale,
                        dialogType: DialogType.noHeader,
                        body: Image.file(File(image.path)),
                        btnCancelText: 'Chụp lại',
                        btnCancelOnPress: () {},
                        btnOkText: 'Xác nhận',
                        btnOkOnPress: () {
                          chuoihinh = chuoihinh + '|' + image.path;
                          setState(() {
                            imagenum = imagenum + 1;
                          });
                        },
                      ).show();
                    }),
              ),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
                    ),
                    child: Icon(
                      Icons.check_sharp,
                      size: MediaQuery.of(context).size.height * 0.04,
                    ),
                    onPressed: () {
                      print(chuoihinh);
                      if (chuoihinh == '') {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          headerAnimationLoop: false,
                          title: 'Lỗi',
                          desc: 'Bạn chưa chụp hình',
                          btnOkOnPress: () {},
                          btnOkIcon: Icons.cancel,
                          btnOkColor: Colors.red,
                        ).show();
                      } else {
                        Navigator.pop(context, chuoihinh);
                      }
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
