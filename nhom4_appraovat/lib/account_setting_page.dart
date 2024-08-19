import 'package:flutter/material.dart';
import 'package:nhom4_appraovat/change_password_page.dart';

class AccountSettingsPage extends StatefulWidget {
  @override
  _AccountSettingsPageState createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  String name = "Thái Núi"; // Giá trị ban đầu của trường "Tên"
  String SDT = "0338587342"; // Giá trị ban đầu của trường "SDT"
  String Email = "thainguyen1010@gmail.com"; // Giá trị ban đầu của trường "Email"
  String password = "******";
  String MST = "";

  final List<String> settingsOptions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cài đặt tài khoản",
          style: TextStyle(
            fontSize: 20.0, // Đặt kích thước chữ là 30.0
          ),
        ),
        centerTitle: true, // Đặt giữa cả chiều ngang và chiều dọc
        backgroundColor: Color.fromARGB(254, 255, 170, 0),
      ),
      body: ListView(
        children: <Widget>[
          // Dòng chữ đậm cho thông tin cá nhân
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Thông tin cá nhân",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Trường "Tên" có thể chỉnh sửa
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              initialValue: name,
              decoration: InputDecoration(
                labelText: "Tên",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                // Xử lý khi người dùng thay đổi giá trị trường "Tên"
                setState(() {
                  name = value;
                });
              },
            ),
          ),

          // Trường "Email" có thể chỉnh sửa
          // Trường "Mật khẩu" hiển thị dưới dạng văn bản
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: TextEditingController(text: SDT),
              enabled: false,
              decoration: InputDecoration(
                labelText: "Số điện thoại",
                border: OutlineInputBorder(),
              ),
            ),
          ),

          // Trường "Mật khẩu" hiển thị dưới dạng văn bản
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: TextEditingController(text: Email),
              enabled: false,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
          ),

          // Danh sách các tùy chọn cài đặt
          ListView.builder(
            shrinkWrap: true,
            itemCount: settingsOptions.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  // Xử lý khi người dùng nhấn vào tùy chọn cài đặt
                  print("Bạn đã chọn: ${settingsOptions[index]}");
                },
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    settingsOptions[index],
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Cài đặt tài khoản",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                // Navigate to the password change page (ChangePasswordPage)
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordPage()));
              },
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      initialValue: password,
                      decoration: InputDecoration(
                        labelText: "Mật khẩu",
                        border: OutlineInputBorder(),
                      ),
                      enabled: false, // Không cho phép chỉnh sửa
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward), // Biểu tượng mũi tên
                    onPressed: () {
                    },
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              initialValue: MST,
              decoration: InputDecoration(
                labelText: "Mã số thuế",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  MST = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
