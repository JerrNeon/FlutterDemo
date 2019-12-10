import 'package:child_star/common/my_colors.dart';
import 'package:child_star/common/my_sizes.dart';
import 'package:child_star/i10n/gm_localizations_intl.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FutureBuilderWidget<T> extends StatelessWidget {
  final Widget loadingWidget;
  final Widget errorWidget;
  final GestureTapCallback onErrorRetryTap;
  final Future<T> future;
  final T initialData;
  final AsyncWidgetBuilder<T> builder;

  FutureBuilderWidget({
    this.loadingWidget,
    this.errorWidget,
    this.onErrorRetryTap,
    this.future,
    this.initialData,
    @required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      initialData: initialData,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            LogUtils.e(snapshot.error.toString());
            return errorWidget ?? _buildDefaultErrorWidget(context, snapshot);
          } else {
            return builder(context, snapshot);
          }
        } else {
          return loadingWidget ?? _buildDefaultLoadingWidget();
        }
      },
    );
  }

  Widget _buildDefaultErrorWidget(
      BuildContext context, AsyncSnapshot<T> snapshot) {
    LogUtils.e(snapshot.error.toString());
    return GestureDetector(
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Text(
          GmLocalizations.of(context).loadFailureTitle,
          style:
              TextStyle(color: MyColors.c_686868, fontSize: MyFontSizes.s_14),
        ),
      ),
      onTap: () {
        if (onErrorRetryTap != null) {
          onErrorRetryTap();
        }
      },
    );
  }

  Widget _buildDefaultLoadingWidget() {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }
}

class EmptyFutureBuilderWidget<T> extends FutureBuilderWidget<T> {
  final Future<T> future;
  final T initialData;
  final AsyncWidgetBuilder<T> builder;

  EmptyFutureBuilderWidget({
    this.future,
    this.initialData,
    @required this.builder,
  }) : super(
          loadingWidget: EmptyWidget(),
          errorWidget: EmptyWidget(),
          future: future,
          initialData: initialData,
          builder: builder,
        );
}

class SliverEmptyFutureBuilderWidget<T> extends FutureBuilderWidget<T> {
  final Future<T> future;
  final T initialData;
  final AsyncWidgetBuilder<T> builder;

  SliverEmptyFutureBuilderWidget({
    this.future,
    this.initialData,
    @required this.builder,
  }) : super(
          loadingWidget: SliverToBoxAdapter(),
          errorWidget: SliverToBoxAdapter(),
          future: future,
          initialData: initialData,
          builder: builder,
        );
}
