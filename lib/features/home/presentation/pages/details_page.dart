import 'package:bagz/features/home/data/data_source/firestore_service.dart';
import 'package:bagz/features/home/data/models/bagz_model.dart';
import 'package:bagz/features/home/presentation/bloc/bagz_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.id});

  final String id;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final db = FirebaseFirestore.instance;
  final h = BagzBloc(firestoreService: FirestoreService());

  @override
  void initState() {

    h.add(LoadOneBag(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => h,
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios)),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: BlocBuilder<BagzBloc, BagzState>(
              builder: (context, state) {
                if (state is BagzLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LoadedOneBag) {
                  BagzModel myBag = state.oneBag;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: SizedBox(
                            width: 350,
                            height: 160,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: 170,
                                    child: FadeInImage.assetNetwork(
                                      placeholder: 'assets/images/Artsy.png',
                                      image: myBag.image,
                                      fit: BoxFit.fitWidth,
                                    )),
                                11.horizontalSpace,
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      myBag.name,
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
                                      '\$${myBag.price}',
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
                                            color: Colors.white, fontSize: 18),
                                      )),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                      bottom: BorderSide(color: Colors.black))),
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
                            myBag.description,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ))
                      ],
                    ),
                  );
                } else if (state is BagzOperationSuccess) {
                  return Container();
                } else if (state is BagzError) {
                  return Column(
                    children: [
                      Center(
                        child: Text(state.errorMessage),
                      ),
                      Icon(Icons.refresh)
                    ],
                  );
                } else {
                  return Container();
                }
              },
            )));
  }
}
