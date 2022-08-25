import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../_shared/interface/widgets/show_top_flash.dart';
import '../bloc/get_job_bloc.dart';
import '../widgets/widgets.dart';

class JobDetailPage extends StatelessWidget {
  final String? id;
  const JobDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobDetailBloc, JobDetailState>(
      listener: ((context, state) {
        if (state is JobDetailLoading) {
          context.loaderOverlay.show();
        } else if (state is ErrorLoadingJobDetail) {
          context.loaderOverlay.hide();
          showTopSnackBar(
              title: const Text('Error'),
              content: Text(state.message),
              icon: const Icon(Icons.error),
              context: context);
          context.pop();
        }
      }),
      builder: ((context, state) {
        if (state is JobDetailInitial) {
          var _jobDetailBloc = BlocProvider.of<JobDetailBloc>(context);
          _jobDetailBloc.add(GetJobEvent(id: id!));
          return Container();
        } if (state is JobDetailLoaded) {
          context.loaderOverlay.hide();

          return Scaffold(
            appBar: AppBar(title: const Text('Job Detail Page')),
            body: SingleChildScrollView(
              child: JobDetailDisplay(job: state.job),
            ),
          );
        } else {
          return Container();
          // return Container(
          //   child: Center(
          //     child: Column(
          //       children: [
          //         Text("Error Getting Job Detail"),
          //       ],
          //     ),
          //   ),
          // );
        }
      }),
    );
  }
}
