import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class helper {
  static final helper _instance = helper._internal();

  factory helper() {
    return _instance;
  }

  helper._internal();
  static late SharedPreferences logindata;
  static bool isLogin = false;
  static String apiurl='http://10.21.80.237:9000/api/';


  static Future<void> laythongtindangnhap() async {
    logindata = await SharedPreferences.getInstance();
    isLogin = logindata.getBool('login')!;
  }

  // static layvanban(String vb) {
  //   if (vb!='') {
  //     List<String> lines = vb.split('\n');
  //     String tmp = '';
  //     for (int i = 0; i < lines.length; i++) {
  //       tmp = '$tmp${lines[i]}\n';
  //     }
  //     return tmp;
  //   }else{
  //     return '';
  //   }
  // }

  // static quetbarcode() async {
  //   final barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#FF0000', 'Cancel', true, ScanMode.QR);
  //   return barcodeScanRes;
  // }
  static void dialogLoiServer(int maloi, BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      headerAnimationLoop: false,
      title: 'Lỗi $maloi',
      desc: 'Vui lòng liên hệ công ty RauVat',
      btnOkIcon: Icons.cancel,
      btnOkColor: Colors.red,
      btnOkText: 'Đồng ý',
      btnOkOnPress: () {},
    ).show();
  }

}

class CustomLoading extends StatefulWidget {
  const CustomLoading({Key? key, this.type = 0}) : super(key: key);
  final int type;

  @override
  _CustomLoadingState createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Visibility(visible: widget.type == 1, child: _buildLoadingTwo()),
    ]);
  }

  Widget _buildLoadingTwo() {
    return Stack(alignment: Alignment.center, children: [
      Image.asset(
        'assets/images/logo_login.png',
        height: MediaQuery.of(context).size.width * 0.25,
        width: MediaQuery.of(context).size.width * 0.25,
      ),
      RotationTransition(
        alignment: Alignment.center,
        turns: _controller,
        child: Image.asset(
          'assets/loading_bg.png',
          height: MediaQuery.of(context).size.width * 0.5,
          width: MediaQuery.of(context).size.width * 0.5,
        ),
      ),
    ]);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
