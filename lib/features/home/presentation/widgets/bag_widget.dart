
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BagWidget extends StatelessWidget {
  const BagWidget({
    super.key,
    required this.name,
    required this.imageUrl,
  });

  final String name;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      width: 170,
      height: 210,
      color: Color(0xffF1F1F1),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   FadeInImage.assetNetwork(placeholder: 'assets/images/Artsy.png', image: imageUrl,
                   imageErrorBuilder: (context, error, stackTrace) => Image.asset('assets/images/Artsy.png'),
                   ),
                    Text(
                      name,
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    5.verticalSpace,
                    Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.black))),
                        child: Text(
                          'Shop Now',
                          style: TextStyle(fontSize: 16),
                        )),
                    5.verticalSpace
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Icon(Icons.favorite_border_outlined)],
            ),
          )
        ],
      ),
    );
  }
}
