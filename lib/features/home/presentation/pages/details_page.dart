import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.id});

  final String id;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder(
          future: db.collection('products').doc(widget.id).get(),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : snapshot.connectionState == ConnectionState.done
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: SizedBox(
                                width: 350,
                                height: 160,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        width: 170,
                                        child: FadeInImage.assetNetwork(
                                            placeholder:
                                                'assets/images/Artsy.png',
                                            image: snapshot.requireData
                                                .data()!['image'],
                                          fit: BoxFit.fitWidth,
                                        )),
                                    11.horizontalSpace,
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.requireData.data()!['name'],
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        5.verticalSpace,
                                        Text('Wallet with chain'),
                                        Text(
                                          'Style #36252 0YK0G 1000',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        4.verticalSpace,
                                        Text(
                                          '\$${snapshot.requireData.data()!['price']}',
                                          style: TextStyle(fontSize: 22),
                                        ),
                                        15.verticalSpace,
                                        Container(
                                          width: 100,
                                          height: 30,
                                          color: Colors.black,
                                          child: Center(
                                              child: Text(
                                            'Buy Now',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          )),
                                        )
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.favorite_border_outlined)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            15.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                100.horizontalSpace,
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom:
                                              BorderSide(color: Colors.black))),
                                  child: Text(
                                    'ADD TO CART',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            50.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Description:',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            15.verticalSpace,
                            SingleChildScrollView(
                                child: SizedBox(
                              height: 100,
                              child: Text(
                                snapshot.requireData.data()!['description'],
                                style: TextStyle(color: Colors.grey),
                              ),
                            ))
                          ],
                        ),
                      )
                    : Center(
                        child: Text('failed'),
                      );
          }),
    );
  }
}
