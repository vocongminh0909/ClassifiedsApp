import 'package:flutter/material.dart';

class AdDetailPage extends StatelessWidget {

  
  final String imagePath;

  AdDetailPage(this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết quảng cáo'),
        backgroundColor: Color.fromARGB(254, 255, 170, 0),
        centerTitle: true, // Đặt giữa cả chiều ngang và chiều dọc
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath),
            SizedBox(height: 20),
            Text('Thông tin chi tiết về hình ảnh sẽ ở đây.'),
          ],
        ),
      ),
    );
  }
}
