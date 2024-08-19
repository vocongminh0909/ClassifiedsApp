import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool currentPasswordVisible = false;
  bool newPasswordVisible = false; // Để quản lý hiển thị mật khẩu mới
  bool confirmPasswordVisible = false; // Để quản lý hiển thị xác nhận mật khẩu

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color.fromARGB(254, 255, 170, 0),
        title: Text("Đổi mật khẩu",style: TextStyle( fontSize: 20.0,  // Đặt kích thước chữ là 30.0
        ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: currentPasswordController,
              decoration: InputDecoration(
                labelText: "Mật khẩu hiện tại",
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      currentPasswordVisible = !currentPasswordVisible;
                    });
                  },
                  icon: Icon(
                    currentPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
                border: OutlineInputBorder( // Đặt kiểu viền
                  borderRadius: BorderRadius.circular(8.0), // Đặt độ cong của góc
                  borderSide: BorderSide( // Đặt màu viền và độ dày
                    color: Colors.orange, // Đặt màu viền
                    width: 2.0, // Đặt độ dày viền
                  ),
                ),
              ),
              obscureText: !currentPasswordVisible,
            ),


            SizedBox(height: 16.0),
            TextFormField(
              controller: newPasswordController,
              decoration: InputDecoration(
                labelText: "Mật khẩu mới",
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      newPasswordVisible = !newPasswordVisible;
                    });
                  },
                  icon: Icon(
                    newPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
                border: OutlineInputBorder( // Đặt kiểu viền
                  borderRadius: BorderRadius.circular(8.0), // Đặt độ cong của góc
                  borderSide: BorderSide( // Đặt màu viền và độ dày
                    color: Colors.orange, // Đặt màu viền
                    width: 2.0, // Đặt độ dày viền
                  ),
                ),
              ),
              obscureText: !newPasswordVisible,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: confirmPasswordController,
              decoration: InputDecoration(
                labelText: "Xác nhận mật khẩu",
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      confirmPasswordVisible = !confirmPasswordVisible;
                    });
                  },
                  icon: Icon(
                    confirmPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
                border: OutlineInputBorder( // Đặt kiểu viền
                  borderRadius: BorderRadius.circular(8.0), // Đặt độ cong của góc
                  borderSide: BorderSide( // Đặt màu viền và độ dày
                    color: Colors.orange, // Đặt màu viền
                    width: 2.0, // Đặt độ dày viền
                  ),
                ),
              ),
              obscureText: !confirmPasswordVisible,
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // Xử lý khi người dùng ấn nút đổi mật khẩu
                String newPassword = newPasswordController.text;
                String confirmPassword = confirmPasswordController.text;

                if (newPassword == confirmPassword) {
                  // Thực hiện thay đổi mật khẩu
                  print("Mật khẩu đã được thay đổi");
                } else {
                  // Hiển thị thông báo lỗi nếu mật khẩu mới và nhập lại mật khẩu không khớp
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Lỗi"),
                        content: Text("Mật khẩu mới và nhập lại mật khẩu không khớp."),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                }

              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.orange), // Đổi màu nền thành màu cam
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0), // Điều chỉnh kích thước tại đây
                child: Text("Đổi mật khẩu"),
              ),
            ),
              ],
        ),
      ),
    );
  }
}
