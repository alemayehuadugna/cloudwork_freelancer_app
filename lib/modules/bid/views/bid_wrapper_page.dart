import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../_core/di/get_It.dart';
import '../../job/views/job_list/bloc/list_job_bloc.dart';

class BidWrapperPage extends StatelessWidget {
  const BidWrapperPage({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ListJobBloc>(
                create: (context) => container<ListJobBloc>()),
          ],
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
    );
  }
}
