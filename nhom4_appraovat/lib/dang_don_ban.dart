import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:nhom4_appraovat/camera_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart' as http;

import 'helper.dart';

class Dang_don_ban extends StatefulWidget {
  @override
  State<Dang_don_ban> createState() => _Dang_don_banState();
}

class _Dang_don_banState extends State<Dang_don_ban> {
  late SharedPreferences logindata;
  final _tensanpham = TextEditingController();
  final _giasanpham = TextEditingController();
  final _tinhtrang = TextEditingController();
  List<String> imagePathList = [];
  File? anh;
  List<String> listURL = ['','','',''];
  FocusNode focus_nut_luu = FocusNode();

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
  }

  uploadCloudinary() async {
    SmartDialog.showLoading(
      animationType: SmartAnimationType.scale,
      builder: (_) => const CustomLoading(type: 1),
    );
    listURL.clear();
    for (int i = 0; i < imagePathList.length; i++) {
      final url = Uri.parse('https://api.cloudinary.com/v1_1/dhmxqwkdr/upload');
      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = 'cnpmnc'
        ..files.add(await http.MultipartFile.fromPath('file', imagePathList[i]));
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);
        listURL.add(jsonMap['url']);
      }
    }
    SmartDialog.dismiss();
  }

  void splitString(String inputString) {
    List<String> stringList = inputString.split("|");
    for (int i = 1; i < stringList.length; i++) {
      String variableValue = stringList[i].trim();
      imagePathList.add(variableValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: CircleAvatar(
          child: InkWell(
            child: const Icon(Icons.add),
            onTap: () async {
              final cameras = await availableCameras();
              final firstCamera = cameras.first;
              imagePathList.clear();
              splitString(await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CameraScreen(camera: firstCamera)),
              ));
              uploadCloudinary();
              FocusScope.of(context).requestFocus(focus_nut_luu);
            },
          ),
        ),
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Đăng đơn bán',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          centerTitle: true, // Center-align the title
          backgroundColor: const Color.fromARGB(254, 255, 170, 0),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.08),
                    Text('Tên sản phẩm', style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.04)),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextField(
                    controller: _tensanpham,
                    maxLines: 1,
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.043),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.08),
                    Text('Giá sản phẩm', style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.04)),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextField(
                    controller: _giasanpham,
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.043),
                    decoration: const InputDecoration(
                      suffixText: 'VNĐ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.08),
                    Text('Tình trạng sản phẩm', style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.04)),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextField(
                    controller: _tinhtrang,
                    maxLines: null,
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.043),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.08),
                    Text('Hình ảnh sản phẩm', style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.04)),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  width: MediaQuery.of(context).size.height * 0.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: PageView.builder(
                      itemCount: imagePathList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.file(
                          File(imagePathList[index]),
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
                ElevatedButton(
                  focusNode:focus_nut_luu ,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                      padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                      textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 14, color: Colors.white)),
                      minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width * 0.26, MediaQuery.of(context).size.width * 0.025)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      if (imagePathList.isNotEmpty) {
                        SmartDialog.showLoading(
                          animationType: SmartAnimationType.scale,
                          builder: (_) => const CustomLoading(type: 1),
                        );
                        var url = Uri.parse('${helper.apiurl}prod/createProd');
                        Map<String, String> headers = {'Content-Type': 'application/json'};
                        String jsonBody = jsonEncode({
                          "subCategoryID": 1,
                          "categoryID": 1,
                          "nameProduct": _tensanpham.text,
                          "pricesProduct": _giasanpham.text,
                          "status": _tinhtrang.text,
                          "imgSlide1": listURL[0],
                          "imgSlide2": listURL[1],
                          "imgSlide3": listURL[2],
                          "imgSlide4": listURL[3]
                        });
                        await http.post(url, headers: headers, body: jsonBody).then((response) {
                          if (response.statusCode == 200) {
                            SmartDialog.dismiss();
                            Map<String, dynamic> jsonMap = json.decode(response.body);
                            int returnCode = jsonMap['result']['status'];
                            if (returnCode == 1) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                headerAnimationLoop: false,
                                title: 'Không thành công',
                                desc: 'Thêm không thành công',
                                btnOkIcon: Icons.cancel,
                                btnOkColor: Colors.red,
                              ).show();
                            } else if (returnCode == 0) {

                              AwesomeDialog(
                                context: context,
                                animType: AnimType.leftSlide,
                                headerAnimationLoop: true,
                                dialogType: DialogType.success,
                                showCloseIcon: true,
                                title: 'Thành công',
                                btnOkOnPress: () { Navigator.pop(context);},
                                desc: 'Chúc mừng bạn đăng tin thành công',
                                btnOkIcon: Icons.check_circle,
                              ).show();
                            }
                          } else {
                            SmartDialog.dismiss();
                            helper.dialogLoiServer(response.statusCode, context);
                          }
                        });
                      } else {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          headerAnimationLoop: true,
                          title: 'Chưa có hình ảnh',
                          desc: 'Vui lòng chụp hình ảnh',
                          btnOkOnPress: () {},
                          btnOkIcon: Icons.cancel,
                          btnOkColor: Colors.red,
                        ).show();
                      }
                    },
                    child: const Text("Gửi")),
              ],
            ),
          ),
        ));
  }
}
