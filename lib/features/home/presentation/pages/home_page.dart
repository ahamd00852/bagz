import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/bag_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Bagz',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: Icon(Icons.account_circle_sharp),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
                width: 1.sw,
                child: Image.asset(
                  'assets/images/Rectangle.png',
                  fit: BoxFit.fitWidth,
                )),
          ),
          Expanded(
            child: FutureBuilder(
                future: db.collection('products').get(),
                builder: (context, snapshot) {
                  return snapshot.connectionState == ConnectionState.waiting
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : snapshot.connectionState == ConnectionState.done
                          ?snapshot.requireData.docs.isEmpty?Center(child: Text('No Data'),) :GridView.builder(
                      itemCount: snapshot.requireData.docs.length,
                      gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, childAspectRatio: .8),
                              itemBuilder: (context, index) => BagWidget(
                                    imageUrl: snapshot.requireData.docs[index]['image'],
                                    name: snapshot.requireData.docs[index]['name'],
                                  ))
                          : Center(
                              child: Text('Failed'),
                            );
                }),
          )
        ],
      ),
    );
  }
}
