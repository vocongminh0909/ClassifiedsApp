import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:nhom4_appraovat/CategoriesWidget.dart';
import 'package:nhom4_appraovat/Search_product.dart';
import 'package:nhom4_appraovat/ad_detail_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;

import 'Product_model.dart';
import 'chitietsp.dart';
import 'helper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myitems = [
    Image.asset('assets/images/images01.jpg'),
    Image.asset('assets/images/images02.jpg'),
    Image.asset('assets/images/images03.jpg'),
    Image.asset('assets/images/images04.jpg'),
    Image.asset('assets/images/images05.jpg'),
  ];
  List<Product> DataSP = [];
  int myCurrentIndex = 0;

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    SmartDialog.showLoading(
      animationType: SmartAnimationType.scale,
      builder: (_) => const CustomLoading(type: 1),
    );
    var url = Uri.parse('${helper.apiurl}prod/prodAPI');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    await http.get(url, headers: headers).then(
      (response) {
        SmartDialog.dismiss();
        if (response.statusCode == 200) {
          Map<String, dynamic> jsonMap = json.decode(response.body);
          List<dynamic> ListDataSP = jsonMap['result'];
          for (int i = 0; i < ListDataSP.length; i++) {
            DataSP.add(Product(
                name: jsonMap['result'][i]['nameProduct'],
                description: jsonMap['result'][i]['status'],
                imageUrl1: jsonMap['result'][i]['imgSlide1']??"",
                imageUrl2: jsonMap['result'][i]['imgSlide2']??"",
                imageUrl3: jsonMap['result'][i]['imgSlide3']??"",
                imageUrl4: jsonMap['result'][i]['imgSlide4']??"",
                price: jsonMap['result'][i]['pricesProduct'],
                detailDescription: jsonMap['result'][i]['status'])
            );
          }
        } else {
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
        backgroundColor: Color.fromARGB(254, 255, 170, 0),
        actions: [
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: () {
                  // Điều hướng đến màn hình tìm kiếm khi nhấn vào thanh tìm kiếm.
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchProductPage()));
                },
                child: Container(
                  width: 300.0,
                  height: 35.0,
                  child: TextField(
                    style: TextStyle(fontSize: 12.0),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 18.0),
                      hintText: 'Tìm kiếm sản phẩm trên Rao Vặt...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.orange,
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchProductPage()));
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Thêm IconButton cho tính năng tin nhắn
          IconButton(
            icon: Icon(
              Icons.message_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              // Thêm mã xử lý khi người dùng nhấn vào biểu tượng tin nhắn ở đây
            },
          ),

          // Thêm IconButton cho tính năng thông báo
          IconButton(
            icon: Icon(
              Icons.notifications_active,
              color: Colors.black,
            ),
            onPressed: () {
              // Thêm mã xử lý khi người dùng nhấn vào biểu tượng thông báo ở đây
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  autoPlay: true,
                  height: 85,
                  onPageChanged: ((index, reason) {
                    setState(() {
                      myCurrentIndex = index;
                    });
                  })),
              items: myitems.asMap().entries.map((entry) {
                final index = entry.key;
                final imagePath = myitems[index].image.toString(); // Access the asset path
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdDetailPage(imagePath),
                      ),
                    );
                  },
                  child: Image(image: myitems[index].image),
                );
              }).toList(),
            ),
            AnimatedSmoothIndicator(
              activeIndex: myCurrentIndex,
              count: myitems.length,
              effect: WormEffect(
                dotHeight: 10,
                dotWidth: 10,
                spacing: 5,
                dotColor: Color.fromARGB(255, 152, 174, 181),
                activeDotColor: Colors.grey.shade900,
                paintStyle: PaintingStyle.fill,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 10,
              ),
              child: Text(
                'Danh mục sản phẩm',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.orange),
              ),
            ),
            CategoriesWidget(),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 10,
              ),
              child: Text(
                'Danh sách sản phẩm',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.orange),
              ),
            ),
              Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          childAspectRatio:
          0.68, // Tỷ lệ chiều cao so với chiều rộng của mỗi ô sản phẩm
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2, // Số cột sản phẩm
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          shrinkWrap: true,
          children: [
            for (int i = 0; i < DataSP.length; i++)
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailPage(product: DataSP[i])));
                  },
                  child:  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          fit: BoxFit.fill,

                          DataSP[i].imageUrl1,
                          height: MediaQuery.of(context).size.height*0.18,
                          width: MediaQuery.of(context).size.width*0.4,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        alignment: Alignment.center,
                        child: Text(
                          DataSP[i].name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child:  Text(
                          DataSP[i].description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DataSP[i].price,
                              style:const  TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              ),
          ],
        ),
      ),
          ],
        ),
      ),
    );
  }
}
