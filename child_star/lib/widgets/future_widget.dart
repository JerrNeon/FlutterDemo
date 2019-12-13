import 'package:child_star/common/resource_index.dart';
import 'package:child_star/common/router/routers_navigate.dart';
import 'package:child_star/i10n/gm_localizations_intl.dart';
import 'package:child_star/states/profile_notifier.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

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
          style: TextStyle(
            color: MyColors.c_686868,
            fontSize: MyFontSizes.s_14,
          ),
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

class UserWidget extends StatelessWidget {
  final Widget child;

  const UserWidget({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    if (userProvider.isLogin) {
      return child;
    } else {
      return Center(
        child: GestureDetector(
          onTap: () => RoutersNavigate().navigateToLogin(context),
          child: Container(
            width: MySizes.s_200,
            height: MySizes.s_200,
            color: Colors.white,
            child: Text(
              "请登录",
              style: TextStyle(
                color: MyColors.c_686868,
                fontSize: MyFontSizes.s_16,
              ),
            ),
          ),
        ),
      );
    }
  }
}
