import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:nhom4_appraovat/login_page.dart';
import 'package:http/http.dart' as http;


import 'helper.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool passwordVisibility = true;
  Future<void> dangki() async {
    SmartDialog.showLoading(
      animationType: SmartAnimationType.scale,
      builder: (_) => const CustomLoading(type: 1),
    );
    var url = Uri.parse('${helper.apiurl}auth/createUser');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    String jsonBody = jsonEncode({
      "nameUser": _usernameController.text,
      "emailUser": _emailController.text,
      "passwordUser": _passwordController.text,
      "phoneUser": _phoneController.text,
    });
    await http.post(url, headers: headers, body: jsonBody).then(
      (response) {
        print(url);
        if (response.statusCode == 200) {
          SmartDialog.dismiss();
          Map<String, dynamic> jsonMap = json.decode(response.body);
          print(helper.apiurl);
          print(jsonMap);
          int returnCode = jsonMap['status'];
          if (returnCode == 1) {
            AwesomeDialog(
              context: context,
              animType: AnimType.leftSlide,
              headerAnimationLoop: true,
              dialogType: DialogType.success,
              title: 'Đăng ký thành công',
              btnOkOnPress: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage(username: _usernameController.text,pass: _passwordController.text,)),
                );
              },
              desc: 'Chúc mừng ${_usernameController.text} đã đăng ký thành công',
              btnOkIcon: Icons.check_circle,
            ).show();
          }
        } else {
          SmartDialog.dismiss();
          helper.dialogLoiServer(response.statusCode, context);
        }
      },
    );
  }
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Đăng ký',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.orange,
        actions: const [],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/logo_login.png'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.27,
                    height: 5,
                    decoration: const BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft, // Căn trái
                    child: Text(
                      'Đăng ký',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.27,
                    height: 5,
                    decoration: const BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width * 0.08),
                      Text('Số điện thoại', style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.04)),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      controller: _phoneController,
                      maxLines: 1,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.043),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                        Row(
                          children: [
                            SizedBox(width: MediaQuery.of(context).size.width * 0.08),
                            Text('Tên đăng nhập', style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.04)),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextFormField(
                            controller: _usernameController,
                            maxLines: 1,
                            style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.043),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập tên đăng nhập';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
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
                          child: TextFormField(
                            controller: _emailController,
                            maxLines: 1,
                            style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.043),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            validator: (value) {
                              RegExp email = RegExp(
                                r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                              );
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập email';
                              }
                              if (!email.hasMatch(value)) {
                                return 'Vui lòng nhập email chính xác';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
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
                          child: TextFormField(
                            controller: _passwordController,
                            maxLines: 1,
                            obscureText: passwordVisibility,
                            style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.043),
                            decoration: InputDecoration(
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
                            validator: (value) {
                              RegExp email = RegExp(r'^.{6,}$');
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập mật khẩu';
                              }
                              if (!email.hasMatch(value)) {
                                return 'Vui lòng nhập mật khẩu có hơn 6 kí tự';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    dangki();
                  }

                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  minimumSize: MaterialStatePropertyAll(Size(MediaQuery.of(context).size.width * 0.6, 40)),
                  backgroundColor: const MaterialStatePropertyAll(Colors.orange),
                ),
                child: const Text('Đăng ký'),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Đã có tài khoản?',
                style: TextStyle(fontSize: 12.0, color: Colors.blue),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  minimumSize: MaterialStatePropertyAll(Size(MediaQuery.of(context).size.width * 0.4, 30)),
                  backgroundColor: const MaterialStatePropertyAll(Colors.orange),
                ),
                child: const Text('Đăng nhập'),
              ),
              const Text(
                'Quy chế hoạt động sàn - Chính sách bảo mật - Liên hệ hỗ trợ',
                style: TextStyle(fontSize: 12.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
