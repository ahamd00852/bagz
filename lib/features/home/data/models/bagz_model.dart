class BagzModel{

 String description;
 String name;
 String image;
 String price;
 String id;
 BagzModel({
    required this.id,
    required this.description,
    required this.name,
    required this.image,
    required this.price,
  });

 factory BagzModel.fromJson(Map<String,dynamic> json, ){
   return BagzModel(id:json['id'],description: json['description'], name: json['name'], image: json['image'], price: json['price'].toString());
 }
}