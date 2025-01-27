import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/bagz_model.dart';

class FirestoreService {
  final CollectionReference _bagzCollection =
      FirebaseFirestore.instance.collection('products');

  Future<List<BagzModel>> getBagz() async{
    List<BagzModel> bagzList=[];
    try{
      final bag=await FirebaseFirestore.instance.collection('products').get();

      bag.docs.forEach((element){
        return bagzList.add(BagzModel.fromJson(element.data()));
      });
      return bagzList;
    }on FirebaseException catch(e){
      print('Failed To Load Products');
      return bagzList;
    }catch(e){
      throw Exception(e.toString());
    }
  }
  Future<BagzModel?> getOneBagz(String id) async{
    BagzModel oneBag;
    try{
      final bag=await FirebaseFirestore.instance.collection('products').doc(id).get();
      oneBag=BagzModel.fromJson(bag.data()as Map<String,dynamic>);
      return oneBag;
    }on FirebaseException catch(e){
      print('Failed To Load Products');
      return null;
    }catch(e){
      throw Exception(e.toString());
    }
  }
}
// Stream<List<BagzModel>> getBagz() {
//   return _bagzCollection.snapshots().map((snapshot) {
//     return snapshot.docs.map((doc) {
//       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//       return BagzModel(
//           description: data['description'],
//           name: data['name'],
//           image: data['image'],
//           price: data['price'], id: doc.id);
//     }).toList();
//   });
// }