class Restaurant {
  int? restaurantSeq;
  String? title;
  String? category;
  double? starRating;
  int? starCnt;
  String? address;
  String? number;
  double? longitude;
  double? latitude;
  String? image;

  Restaurant({
      this.restaurantSeq,
      this.title,
      this.category,
      this.starRating,
      this.starCnt,
      this.address,
      this.number,
      this.longitude,
      this.latitude,
      this.image});
  factory Restaurant.fromJson(Map<String, dynamic> json){
    return Restaurant(
      restaurantSeq: json['restaurantSeq'],
      title: json['title'],
      category: json['category'],
      starRating: json['starRating'],
      starCnt: json['starCnt'],
      address: json['address'],
      number: json['number'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      image: json['image'],
    );
  }

  @override
  String toString() {
    return 'Restaurant{restaurantSeq: $restaurantSeq, title: $title, category: $category, starRating: $starRating, starCnt: $starCnt, address: $address, number: $number, longitude: $longitude, latitude: $latitude, image: $image}';
  }
}
