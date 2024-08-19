import 'package:flutter/material.dart';


class Category {
  final String imageUrl;
  final String title;

  Category({required this.imageUrl, required this.title});
}


class CategoriesWidget extends StatelessWidget{
  final List<Category> categories = [
    Category(
      imageUrl: "assets/images/iphone-14-pro-vang.jpg",
      title: "Điện thoại",
    ),
    Category(
      imageUrl: "assets/images/dong-ho-deo-tay-ELLE-Man.jpg",
      title: "Đồng hồ",
    ),
    Category(
      imageUrl: "assets/images/laptop-rog.jpg",
      title: "Laptop",
    ),
    Category(
      imageUrl: "assets/images/winner.jpg",
      title: "Xe máy",
    ),
    
    // Thêm các danh mục khác ở đây
  ];
  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
           for (var category in categories)
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
             children: [
                  Image.asset(category.imageUrl, width: 40, height: 40),
                  Text(
                    category.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  )
                ],
          ),
        )
      ],),
    );
  }
}