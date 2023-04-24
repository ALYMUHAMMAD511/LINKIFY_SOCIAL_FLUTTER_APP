import 'package:flutter/material.dart';
import 'package:social_app/shared/styles/colors.dart';

Widget mySeparator() => Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);


Widget defaultFormField({
  required TextEditingController? controller,
  TextInputType? type,
  bool isPassword = false,
  required String? labelText,
  required IconData? prefixIcon,
  IconData? suffixIcon,
  final FormFieldValidator<String>? validate,
  VoidCallback? suffixPressed,
  VoidCallback? onTap,
  bool isClickable = true,
  ValueChanged<String>? onFieldSubmitted}) => TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  decoration: InputDecoration(
    labelText: labelText,
    prefixIcon: Icon(prefixIcon),
    suffixIcon: IconButton(onPressed: suffixPressed, icon: Icon(suffixIcon)),
    border: const OutlineInputBorder(),
  ),
  onFieldSubmitted: onFieldSubmitted,
  validator: validate,
  onTap: onTap,
  enabled: isClickable,
);

Widget defaultButton({
  double width = double.infinity,
  Color background = defaultColor,
  double radius = 3.0,
  required VoidCallback? onPressed,
  required String text,
  bool isUpperCase = true,
}) => Container(
  width: width,
  height: 50.0,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: background,
  ),
  child: MaterialButton(
    onPressed: onPressed,
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
  ),
);

Widget defaultTextButton({
  required VoidCallback onPressed,
  required String text,
}) => TextButton(
  onPressed: onPressed,
  child: Text(
    text.toUpperCase(),
  ),
);

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
      builder: (context) => widget),
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (Route<dynamic> route) => false);

String capitalizeAllWord(String value) {
  var result = value[0].toUpperCase();
  for (int i = 1; i < value.length; i++) {
    if (value[i - 1] == " ") {
      result = result + value[i].toUpperCase();
    } else {
      result = result + value[i];
    }
  }
  return result;
}
