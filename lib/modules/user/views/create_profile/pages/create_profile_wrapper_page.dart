import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../_core/di/get_It.dart';
import '../../view_profile/bloc/detail_user_bloc.dart';
import '../bloc/update_profile_bloc.dart';

class CreateProfileWrapperPage extends StatelessWidget {
  const CreateProfileWrapperPage({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveWrapper.of(context).isMobile;
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => container<DetailUserBloc>()),
          BlocProvider(create: (context) => container<UpdateProfileBloc>()),
        ],
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            foregroundColor: Theme.of(context).backgroundColor,
            title: Text(
              "CloudWork",
              style: Theme.of(context).primaryTextTheme.headlineSmall,
            ),
            toolbarHeight: isMobile ? 56 : 70,
            actions: [
              SizedBox(
                height: 30,
                width: 30,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
              const SizedBox(width: 25)
            ],
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: LoaderOverlay(
              useDefaultLoading: false,
              overlayWidget: Center(
                child: SpinKitCircle(
                  color: Theme.of(context).colorScheme.secondary,
                  size: 50.0,
                ),
              ),
              overlayColor: Colors.black,
              overlayOpacity: 0.01,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
