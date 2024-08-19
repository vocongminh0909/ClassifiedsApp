import 'package:flutter/material.dart';

class ShippingInfoPage extends StatefulWidget {
  @override
  _ShippingInfoPageState createState() => _ShippingInfoPageState();
}

class _ShippingInfoPageState extends State<ShippingInfoPage> {
  final _formKey = GlobalKey<FormState>(); // Khóa để quản lý trạng thái của Form
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _noteController = TextEditingController(); // Thêm trường ghi chú




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin giao hàng', style: TextStyle(fontSize: 22)),
        centerTitle: true,
        backgroundColor: Color.fromARGB(254, 255, 170, 0),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: ()
           {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 16.0),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Họ và tên'),
                  validator: (value) {
                  if (value!.isEmpty) {
                    return 'Vui lòng nhập họ và tên';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Số điện thoại'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Vui lòng nhập số điện thoại';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16.0),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Địa chỉ'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Vui lòng nhập địa chỉ';
                  }
                  return null;
                },
              ),
               SizedBox(height: 16.0),
              TextFormField(
                controller: _noteController, // Trường ghi chú
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ghi chú', // Nhãn trường ghi chú
                ),
                 maxLines: 6, // Đặt số dòng tối đa bạn muốn cho phép nhập
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Kiểm tra xem form có hợp lệ không trước khi xử lý đơn hàng
                  if (_formKey.currentState!.validate()) {
                    // Xử lý đơn hàng ở đây
                    // Có thể sử dụng _nameController.text, _addressController.text,
                    // _phoneNumberController.text để lấy thông tin từ form
                  }
                },
                 style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // Màu nền của nút là cam
                  textStyle: TextStyle(fontSize: 20), // Kích thước văn bản
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10), // Kích thước nút
                  ),
                child: Text('Đặt hàng', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    _noteController.dispose(); // Giải phóng trường ghi chú
    super.dispose();
  }
}
