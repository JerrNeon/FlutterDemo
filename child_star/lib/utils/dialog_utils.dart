import 'package:fluttertoast/fluttertoast.dart';

showToast(String msg,
    {Toast toastLength = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.BOTTOM}) {
  Fluttertoast.showToast(msg: msg, toastLength: toastLength, gravity: gravity);
}
