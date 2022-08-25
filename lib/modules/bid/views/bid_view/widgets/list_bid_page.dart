import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../job/common/pagination.dart';
import 'package:readmore/readmore.dart';
import '../../../../job/domain/entities/job.dart';
import '../../../../job/views/job_list/bloc/list_job_bloc.dart';

class ListBidDisplay extends StatefulWidget {
  String kind;

  ListBidDisplay({
    required this.kind,
    Key? key,
  }) : super(key: key);

  @override
  State<ListBidDisplay> createState() => _ListBidDisplayState();
}

class _ListBidDisplayState extends State<ListBidDisplay>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const List<String> tabs = ['Bid', 'Ongoing', 'Completed', 'Canceled'];

    int selectedTabIndex(String kind) {
      switch (kind) {
        case 'bid':
          return 0;

        case 'ongoing':
          return 1;

        case 'completed':
          return 2;

        case 'canceled':
          return 3;

        default:
          return 0;
      }
    }

    _tabController.index = selectedTabIndex(widget.kind);

    return DefaultTabController(
      length: 5,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Scaffold(
            body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                // actions: [
                //   Container(
                //     margin: const EdgeInsets.all(10),
                //     child: BlocBuilder<ListJobBloc, ListJobState>(
                //         builder: (((context, state) {
                //       // List<JobEntity> job = [];
                //       if (state is ListJobLoaded) {
                //         // job = state.job;
                //       }
                //       return ElevatedButton(
                //         style: ButtonStyle(
                //           backgroundColor: MaterialStateProperty.all(
                //               Theme.of(context).colorScheme.secondary),
                //         ),
                //         onPressed: () {
                //           // context.goNamed(
                //           //   jobPostRouteName,
                //           //   params: {"kind": "all"},
                //           // );
                //         },
                //         child: Padding(
                //           padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                //           child: Text(
                //             "POST",
                //             style: TextStyle(
                //               color: Theme.of(context).colorScheme.primary,
                //             ),
                //           ),
                //         ),
                //       );
                //     }))),
                //   ),
                // ],

                title: const Padding(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Text("Manage Projects"),
                ),
                pinned: true,
                floating: true,
                bottom: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  onTap: _handleTabTapped,
                  tabs: [
                    for (String tab in tabs)
                      CustomTab(
                        label: tab,
                        width: ResponsiveValue<double>(context,
                                defaultValue: 200,
                                valueWhen: [
                                  const Condition.equals(
                                      name: MOBILE, value: 100),
                                  const Condition.largerThan(
                                      name: MOBILE, value: 200),
                                ]).value ??
                            200,
                      ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              CustomCard(kind: widget.kind, type: 'bid'),
              CustomCard(kind: widget.kind, type: 'ongoing'),
              CustomCard(kind: widget.kind, type: 'completed'),
              CustomCard(kind: widget.kind, type: 'cancelled'),
            ],
          ),
        )),
      ),
    );
  }

  void _handleTabTapped(int index) {
    switch (index) {
      case 0:
        context.go('/bids/bid');
        break;
      case 1:
        context.go('/bids/ongoing');
        break;
      case 2:
        context.go('/bids/completed');
        break;
      case 3:
        context.go('/bids/canceled');
        break;
    }
  }
}

class CustomTab extends StatelessWidget {
  const CustomTab({
    Key? key,
    required this.width,
    required this.label,
  }) : super(key: key);

  final double width;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Tab(text: label),
    );
  }
}

class CustomCard extends StatefulWidget {
  const CustomCard({Key? key, required this.kind, required this.type})
      : super(key: key);

  final String kind;
  final String type;

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  ScrollController? _scrollController;

  double offset = 0.0;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController() //keepScrollOffset: false removed
      ..addListener(() {
        setState(() {
          offset = _scrollController!.offset;
        });
      });
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: PagedListView(
            pagingController: pagingController,
            scrollController: _scrollController,
            builderDelegate: PagedChildBuilderDelegate<JobEntity>(
              itemBuilder: (context, item, index) =>
                  JobTile(job: item, type: widget.type, i: index),
            ),
          )),
    );
  }
}

class JobTile extends StatelessWidget {
  JobTile({Key? key, required this.job, required this.type, required this.i})
      : super(key: key);

  final JobEntity job;
  final String type;
  int i;

