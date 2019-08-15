import 'SellerEntity.dart';

class PropertyEntity {
  int id;
  String title;
  int viewCount;
  String shareUrl;
  int price;
  SellerEntity seller;
  List<dynamic> images;
  Map<dynamic, dynamic> detail;

  PropertyEntity(
      {this.id,
      this.title,
      this.viewCount,
      this.shareUrl,
      this.price,
      this.seller,
      this.images,
      this.detail});

  factory PropertyEntity.fromJson(Map<String, dynamic> json) {
    print('PropertyEntity.fromJson $json');

    SellerEntity seller;
    if (json.containsKey('seller')) {
      seller = SellerEntity.fromJson(json['seller']);
    }

    var imgs = json['images'] as List;
    return PropertyEntity(
      id: json['id'] as int,
      title: json['title'] as String,
      viewCount: json['viewCount'] as int,
      shareUrl: json['shareUrl'] as String,
      price: json['price'] as int,
      seller: seller,
      images: imgs,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'viewCount': viewCount,
        'shareUrl': shareUrl,
        'price': price,
        'seller': seller,
        'images': images,
        "detail": this.detail,
      };

  @override
  String toString() {
    return 'PropertyEntity{id: $id, title: $title, viewCount: $viewCount, shareUrl: $shareUrl, price: $price, seller: $seller, images: $images, detail: $detail}';
  }
}
