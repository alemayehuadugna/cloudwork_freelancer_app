import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../_shared/interface/widgets/show_top_flash.dart';
import '../bloc/list_job_bloc.dart';
import '../widgets/list_job_display.dart';

class JobListPage extends StatefulWidget {
  const JobListPage({Key? key}) : super(key: key);

  @override
  State<JobListPage> createState() => _JobListPageState();
}

class _JobListPageState extends State<JobListPage> {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ListJobBloc, ListJobState>(listener: ((context, state) {
      if (state is ListJobLoading) {
        context.loaderOverlay.show();
      } else if (state is ErrorLoadingListJob) {
        context.loaderOverlay.hide();
        showTopSnackBar(
            title: const Text('Error'),
            content: Text(state.message),
            icon: const Icon(Icons.error),
            context: context);
      }
    }), builder: ((context, state) {
      if (state is ListJobInitial) {
        var _listJobBloc = BlocProvider.of<ListJobBloc>(context);
        _listJobBloc.add(ListJobInSubmitted(pageSize: 10, pageKey: 1));
        context.loaderOverlay.show();
        return Container();
      } else if (state is ListJobLoaded) {
        context.loaderOverlay.hide();
        return ListJobDisplay(job: state.job);
      } else {
        return Container();
      }
    }));
  }

}
