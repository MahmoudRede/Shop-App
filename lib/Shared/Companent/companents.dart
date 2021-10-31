import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Model/BoardingModel.dart';
import 'package:shop_app/Shared/Style/colors.dart';

Widget pageViewItemBuilder(BoardingModel model)
{
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage("${model.image}"),
        ),
      ),
      Text(
        '${model.title}',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: defaultColor,
        ),
      ),
      SizedBox(
        height: 25.0,
      ),
      Text(
        '${model.body}',
        style: TextStyle(
          fontSize: 16.0,
          color: defaultColor,
        ),
      ),
    ],
  );
}

Widget defaultFormField({
  required final String lable,
  required final textController,
  required final IconData prefixIcon,
  final IconData? sufixIcon,
  final Function()? sufixPressed,
  required final String? Function(String?)? validator,
  final Function(String?)? onSubmit,
  final TextInputType textType = TextInputType.text,
  final Function()? onTap,
  final bool isPassword = false,
}) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: lable,
      labelStyle: TextStyle(
        fontSize: 18.0,
        color: Colors.blue,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      prefixIcon: Icon(prefixIcon,color: Colors.blue,),
      suffixIcon: IconButton(onPressed: sufixPressed, icon: Icon(sufixIcon),),
    ),
    controller: textController,
    keyboardType: textType,
    validator: validator,
    onTap: onTap,
    onFieldSubmitted: onSubmit,
    obscureText: isPassword,
  );
}

void navigateAndRemove ({
  required BuildContext context,
  required Widget widget,
})
{
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context){
      return widget;
    }),
        (route){
      return false;
    },
  );
}

void navigateTo ({
  required BuildContext context,
  required Widget widget ,
})
{
  Navigator.push(context, MaterialPageRoute(builder: (context){
    return widget;
  }));

}

void showToast ({
  required String text ,
  required ToastState state ,
})
{
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

enum ToastState {SUCCESS , ERROR , WARNING}

Color chooseToastColor(ToastState state)
{
  Color color;

  switch(state)
  {
    case ToastState.SUCCESS :
      color = Colors.green;
      break;

    case ToastState.ERROR :
      color = Colors.red;
      break;

    case ToastState.WARNING :
      color = Colors.amber;
      break;
  }

  return color;
}