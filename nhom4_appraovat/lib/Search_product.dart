import 'package:flutter/material.dart';

class SearchProductPage extends StatefulWidget {
  @override
  _SearchProductPageState createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  TextEditingController _searchController = TextEditingController();
  List<String> products = ['Iphone 14pro', 'Ex155 VVA', 'Đồng Hồ', 'Winner X'];
  List<String> filteredProducts = [];
  bool noResults = false; // Biến để kiểm tra xem có kết quả tìm kiếm hay không

  void _search() {
    setState(() {
      filteredProducts = products
          .where((product) =>
              product.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
      noResults = filteredProducts.isEmpty; // Cập nhật biến noResults
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tìm kiếm sản phẩm',
          style: TextStyle(
            fontSize: 25.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(254, 255, 170, 0),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Tìm kiếm sản phẩm',
              ),
              onChanged: (text) {
                _search();
              },
            ),
          ),
          // Kiểm tra và hiển thị thông báo "Không tìm thấy sản phẩm" khi cần
          noResults
              ? Text('Không tìm thấy sản phẩm')
              : Expanded(
                  child: ListView.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(filteredProducts[index]),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
