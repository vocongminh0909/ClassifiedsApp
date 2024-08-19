import 'package:flutter/material.dart';
import 'shipping_info_page.dart'; // Điều này giả sử rằng bạn đã tạo file shipping_info_page.dart cho trang nhập thông tin giao hàng

class Shopping_cartPage extends StatelessWidget {
  // Danh sách các sản phẩm trong giỏ hàng (ví dụ)
  final List<String> cartItems = [
    'Sản phẩm 1',
    'Sản phẩm 2',
    'Sản phẩm 3',
    'Sản phẩm 4',
    'Sản phẩm 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giỏ hàng',style: TextStyle(fontSize: 22),),
        centerTitle: true, // Center-align the title
        backgroundColor: Color.fromARGB(254, 255, 170, 0),
      ),
      body: ListView.separated(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return ListTile(
            title: Text(item),
            trailing: IconButton(
              icon: Icon(Icons.remove_shopping_cart), // Biểu tượng xóa sản phẩm khỏi giỏ hàng
              onPressed: () {
                // Xử lý xóa sản phẩm khỏi giỏ hàng ở đây
                // Có thể cập nhật danh sách và giao diện
              },
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(); // Tạo đường ngăn cách giữa các mục
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tổng tiền: 1000đ'), // Hiển thị tổng tiền
              ElevatedButton(
                onPressed: () {
                  // Chuyển hướng qua trang nhập thông tin giao hàng khi nhấn nút "Thanh toán"
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ShippingInfoPage()),
                      );
                },
                style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.orange, // Màu nền của nút là cam
                   textStyle: TextStyle(fontSize: 15), // Kích thước văn bản
                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Kích thước nút
                   ),
                child: Text('Thanh toán'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
