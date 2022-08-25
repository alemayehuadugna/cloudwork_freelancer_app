import 'package:CloudWork_Freelancer/modules/job/common/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../_shared/interface/widgets/show_top_flash.dart';
import '../../../../job/common/pagination.dart';
import '../../../../job/domain/entities/job.dart';
import '../../../../job/views/job_list/bloc/list_job_bloc.dart';
import '../widgets/list_bid_page.dart';

class BidListPage extends StatefulWidget {
  final String? kind;

  const BidListPage({
    Key? key,
    required this.kind,
  }) : super(key: key);

  @override
  State<BidListPage> createState() => _BidListPageState();
}

class _BidListPageState extends State<BidListPage> {
  @override
  void initState() {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pageKey = 0;

    if (GoRouter.of(context).location == '/bids/bid') {
      if (pagingController.itemList != null) {
        pagingController.itemList = null;
      }
      count++;

      BlocProvider.of<ListJobBloc>(context).add(ListBidInSubmitted(
          pageKey: 0, pageSize: pageSize, freelancerId: ""));
    } else if (GoRouter.of(context).location == '/bids/ongoing') {
      if (pagingController.itemList != null) {
        pagingController.itemList = null;
      }
      count++;

      BlocProvider.of<ListJobBloc>(context).add(ListOngoingJobInSubmitted(
          pageKey: 0, pageSize: pageSize, freelancerId: ""));
    } else if (GoRouter.of(context).location == '/bids/completed') {
      if (pagingController.itemList != null) {
        pagingController.itemList = null;
      }
      count++;

      BlocProvider.of<ListJobBloc>(context).add(ListCompletedJobInSubmitted(
          pageKey: 0, pageSize: pageSize, freelancerId: ""));
    } else if (GoRouter.of(context).location == '/bids/canceled') {
      if (pagingController.itemList != null) {
        pagingController.itemList = null;
      }
      count++;

      BlocProvider.of<ListJobBloc>(context).add(ListCanceledJobInSubmitted(
          pageKey: 0, pageSize: pageSize, freelancerId: ""));
    }

    return BlocConsumer<ListJobBloc, ListJobState>(listener: ((context, state) {
      List<JobEntity> jobs = [];
      if (state is ListBidLoaded) {
        if (count != 0) {
          if (pagingController.itemList != null) {
            pagingController.itemList = null;
          }
          count = 0;
        }
        jobs = state.job;
        final isLastPage = jobs.length < pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(jobs);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(jobs, nextPageKey);
        }
      } else if (state is ListOngoingJobLoaded) {
        if (count != 0) {
          if (pagingController.itemList != null) {
            pagingController.itemList = null;
          }
          count = 0;
        }
        jobs = state.ongoingJob;
        final isLastPage = jobs.length < pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(jobs);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(jobs, nextPageKey);
        }
      } else if (state is ListCompletedJobLoaded) {
        if (count != 0) {
          if (pagingController.itemList != null) {
            pagingController.itemList = null;
          }
          count = 0;
        }
        jobs = state.completedJob;
        final isLastPage = jobs.length < pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(jobs);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(jobs, nextPageKey);
        }
      } else if (state is ListCanceledJobLoaded) {
        if (count != 0) {
          if (pagingController.itemList != null) {
            pagingController.itemList = null;
          }
          count = 0;
        }
        jobs = state.canceledJob;
        final isLastPage = jobs.length < pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(jobs);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(jobs, nextPageKey);
        }
      } else if (state is ListJobLoading) {
        context.loaderOverlay.show();
      } else if (state is ErrorLoadingListBid) {
        showTopSnackBar(
            title: const Text('Error'),
            content: Text(state.message),
            icon: const Icon(Icons.error),
            context: context);
        context.loaderOverlay.hide();
      } else if (state is ErrorLoadingListOngoingJob) {
        showTopSnackBar(
            title: const Text('Error'),
            content: Text(state.message),
            icon: const Icon(Icons.error),
            context: context);
        context.loaderOverlay.hide();
      } else if (state is ErrorLoadingListCompletedJob) {
        showTopSnackBar(
            title: const Text('Error'),
            content: Text(state.message),
            icon: const Icon(Icons.error),
            context: context);
        context.loaderOverlay.hide();
      } else if (state is ErrorLoadingListCanceledJob) {
        showTopSnackBar(
            title: const Text('Error'),
            content: Text(state.message),
            icon: const Icon(Icons.error),
            context: context);
        context.loaderOverlay.hide();
      } else if (state is ErrorLoadingListJob) {
        context.loaderOverlay.hide();
        showTopSnackBar(
            title: const Text('Error'),
            content: Text(state.message),
            icon: const Icon(Icons.error),
            context: context);
      }
    }), builder: ((context, state) {
      // return Container();
      return ListBidDisplay(kind: widget.kind!);
    }));
  }

  Future<void> _fetchPage(int pagekey) async {
    pageKey = pagekey;
    try {
      if (widget.kind == 'bid') {
        BlocProvider.of<ListJobBloc>(context).add(ListBidInSubmitted(
            pageKey: pagekey,
            pageSize: pageSize,
            freelancerId: ""));
      } else if (widget.kind == 'ongoing') {
        BlocProvider.of<ListJobBloc>(context).add(ListOngoingJobInSubmitted(
            pageKey: pagekey,
            pageSize: pageSize,
            freelancerId: ""));
      } else if (widget.kind == 'completed') {
        BlocProvider.of<ListJobBloc>(context).add(ListCompletedJobInSubmitted(
            pageKey: pagekey,
            pageSize: pageSize,
            freelancerId:""));
      } else if (widget.kind == 'canceled') {
        BlocProvider.of<ListJobBloc>(context).add(ListCanceledJobInSubmitted(
            pageKey: pagekey,
            pageSize: pageSize,
            freelancerId: ""));
      }
    } catch (error) {
      pagingController.error = error;
    }
  }
}
