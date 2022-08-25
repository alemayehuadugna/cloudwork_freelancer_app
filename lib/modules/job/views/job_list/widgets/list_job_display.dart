import 'package:CloudWork_Freelancer/modules/job/views/job_detail/bloc/get_job_bloc.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../domain/entities/job.dart';
import '../../../router.dart';
import '../bloc/list_job_bloc.dart';

class ListJobDisplay extends StatefulWidget {
  final List<JobEntity> job;

  const ListJobDisplay({required this.job, Key? key}) : super(key: key);

  @override
  State<ListJobDisplay> createState() => _ListJobDisplayState();
}

class _ListJobDisplayState extends State<ListJobDisplay> {
  double height = 0;
  bool showFilter = false;

  void changeFilterState(state) {
    setState(() {
      showFilter = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: double.infinity,
      height: ResponsiveWrapper.of(context).isMobile
          ? MediaQuery.of(context).size.height - 112
          : MediaQuery.of(context).size.height - 56,
      child: Scaffold(
        endDrawer: Drawer(
          child: FilterProperties(),
        ),
        body: ResponsiveRowColumn(
          rowCrossAxisAlignment: CrossAxisAlignment.start,
          rowSpacing: 10,
          columnSpacing: 3,
          layout: ResponsiveRowColumnType.ROW,
          children: [
            ResponsiveRowColumnItem(
              // rowFlex: 4,
              child: BlocBuilder<ListJobBloc, ListJobState>(
                builder: (((context, state) {
                  List<JobEntity> jobs = [];
                  if (state is ListJobLoaded) {
                    jobs = state.job;
                  }
                  return Expanded(
                    child: Column(
                      children: [
                        // FilterIconContainer(showFilter: changeFilterState),
                        ResponsiveRowColumnItem(
                            rowFlex: 1,
                            child:
                                // PagedListView(
                                //   pagingController: pagingController,
                                //   scrollController: _scrollController,
                                // builderDelegate:
                                // PagedChildBuilderDelegate<JobEntity>(
                                // itemBuilder: (context, item, index) =>

                                // for(var i = 0; i< jobs.length; i++)
                                // jobs.forEach((job) {

                                JobList(height: height, job: jobs)
                            // })

                            // ),
                            // ),
                            ),
                      ],
                    ),
                  );
                })),
              ),
            ),
            if (showFilter &&
                (ResponsiveWrapper.of(context).isLargerThan(TABLET)))
              ResponsiveRowColumnItem(
                child: Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    width: 311,
                    child: Column(
                      children: [
                        FilterTitle(showFilter: changeFilterState),
                        const SizedBox(height: 5),
                        FilterProperties(),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class JobList extends StatelessWidget {
  const JobList({
    required this.height,
    required this.job,
    Key? key,
  }) : super(key: key);

  final double height;
  final List<JobEntity> job;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 56,
      width: double.infinity,
      child: BlocBuilder<ListJobBloc, ListJobState>(builder: ((context, state) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: AlignedGridView.extent(
            shrinkWrap: true,
            maxCrossAxisExtent: 500,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            itemCount: job.length,
            itemBuilder: (context, index) {
              return JobTile(job: job[index]);
            },
          ),
        );

        // }
      })),
    );
  }
}

class JobTile extends StatelessWidget {
  const JobTile({
    Key? key,
    required this.job,
  }) : super(key: key);

  final JobEntity job;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child:
                      job.clientId!.first.profilePicture == 'profile_image_url'
                          ? Image.asset('assets/images/logo.png')
                          : Image.network(
                              job.clientId!.first.profilePicture,
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                ),
                Text(
                  job.title,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  job.category,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.7),
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "Posted on ${job.createdAt!.year - job.createdAt!.month - job.createdAt!.day}",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.7),
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  job.language!,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.7),
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    for (int i = 0; i < job.skills.length; i++)
                      Container(
                        width: 80,
                        height: 26,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .chipTheme
                              .backgroundColor!
                              .withOpacity(0.6),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            job.skills[i],
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      )
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  job.budget.toString(),
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.65)),
                ),
                const SizedBox(height: 4),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Expiry",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground
                                      .withOpacity(0.65),
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          Text(
                            job.expiry == null
                                ? 'Not Specified'
                                : "${job.expiry!.split('::')[0]} Days Left",
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                      const VerticalDivider(width: 0.5),
                      Column(
                        children: [
                          Text(
                            "Proposals",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground
                                      .withOpacity(0.65),
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          Text(
                            job.proposals.toString(),
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                      const VerticalDivider(width: 0.5),
                      Column(
                        children: [
                          Text(
                            "Duration",
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Text(
                            job.duration.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(color: Colors.green),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 3),
              ],
            ),
          ),
          BlocBuilder<JobDetailBloc, JobDetailState>(
            builder: ((context, state) {
              return ElevatedButton(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    minimumSize:
                        MaterialStateProperty.all(const Size.fromHeight(45))),
                onPressed: () {
                  if (!(state is JobDetailInitial)) {
                    var _jobDetailBloc =
                        BlocProvider.of<JobDetailBloc>(context);
                    _jobDetailBloc.emit(JobDetailInitial());
                  }
                  context.goNamed(jobDetailRouteName, params: {"id": job.id});
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text(
                    "Bid Now",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}

// class SelectedFilter extends StatelessWidget {
//   SelectedFilter({
//     Key? key,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.bottomLeft,
//       child: Wrap(
//         children: [
//           for (int i = 0; i < list.length; i++)
//             Wrap(
//               children: [
//                 SizedBox(
//                   height: 40,
//                   child: Card(
//                     elevation: 2,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: Wrap(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(8.0, 5, 8, 8),
//                           child: Text(
//                             list[i],
//                             // style: const TextStyle(
//                             //     fontWeight: FontWeight.normal,
//                             //     fontSize: 20,
//                             //     color: Colors.black,
//                             //     fontFamily: 'sans-serif'),
//                           ),
//                         ),
//                         const Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Icon(
//                             Icons.clear,
//                             size: 20,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//         ],
//       ),
//     );
//   }
// }

class FilterIconContainer extends StatelessWidget {
  FilterIconContainer({
    required this.showFilter,
    Key? key,
  }) : super(key: key);

  Function showFilter;
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: ResponsiveRowColumn(
              rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
              layout: ResponsiveRowColumnType.ROW,
              children: [
                const ResponsiveRowColumnItem(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                      child: Text("number of shown result")),
                ),
                ResponsiveRowColumnItem(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        showFilter(true);
                        if (ResponsiveWrapper.of(context)
                            .isSmallerThan(DESKTOP)) {
                          Scaffold.of(context).openEndDrawer();
                        }
                      },
                      child: const Text('show'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class FilterTitle extends StatelessWidget {
  FilterTitle({
    required this.showFilter,
    Key? key,
  }) : super(key: key);

  Function showFilter;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ResponsiveRowColumn(
          rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
          layout: ResponsiveRowColumnType.ROW,
          children: [
            ResponsiveRowColumnItem(
              rowFlex: 1,
              child: FittedBox(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Text(
                    'FILTERS',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            ResponsiveRowColumnItem(
              rowFlex: 1,
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      showFilter(false);
                    },
                    child: const Text('hide'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterProperties extends StatelessWidget {
  FilterProperties({
    Key? key,
  }) : super(key: key);

  // Initial Selected Value
  String? chosenValue;
  String? selectedProgress;

  // List of items in our dropdown menu
  List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  List<String> progresses = [
    'Active',
    'Inactive',
    'Completed',
    'Cancelled',
    'Deleted'
  ];

  RangeValues rangeSliderDiscreteValues = const RangeValues(40, 80);
  List<String> list = ["alex", "adugna", "temesgen", "neway", "aseged"];
  List<bool> checked = [false, false, false, false, false];
  List<String> exprience = ["0-1", "2-5", "5-8", "PROFESSIONALS", "MASTERED"];
  double height = 0;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return SizedBox(
          height: MediaQuery.of(context).size.height - 131,
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Card(
              elevation: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 15, 20, 5),
                      child: const Text(
                        'Clear All',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.yellow,
                            fontFamily: 'sans-serif'),
                      ),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.fromLTRB(20, 15, 0, 5),
                      alignment: Alignment.centerLeft,
                      child: const Text('Category',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: 'sans-serif'))),
                  Container(
                      padding: const EdgeInsets.fromLTRB(20, 15, 0, 5),
                      alignment: Alignment.centerLeft,
                      child: const Text('Proposals',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: 'sans-serif'))),
                  RangeSlider(
                    values: rangeSliderDiscreteValues,
                    min: 0,
                    max: 100,
                    labels: RangeLabels(
                      rangeSliderDiscreteValues.start.round().toString(),
                      rangeSliderDiscreteValues.end.round().toString(),
                    ),
                    onChanged: (values) {
                      setState(() {
                        rangeSliderDiscreteValues = values;
                      });
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 15, 0, 5),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Add skills',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.black,
                          fontFamily: 'sans-serif'),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(5, 15, 0, 5),
                    child: Wrap(
                      children: [
                        for (int i = 0; i < list.length; i++)
                          Wrap(
                            children: [
                              Card(
                                elevation: 2,
                                child: Wrap(
                                  children: [
                                    Text(list[i]),
                                    const Icon(
                                      Icons.clear,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 10, 5),
                    child: SizedBox(
                      // width: 200,
                      height: 40,
                      child: TextFormField(
                        initialValue: 'Input text',
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.fromLTRB(20, 15, 0, 5),
                      alignment: Alignment.centerLeft,
                      child: const Text('Budget',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: 'sans-serif'))),
                  RangeSlider(
                    values: rangeSliderDiscreteValues,
                    min: 0,
                    max: 100,
                    labels: RangeLabels(
                      rangeSliderDiscreteValues.start.round().toString(),
                      rangeSliderDiscreteValues.end.round().toString(),
                    ),
                    onChanged: (values) {
                      setState(() {
                        rangeSliderDiscreteValues = values;
                      });
                    },
                  ),
                  Container(
                      padding: const EdgeInsets.fromLTRB(20, 15, 0, 5),
                      alignment: Alignment.centerLeft,
                      child: const Text('Progress',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: 'sans-serif'))),
                  Container(
                      padding: const EdgeInsets.fromLTRB(20, 15, 0, 5),
                      alignment: Alignment.centerLeft,
                      child: const Text('Experience',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: 'sans-serif'))),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      children: [
                        for (var i = 0; i < 5; i += 1)
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: SizedBox(
                                  height: 24.0,
                                  width: 24.0,
                                  child: Checkbox(
                                    onChanged: (bool? value) {
                                      setState(() {
                                        checked[i] = value!;
                                      });
                                    },
                                    value: checked[i],
                                  ),
                                ),
                              ),
                              Text(
                                exprience[i],
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(color: Colors.black),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.start,
                          ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 15, 0, 5),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Keywords',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.black,
                          fontFamily: 'sans-serif'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 5, 5),
                    child: SizedBox(
                      // width: 200,
                      // height: 40,
                      child: TextFormField(
                        initialValue: 'Enter keywords',
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 5, 5),
                      child: SizedBox(
                        height: 40,
                        child: ConstrainedBox(
                          constraints:
                              const BoxConstraints(minWidth: double.infinity),
                          child: ElevatedButton(
                            onPressed: () {
                              // Respond to button press
                            },
                            child: const Text('SEARCH'),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.index,
    this.backgroundColor,
  }) : super(key: key);

  final int index;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(index.toString(), style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
