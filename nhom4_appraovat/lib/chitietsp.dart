import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'Product_model.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  ProductDetailPage({required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  List<String> imgList=[];

  @override
  void initState() {
    super.initState();
    initial();
  }
  void initial()  {
    if(widget.product.imageUrl1!=''){
      imgList.add(widget.product.imageUrl1);
    }
    if(widget.product.imageUrl2!=''){
      imgList.add(widget.product.imageUrl2);
    }
    if(widget.product.imageUrl3!=''){
      imgList.add(widget.product.imageUrl3);
    }
    if(widget.product.imageUrl4!=''){
      imgList.add(widget.product.imageUrl4);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CarouselSlider(
                options: CarouselOptions(autoPlay: true, autoPlayAnimationDuration: Duration(seconds: 5), autoPlayInterval: Duration(seconds: 7), enlargeCenterPage: true, viewportFraction: 0.95),
                items: imgList
                    .map((item) => ClipRRect(
                            child: Image.network(
                          item,
                          fit: BoxFit.fitWidth,
                        )))
                    .toList(),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  children: [
                    const TextSpan(text: "Giá: "),
                    TextSpan(
                      text: widget.product.price,
                      style: const TextStyle(fontSize: 18, color: Colors.red),
                    ),
                    const TextSpan(text: "\n"),
                    TextSpan(
                      text: widget.product.description,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Divider(color: Colors.grey, thickness: 1),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Mô tả chi tiết :",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.product.detailDescription,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                // Xử lý khi người dùng nhấn nút yêu thích
              },
            ),
            IconButton(
              icon: Icon(Icons.call), // Icon liên hệ
              onPressed: () {
                // Xử lý khi người dùng nhấn nút liên hệ
              },
            ),
            IconButton(
              icon: Icon(Icons.add_shopping_cart),
              onPressed: () {
                // Xử lý khi người dùng nhấn nút thêm vào giỏ hàng
              },
            ),
          ],
        ),
      ),
    );
  }
}
