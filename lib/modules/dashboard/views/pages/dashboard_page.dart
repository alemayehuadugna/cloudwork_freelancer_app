import 'package:CloudWork_Freelancer/modules/job/views/job_list/bloc/list_job_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../_core/di/get_It.dart';
import '../../../../_shared/interface/bloc/auth/auth_bloc.dart';
import '../../../payments/views/bloc/transaction_bloc/transaction_bloc.dart';
import '../../../review/router.dart';
import '../widgets/job_tile.dart';
import '../widgets/widgets.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ListJobBloc>(
      create: (context) => container(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 56,
        width: double.infinity,
        child: SingleChildScrollView(
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Column(
                children: [
                  ResponsiveRowColumn(
                    layout: ResponsiveWrapper.of(context).isLargerThan(TABLET)
                        ? ResponsiveRowColumnType.ROW
                        : ResponsiveRowColumnType.COLUMN,
                    children: [
                      ResponsiveRowColumnItem(
                        rowFlex: 1,
                        child: StaggeredGrid.count(
                          crossAxisCount:
                              ResponsiveWrapper.of(context).isMobile ? 1 : 2,
                          children: [
                            DashboardCount(
                              label: "Completed Jobs",
                              count: state is Authenticated
                                  ? "${state.user.completedJobs}"
                                  : "0",
                              viewMoreRoute: '',
                            ),
                            DashboardCount(
                              label: 'Cancelled Jobs',
                              count: state is Authenticated
                                  ? "${state.user.cancelledJobs}"
                                  : "0",
                              viewMoreRoute: '',
                            ),
                            DashboardCount(
                              label: 'Ongoing Jobs',
                              count: state is Authenticated
                                  ? "${state.user.ongoingJobs}"
                                  : "0",
                              viewMoreRoute: reviewRouteName,
                            ),
                            DashboardCount(
                              label: 'Reviews',
                              count: state is Authenticated
                                  ? "${state.user.numberOfReviews}"
                                  : "0",
                              viewMoreRoute: reviewRouteName,
                            ),
                          ],
                        ),
                      ),
                      ResponsiveRowColumnItem(
                        rowFlex: 1,
                        child: DashboardStatic(
                          cancelledJobs: state is Authenticated
                              ? state.user.cancelledJobs
                              : 0,
                          completedJobs: state is Authenticated
                              ? state.user.completedJobs
                              : 0,
                          ongoingJobs: state is Authenticated
                              ? state.user.ongoingJobs
                              : 0,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "Recently Posted Jobs",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Divider(),
                          BlocBuilder<ListJobBloc, ListJobState>(
                            builder: (context, state) {
                              print("state: $state");
                              if (state is ListJobInitial) {
                                BlocProvider.of<ListJobBloc>(context).add(
                                    const ListJobInSubmitted(
                                        pageSize: 10, pageKey: 1));
                                return Container();
                              } else if (state is ListJobLoaded) {
                                return SizedBox(
                                  width: double.infinity,
                                  height: 367,
                                  child: state.job.isEmpty
                                      ? Center(
                                          child: Text(
                                            "Jobs Not Found",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                        )
                                      : ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: state.job.length,
                                          itemBuilder: (context, index) {
                                            state.job;
                                            return JobTile(
                                              job: state.job[index],
                                            );
                                          },
                                        ),
                                );
                              } else if (state is ListJobLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return const Center(
                                  child: Text("Error Loading Jobs"),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