  @override
  Widget build(BuildContext context) {
    BuildContext tempContext = context;
    return type == 'bid'
        ?
        // ListView.builder(
        // itemCount: job.bid.length,
        // shrinkWrap: true,
        // itemBuilder: (context, i) {
        // return
        BidTile(
            job: job,
            i: i,
          )
        // },
        // )
        : job.progress == 'DELETED'
            ? const Center(child: Text("No Data To Show"))
            : Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(26, 20, 10, 20),
                  child: ResponsiveRowColumn(
                    rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                    rowCrossAxisAlignment: CrossAxisAlignment.center,
                    columnVerticalDirection: VerticalDirection.up,
                    rowSpacing: 15,
                    columnSpacing: 15,
                    layout: ResponsiveWrapper.of(context).isSmallerThan(TABLET)
                        ? ResponsiveRowColumnType.COLUMN
                        : ResponsiveRowColumnType.ROW,
                    children: [
                      ResponsiveRowColumnItem(
                        rowFlex: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Title(title: job.title),
                              const SizedBox(height: 10),
                              ResponsiveRowColumn(
                                rowCrossAxisAlignment:
                                    CrossAxisAlignment.center,
                                rowMainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                rowSpacing: 15,
                                columnSpacing: 30,
                                layout: ResponsiveWrapper.of(context)
                                        .isSmallerThan(TABLET)
                                    ? ResponsiveRowColumnType.COLUMN
                                    : ResponsiveRowColumnType.ROW,
                                children: [
                                  ResponsiveRowColumnItem(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        LanguageWidget(language: job.language),
                                        const SizedBox(width: 30),
                                        ExpiryWidget(expiry: job.expiry),
                                      ],
                                    ),
                                  ),
                                  ResponsiveRowColumnItem(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        BudgetWidget(
                                            budget: job.budget,
                                            duration: job.duration),
                                        const SizedBox(width: 20),
                                        ActionWidget(job: job),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                      ResponsiveRowColumnItem(
                        rowFlex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (identical(job.progress, 'COMPLETED') ||
                                identical(job.progress, 'ACTIVE')) ...[
                              Text(
                                "Hired By",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.merge(
                                      TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    ),
                              ),
                              const SizedBox(height: 10),
                              job.clientId!.first.profilePicture == null
                                  ? const Image(
                                      height: 100,
                                      width: 100,
                                      image: AssetImage(
                                          'assets/images/profile_placeholder.png'),
                                    )
                                  : Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: NetworkImage(job
                                              .clientId!.first.profilePicture),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                              const SizedBox(height: 10),
                              Text(
                                job.freelancerId == null
                                    ? "No Freelancer Assigned"
                                    : job.clientId!.first.firstName +
                                        " " +
                                        job.clientId!.first.lastName,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                            if (identical(job.progress, 'INACTIVE')) ...[
                              // Column(
                              //   crossAxisAlignment: ResponsiveWrapper.of(context)
                              //           .isSmallerThan(TABLET)
                              //       ? CrossAxisAlignment.center
                              //       : CrossAxisAlignment.end,
                              //   children: [
                              //     SvgPicture.asset(
                              //       "assets/icons/agreement-bro.svg",
                              //       height: 100,
                              //     ),
                              //     Row(
                              //       mainAxisAlignment: ResponsiveWrapper.of(context)
                              //               .isSmallerThan(TABLET)
                              //           ? MainAxisAlignment.center
                              //           : MainAxisAlignment.end,
                              //       children: [
                              //         Padding(
                              //           padding: const EdgeInsets.only(right: 10),
                              //           child: Text(
                              //             "Proposals",
                              //             style:
                              //                 Theme.of(context).textTheme.bodyLarge,
                              //           ),
                              //         ),
                              //         Text(
                              //           job.proposals.toString(),
                              //           style: Theme.of(context)
                              //               .textTheme
                              //               .headline5
                              //               ?.merge(
                              //                 TextStyle(
                              //                   color: Theme.of(context)
                              //                       .colorScheme
                              //                       .secondary,
                              //                 ),
                              //               ),
                              //         ),
                              //       ],
                              //     ),
                              //   ],
                              // ),
                            ],
                            if (identical(job.progress, 'CANCELLED')) ...[
                              // SizedBox(
                              //   width: 169,
                              //   child: Text("Cancelled"),
                              //   // BlocConsumer<JobDetailBloc, JobDetailState>(
                              //   //   listener: ((context, state) {
                              //   //     if (state is ChangeJobProgressLoaded) {
                              //   //       showDialog<void>(
                              //   //         context: context,
                              //   //         barrierDismissible: false,
                              //   //         builder: (BuildContext context) {
                              //   //           return AlertDialog(
                              //   //             title: const Text('Posting Job Again'),
                              //   //             content: SingleChildScrollView(
                              //   //               child: ListBody(
                              //   //                 children: [
                              //   //                   Padding(
                              //   //                     padding:
                              //   //                         const EdgeInsets.fromLTRB(
                              //   //                             0, 10, 0, 10),
                              //   //                     child: SizedBox(
                              //   //                       height: 200,
                              //   //                       width:
                              //   //                           ResponsiveValue<double>(
                              //   //                                   context,
                              //   //                                   defaultValue: 400,
                              //   //                                   valueWhen: const [
                              //   //                                     Condition
                              //   //                                         .smallerThan(
                              //   //                                             name:
                              //   //                                                 TABLET,
                              //   //                                             value:
                              //   //                                                 300)
                              //   //                                   ]).value ??
                              //   //                               400,
                              //   //                       child: SvgPicture.asset(
                              //   //                         "assets/icons/completed.svg",
                              //   //                       ),
                              //   //                     ),
                              //   //                   ),
                              //   //                   const Text(
                              //   //                       "You Posted Job Again SuccessFully"),
                              //   //                 ],
                              //   //               ),
                              //   //             ),
                              //   //             actions: <Widget>[
                              //   //               TextButton(
                              //   //                 child: const Text('Approve'),
                              //   //                 onPressed: () {
                              //   //                   Navigator.of(context).pop();
                              //   //                   context.loaderOverlay.hide();
                              //   //                   pagingController.itemList = null;
                              //   //                   BlocProvider.of<ListJobBloc>(
                              //   //                           tempContext)
                              //   //                       .add(
                              //   //                     ListJobInSubmitted(
                              //   //                       pageKey: 0,
                              //   //                       pageSize: 10,
                              //   //                       clientId: clientId!,
                              //   //                     ),
                              //   //                   );
                              //   //                 },
                              //   //               ),
                              //   //             ],
                              //   //           );
                              //   //         },
                              //   //       );
                              //   //     } else if (state
                              //   //         is ErrorLoadingChangeJobProgress) {
                              //   //       showTopSnackBar(
                              //   //           title: const Text('Error'),
                              //   //           content: Text(state.message),
                              //   //           icon: const Icon(Icons.error),
                              //   //           context: context);
                              //   //       context.loaderOverlay.hide();
                              //   //     }
                              //   //   }),
                              //   //   builder: ((context, state) {
                              //   //     return ElevatedButton(
                              //   //       style: ButtonStyle(
                              //   //         backgroundColor: MaterialStateProperty.all(
                              //   //             Theme.of(context)
                              //   //                 .colorScheme
                              //   //                 .secondary),
                              //   //       ),
                              //   //       onPressed: () {
                              //   //         showDialog<void>(
                              //   //           context: context,
                              //   //           barrierDismissible: true,
                              //   //           builder: (BuildContext context) {
                              //   //             return AlertDialog(
                              //   //               title:
                              //   //                   const Text('Posting Job Again'),
                              //   //               content: SingleChildScrollView(
                              //   //                 child: ListBody(
                              //   //                   children: const [
                              //   //                     Text("Are you sure?"),
                              //   //                   ],
                              //   //                 ),
                              //   //               ),
                              //   //               actions: <Widget>[
                              //   //                 TextButton(
                              //   //                   child: Text(
                              //   //                     'Approve',
                              //   //                     style: TextStyle(
                              //   //                       color: Theme.of(context)
                              //   //                           .colorScheme
                              //   //                           .secondary,
                              //   //                     ),
                              //   //                   ),
                              //   //                   onPressed: () {
                              //   //                     Navigator.of(context).pop();
                              //   //                     context.loaderOverlay.hide();
                              //   //                     BlocProvider.of<JobDetailBloc>(
                              //   //                             tempContext)
                              //   //                         .add(
                              //   //                       GetJobProgressEvent(
                              //   //                           id: job.id,
                              //   //                           progress: 'INACTIVE',
                              //   //                           freelancerId: job.freelancerId!.first.freelancerId,
                              //   //                           clientId: job.clientId!),
                              //   //                     );
                              //   //                   },
                              //   //                 ),
                              //   //               ],
                              //   //             );
                              //   //           },
                              //   //         );
                              //   //       },
                              //   //       child: Padding(
                              //   //         padding:
                              //   //             const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              //   //         child: Text(
                              //   //           "Repost",
                              //   //           style: TextStyle(
                              //   //             color: Theme.of(context)
                              //   //                 .colorScheme
                              //   //                 .primary,
                              //   //           ),
                              //   //         ),
                              //   //       ),
                              //   //     );
                              //   //   }),
                              //   // ),
                              // ),

                              SvgPicture.asset(
                                "assets/icons/inbox-cleanup-amico.svg",
                                height: 100,
                              ),
                              // GestureDetector(
                              //   onTap: () {
                              //     showDialog<void>(
                              //       context: context,
                              //       barrierDismissible: true,
                              //       builder: (BuildContext context) {
                              //         return AlertDialog(
                              //           title: const Text('Deleting Job'),
                              //           content: SingleChildScrollView(
                              //             child: ListBody(
                              //               children: const [
                              //                 Text("Are you sure?"),
                              //               ],
                              //             ),
                              //           ),
                              //           actions: <Widget>[
                              //             TextButton(
                              //               child: Text(
                              //                 'Approve',
                              //                 style: TextStyle(
                              //                   color: Theme.of(context)
                              //                       .colorScheme
                              //                       .secondary,
                              //                 ),
                              //               ),
                              //               onPressed: () {
                              //                 // Navigator.of(context).pop();
                              //                 // context.loaderOverlay.hide();
                              //                 // BlocProvider.of<ListJobBloc>(
                              //                 //         tempContext)
                              //                 //     .add(
                              //                 //   DeleteJobEvent(
                              //                 //     id: job.id,
                              //                 //     freelancerId: job.freelancerId!.first.freelancerId,
                              //                 //     clientId: job.clientId!
                              //                 //   ),
                              //                 // );
                              //               },
                              //             ),
                              //           ],
                              //         );
                              //       },
                              //     );
                              //   },
                              //   child: Text(
                              //     "Delete Project",
                              //     style:
                              //         Theme.of(context).textTheme.bodyLarge?.merge(
                              //               TextStyle(
                              //                 color: Theme.of(context)
                              //                     .colorScheme
                              //                     .secondary,
                              //               ),
                              //             ),
                              //   ),
                              // ),
                            ],
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
  }
}

class ExpiryWidget extends StatelessWidget {
  const ExpiryWidget({
    Key? key,
    required this.expiry,
  }) : super(key: key);

  final String? expiry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Expiry",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          expiry == null
              ? 'Not Specified'
              : "${expiry!.split('::')[0]} Days Left",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({
    Key? key,
    required this.language,
  }) : super(key: key);

  final String? language;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Language",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          language == null ? 'No Language' : language.toString(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}

class BudgetWidget extends StatelessWidget {
  const BudgetWidget({
    Key? key,
    required this.budget,
    required this.duration,
  }) : super(key: key);

  final double? budget;
  final int? duration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$budget ETB",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 10),
        Text(
          "in $duration Days",
          style: Theme.of(context).textTheme.bodyLarge?.merge(
                TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
        )
      ],
    );
  }
}

class ActionWidget extends StatelessWidget {
  const ActionWidget({
    Key? key,
    required this.job,
  }) : super(key: key);

  final JobEntity job;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // if (job.progress == 'ACTIVE' || job.progress == 'COMPLETED') ...[
        //   SizedBox(
        //     width: 169,
        //     child: ElevatedButton(
        //       style: ButtonStyle(
        //         backgroundColor: MaterialStateProperty.all(
        //             Theme.of(context).colorScheme.secondary),
        //       ),
        //       onPressed: () {
        //         // context.goNamed(jobDetailRouteName, params: {
        //         //   "kind": "all",
        //         //   "id": job.id,
        //         //   "tabKind": 'overview'
        //         // });
        //       },
        //       child: Padding(
        //         padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        //         child: Text(
        //           "View Details",
        //           style: TextStyle(
        //             color: Theme.of(context).colorScheme.primary,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        //   const SizedBox(height: 10),
        // ],
        // if (job.progress == 'INACTIVE') ...[
        //   ElevatedButton(
        //     style: ButtonStyle(
        //       backgroundColor: MaterialStateProperty.all(
        //           Theme.of(context).colorScheme.secondary),
        //     ),
        //     onPressed: () {
        //       // context.goNamed(jobProposalRouteName,
        //       //     params: {"kind": "all", "id": job.id});
        //     },
        //     child: Padding(
        //       padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        //       child: Text(
        //         "View proposals",
        //         style: TextStyle(
        //           color: Theme.of(context).colorScheme.primary,
        //         ),
        //       ),
        //     ),
        //   ),
        //   const SizedBox(height: 10),
        // ],
        // if (identical(job.progress, 'INACTIVE')) ...[
        //   SizedBox(
        //     width: 169,
        //     child: ElevatedButton(
        //       style: ButtonStyle(
        //         backgroundColor: MaterialStateProperty.all(
        //             Theme.of(context).colorScheme.secondary),
        //       ),
        //       onPressed: () {
        //         // context.goNamed(jobEditRouteName,
        //         //     params: {"kind": "all", "id": job.id});
        //       },
        //       child: Padding(
        //         padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        //         child: Text(
        //           "Edit Jobs",
        //           style: TextStyle(
        //             color: Theme.of(context).colorScheme.primary,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        //   const SizedBox(height: 10),
        // ],

        if (identical(job.progress, 'ACTIVE')) ...[
          Text(
            job.expiry == null
                ? "Not Hired"
                : "Hired on ${job.expiry!.split('::')[1].split(':')[0].split('-')[2].split('T')[0]} ${job.expiry!.split('::')[1].split('-')[1]} ${job.expiry!.split('::')[1].split('-')[0]}",
            style: Theme.of(context).textTheme.bodyMedium?.merge(
                  TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
          ),
          const SizedBox(height: 10),
        ],
        if (identical(job.progress, 'COMPLETED')) ...[
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 5),
                child: Icon(Icons.tiktok),
              ),
              Text(
                "Completed",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
            ],
          ),
          const SizedBox(height: 10),
          RatingBarIndicator(
            rating: 2.75,
            itemBuilder: (context, index) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemCount: 5,
            itemSize: 25.0,
            direction: Axis.horizontal,
          ),
        ],
      ],
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: ResponsiveValue<TextStyle?>(context,
              defaultValue: Theme.of(context).textTheme.headline4,
              valueWhen: [
                Condition.equals(
                    name: TABLET, value: Theme.of(context).textTheme.headline5),
                Condition.smallerThan(
                    name: TABLET, value: Theme.of(context).textTheme.headline6)
              ]).value ??
          Theme.of(context).textTheme.headline4,
    );
  }
}

class BidTile extends StatelessWidget {
  const BidTile({
    Key? key,
    required this.job,
    required this.i,
  }) : super(key: key);

