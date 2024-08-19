class Product {
  final String name;
  final String description;
  final String imageUrl1;
  final String imageUrl2;
  final String imageUrl3;
  final String imageUrl4;
  final String price; // Thêm trường price vào lớp Product
  final String detailDescription; // Thêm trường mô tả chi tiết riêng cho từng sản phẩm

  Product({
    required this.name,
    required this.description,
    required this.imageUrl1,
    required this.imageUrl2,
    required this.imageUrl3,
    required this.imageUrl4,
    required this.price,
    required this.detailDescription,
  });
}
