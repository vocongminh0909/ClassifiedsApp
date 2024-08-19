import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:nhom4_appraovat/register_page.dart';
import 'package:nhom4_appraovat/helper.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'main_nav.dart';

class LoginPage extends StatefulWidget {
  final String? username;
  final String? pass;
  const LoginPage({super.key, this.username, this.pass});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late SharedPreferences logindata;
  bool passwordVisibility = true;
  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    if(widget.username!=null){
      _usernameController.text=widget.username!;
      _passwordController.text=widget.pass!;
    }
  }

  Future<void> checkLogin(String user,String pass) async {
    SmartDialog.showLoading(
      animationType: SmartAnimationType.scale,
      builder: (_) => const CustomLoading(type: 1),
    );
    var url = Uri.parse('${helper.apiurl}auth/login');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    String jsonBody = jsonEncode({
      "emailUser":user,
      "passwordUser":pass

    });
    await http.post(url, headers: headers, body: jsonBody).then(
          (response) {
            SmartDialog.dismiss();
        if(response.statusCode==200){
          Map<String, dynamic> jsonMap = json.decode(response.body);
          int returnCode = jsonMap['code'];
          if (returnCode == 0) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              headerAnimationLoop: false,
              title: 'Đăng nhập thất bại',
              desc: 'Nhập sai số điện thoại hoặc mật khẩu',
              btnOkIcon: Icons.cancel,
              btnOkColor: Colors.red,
              btnOkOnPress: () {
                _usernameController.clear();
                _passwordController.clear();
              },
            ).show();
          } else if (returnCode == 1) {
            logindata.setBool('login', true);
            AwesomeDialog(
              context: context,
              animType: AnimType.leftSlide,
              headerAnimationLoop: true,
              keyboardAware: false,
              dialogType: DialogType.success,
              showCloseIcon: false,
              dismissOnBackKeyPress: false,
              dismissOnTouchOutside: false,
              title: 'Đăng nhập thành công',
              btnOkOnPress: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const main_nav()));
                print('Dangnhapthannhcong');
              },
              desc:
              'Chúc mừng bạn đăng nhập thành công:\n${_usernameController.text}',
              btnOkIcon: Icons.check_circle,
            ).show();
          }
        }else{
          SmartDialog.dismiss();
          helper.dialogLoiServer(response.statusCode, context);
        }
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Đăng nhập',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(254, 255, 170, 0),
        actions: const [],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.4, width: MediaQuery.of(context).size.width * 0.9, child: Image.asset('assets/images/logo_login.png')),
              const SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.27,
                    height: 5,
                    decoration: const BoxDecoration(color: Colors.orange,
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft, // Căn trái
                    child: Text(
                      'Đăng nhập',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,color: Colors.black
                          ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.27,
                    height: 5,
                    decoration: const BoxDecoration(color: Colors.orange,
                      borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.08),
                  Text('Email', style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.04)),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  controller: _usernameController,
                  maxLines: 1,
                  style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.043),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
              ),
            ],
          ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width * 0.08),
                      Text('Mật khẩu', style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.04)),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      controller: _passwordController,
                      obscureText: passwordVisibility,
                      maxLines: 1,
                      style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.043),
                      decoration:  InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        suffixIcon: InkWell(
                          onTap: () => setState(
                                () => passwordVisibility = !passwordVisibility,
                          ),
                          focusNode: FocusNode(skipTraversal: true),
                          child: Icon(
                            passwordVisibility ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            color: const Color(0xFF57636C),
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0, width: 50.0),
           //   const Text('Quên mật khẩu?', style: TextStyle(fontSize: 15.0, color: Colors.blue)),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                 checkLogin(_usernameController.text,_passwordController.text);
                },
                style: ButtonStyle(
                  shape:
                  MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                                      ),
                  minimumSize: MaterialStatePropertyAll(Size(MediaQuery.of(context).size.width*0.6,40)),
                  backgroundColor: const MaterialStatePropertyAll(Colors.orange),
                ),
                child: const Text('Đăng nhập'),
              ),
              const Text(
                'Hoặc',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.underline

                ),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                style: ButtonStyle(
                  shape:
                  WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  backgroundColor: const WidgetStatePropertyAll(Colors.orange),
                ),
                child: const Text('Đăng ký'),
              ),

              const SizedBox(height: 16.0),
              const Text('Quy chế hoạt động sản - Chính sách bảo mật - Liên hệ hỗ trợ', style: TextStyle(fontSize: 12.0)),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
