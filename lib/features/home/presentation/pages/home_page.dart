import 'package:bagz/features/home/data/models/bagz_model.dart';
import 'package:bagz/features/home/presentation/bloc/bagz_bloc.dart';
import 'package:bagz/features/home/presentation/pages/details_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    BlocProvider.of<BagzBloc>(context).add(LoadBagz());
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
        backgroundColor: Colors.transparent,
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
          BlocBuilder<BagzBloc, BagzState>(
            builder: (context, state) {
              if (state is BagzLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is LoadedBagz) {
                List<BagzModel> data=state.myData;
                return Expanded(
                  child: GridView.builder(
                      itemCount: data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: .8),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailsPage(
                                                      id: data[index].id,
                                        )));
                          },
                          child: BagWidget(
                            imageUrl: data[index].image,
                            name: data[index].name,
                          ),
                        );
                      }),
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
          )
        ],
      ),
    );
  }
}
