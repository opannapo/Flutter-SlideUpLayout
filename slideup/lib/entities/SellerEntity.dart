class SellerEntity {
  int id;
  String fullName;
  String imageProfile;
  bool isActived;
  String shareUrl;
  int rating;

  SellerEntity({
    this.id,
    this.fullName,
    this.imageProfile,
    this.isActived,
    this.shareUrl,
    this.rating,
  });

  factory SellerEntity.fromJson(Map<String, dynamic> json) {
    print('ArtisEntity.fromJson $json');

    return SellerEntity(
      id: json['id'] as int,
      fullName: json['fullName'] as String,
      imageProfile: json['imageProfile'] as String,
      isActived: json['isActived'] as bool,
      shareUrl: json['shareUrl'] as String,
      rating: json['rating'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'imageProfile': imageProfile,
        'isActived': isActived,
        'shareUrl': shareUrl,
        'rating': rating,
      };
}
