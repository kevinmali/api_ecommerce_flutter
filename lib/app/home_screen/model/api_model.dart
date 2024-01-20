class Ecommodel {
  String title;
  int id;
  dynamic price;
  String image;

  Ecommodel(
      {required this.title,
      required this.id,
      required this.price,
      required this.image});

  factory Ecommodel.fromAPI({required Map data}) {
    return Ecommodel(
        title: data['title'],
        id: data['id'],
        price: data['price'],
        image: data['image']);
  }
}
