import 'package:flutter/widgets.dart';

typedef OnItemClick<T> = Function(BuildContext context, T data);
typedef OnItemChildClick<T> = Function(BuildContext context, int index, T data);
