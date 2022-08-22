import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_color.dart';
import '../utils/app_strings.dart';

Widget textFormFieldWidget(
{
  context,
 required TextEditingController controller,
 required TextInputType inputType,
 required String labelText,
 required String errorMessage,
 required IconData prefixIcon
}
    )=>TextFormField(
  style: TextStyle(
      color: Colors.black
  ),
  keyboardType: inputType,
  controller: controller,
  decoration: InputDecoration(
    fillColor: Colors.white,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
      borderRadius: BorderRadius.circular(15),
    ),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15)
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color:Colors.indigo),
      borderRadius: BorderRadius.circular(15),
    ),
    label: Text('${labelText}',style: TextStyle(
      color: AppColor.hintColorColor,
      fontFamily: AppStrings.appFont,
    ),),
    prefixIcon: Icon(prefixIcon,color:AppColor.primaryColor),
  ),
  validator: (value){
    if(value!.isEmpty){
      return'${errorMessage}';
    }
  },
);



Widget defaultButton({
  required Size size,
  required Color buttonColor,
  required String buttonText,
  required VoidCallback function
})=>Container(

    height: size.height*(.06),
    width: size.width*(.5),
    decoration: BoxDecoration(
      color:buttonColor ,
      borderRadius: BorderRadius.circular(5),
    ),
    child:TextButton(
      onPressed:function,
      child:  Text('${buttonText}',style: TextStyle(
          color: Colors.white,
          fontFamily: AppStrings.appFont,
          fontWeight: FontWeight.w700,
          fontSize: 22
      ),
      ),
    )
);

Widget defaultSocialMediaButton({
  required Size size,
  required Color buttonColor,
  required String buttonText,
  required VoidCallback function,
  required String imagePath
})=>Container(

    height: size.height*(.04),
    width: size.width*(.7),
    decoration: BoxDecoration(
      color:buttonColor ,
      borderRadius: BorderRadius.circular(5),
    ),
    child:TextButton(
      onPressed:function,
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${buttonText}',style: TextStyle(
              color: Colors.white,
              fontFamily: AppStrings.appFont,
              fontWeight: FontWeight.w700,
              fontSize: 14
          ),),
          Spacer(),
         Image.asset('${imagePath}',width: 45,height: 45,),
        ],
      ),
    )
);