import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import 'widgets/widgets.dart';

// ignore: must_be_immutable
class ErrorPage extends StatelessWidget {
  final Exception? error;
  late String message;

  ErrorPage({Key? key, this.error}) : super(key: key) {
    if (error != null) {
      message = error.toString();
    } else {
      message = 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    if (authBloc.state is AuthLoading) {
      return Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Body(),
      ),
    );
  }
}
