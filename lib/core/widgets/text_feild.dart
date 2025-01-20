import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
Widget TextFormFieldd(
{required String textFormName,
  required FormFieldValidator<String> validator,
  required TextEditingController controller
}
    ){
  return SizedBox(
    width: 0.8.sw,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(' $textFormName'),
        TextFormField(
          controller: controller,
          validator: validator,
          cursorColor: Colors.black,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black)
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black)
              )
          ),
        ),
      ],
    ),
  );
}