  final JobEntity job;
  final int i;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Card(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                  job.bid[i].freelancer.profilePicture!,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ResponsiveRowColumn(
                                rowSpacing: 5,
                                columnSpacing: 5,
                                rowMainAxisAlignment: MainAxisAlignment.center,
                                columnCrossAxisAlignment:
                                    CrossAxisAlignment.center,
                                rowMainAxisSize: MainAxisSize.max,
                                layout: ResponsiveWrapper.of(context)
                                        .isSmallerThan(TABLET)
                                    ? ResponsiveRowColumnType.COLUMN
                                    : ResponsiveRowColumnType.ROW,
                                children: [
                                  ResponsiveRowColumnItem(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          job.bid[i].freelancer.firstName!
                                                  .toUpperCase() +
                                              ' ' +
                                              job.bid[i].freelancer.lastName!
                                                  .toUpperCase(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                        ),
                                        const SizedBox(height: 10),
                                        Text(job.title),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                  const ResponsiveRowColumnItem(
                                      child: SizedBox(width: 50)),
                                  ResponsiveRowColumnItem(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          job.bid[i].budget.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4
                                              ?.merge(
                                                TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                ),
                                              ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "in ${job.bid[i].hours} hours",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                ]),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Column(
                      children: [
                        ReadMoreText(
                          job.bid[i].coverLetter!,
                          trimLines: 2,
                          colorClickableText: Colors.pink,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Show more',
                          trimExpandedText: 'Show less',
                          moreStyle: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          lessStyle: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
