import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:readmore/readmore.dart';
import 'package:responsive_framework/responsive_row_column.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../../../../../_core/di/get_It.dart';
import '../../../../../_shared/interface/bloc/auth/auth_bloc.dart';
import '../../../../../_shared/interface/widgets/show_top_flash.dart';
import '../../../domain/entities/job.dart';
import '../../../domain/usecase/add_bid.dart';
import '../bloc/get_job_bloc.dart';

class JobDetailDisplay extends StatelessWidget {
  final JobDetailEntity job;

  JobDetailDisplay({required this.job, Key? key}) : super(key: key);

  List<String> list = ["HTML", "CSS", "Adobe Photoshop", "Java", "C++"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: ResponsiveRowColumn(
          rowMainAxisAlignment: MainAxisAlignment.start,
          rowCrossAxisAlignment: CrossAxisAlignment.start,
          columnSpacing: 10,
          rowSpacing: 10,
          layout: ResponsiveRowColumnType.COLUMN,
          children: [
            ResponsiveRowColumnItem(
              child: Card(
                elevation: 1,
                child: ResponsiveRowColumn(
                  rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                  rowCrossAxisAlignment: CrossAxisAlignment.start,
                  // rowMainAxisSize: MainAxisSize.max,
                  rowSpacing: 10,
                  columnSpacing: 10,
                  layout: ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
                      ? ResponsiveRowColumnType.COLUMN
                      : ResponsiveRowColumnType.ROW,
                  children: [
                    ResponsiveRowColumnItem(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              job.title,
                              style: ResponsiveValue<TextStyle?>(context,
                                      defaultValue:
                                          Theme.of(context).textTheme.headline4,
                                      valueWhen: [
                                        Condition.equals(
                                            name: TABLET,
                                            value: Theme.of(context)
                                                .textTheme
                                                .headline5),
                                        Condition.smallerThan(
                                            name: TABLET,
                                            value: Theme.of(context)
                                                .textTheme
                                                .headline6)
                                      ]).value ??
                                  Theme.of(context).textTheme.headline4,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              job.category,
                              style:
                                  Theme.of(context).textTheme.headline6?.merge(
                                        TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Icon(Icons.access_time),
                                ),
                                Text(
                                    "Posted on ${job.createdAt.year.toString() + '-' + job.createdAt.month.toString() + '-' + job.createdAt.day.toString()}",
                                    style:
                                        Theme.of(context).textTheme.subtitle2),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                    ResponsiveRowColumnItem(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 50, 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: ResponsiveWrapper.of(context)
                                        .isSmallerThan(DESKTOP)
                                    ? 0
                                    : 20,
                              ),
                              Text(
                                job.budget.toString() + ' Birr',
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
                              ElevatedButton(
                                onPressed: () {
                                  if (ResponsiveWrapper.of(context)
                                      .isLargerThan(MOBILE)) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          child: SizedBox(
                                              height: 720,
                                              width: 750,
                                              child: ProposalForm(id: job.id)),
                                        );
                                      },
                                    );
                                  } else {
                                    showGeneralDialog(
                                        context: context,
                                        transitionBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          const begin = Offset(0.0, 1.0);
                                          const end = Offset.zero;
                                          const curve = Curves.ease;

                                          var tween = Tween(
                                                  begin: begin, end: end)
                                              .chain(CurveTween(curve: curve));

                                          return SlideTransition(
                                            position: animation.drive(tween),
                                            child: child,
                                          );
                                        },
                                        pageBuilder: (context, anim, anis) {
                                          return SafeArea(
                                            child: SizedBox.expand(
                                              child: Scaffold(
                                                body: ProposalForm(id: job.id),
                                              ),
                                            ),
                                          );
                                        });
                                  }
                                },
                                child: const Text("Send Proposals"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ResponsiveRowColumnItem(
              child: ResponsiveRowColumn(
                rowCrossAxisAlignment: CrossAxisAlignment.start,
                rowSpacing: 15,
                layout: ResponsiveWrapper.of(context).isSmallerThan(TABLET)
                    ? ResponsiveRowColumnType.COLUMN
                    : ResponsiveRowColumnType.ROW,
                children: [
                  ResponsiveRowColumnItem(
                    rowFlex: 6,
                    child: ResponsiveRowColumn(
                      rowMainAxisAlignment: MainAxisAlignment.start,
                      // rowCrossAxisAlignment: CrossAxisAlignment.stretch,
                      columnSpacing: 15,
                      layout: ResponsiveRowColumnType.COLUMN,
                      children: [
                        ResponsiveRowColumnItem(
                          rowFlex: 1,
                          child: StaggeredGrid.extent(
                            // crossAxisCount:
                            //     ResponsiveWrapper.of(context).isLargerThan(TABLET)
                            //         ? 4
                            //         : ResponsiveWrapper.of(context).equals(TABLET)
                            //             ? 2
                            //             : ResponsiveWrapper.of(context)
                            //                     .isSmallerThan(TABLET)
                            //                 ? 1
                            //                 : 1,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            maxCrossAxisExtent: 400,
                            children: [
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Job Expiry",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        job.expiry == null
                                            ? 'Not Specified'
                                            : "${job.expiry!.split('::')[0]} Days Left",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Language",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        job.language!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Proposals",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      const SizedBox(height: 10),
                                      Text("${job.proposals} Received",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Start Date",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        job.startDate != null
                                            ? " ${job.startDate!.year.toString()} - ${job.startDate!.month.toString()} - ${job.startDate!.day.toString()}"
                                            : "Start Date Not Specified",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    // crossAxisAlignment:
                                    //     CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Project Duration",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        job.duration.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ResponsiveRowColumnItem(
                          child: Card(
                            elevation: 1,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 40, 0, 0),
                                    child: Text(
                                      job.title,
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                                  child: Divider(
                                    thickness: 1,
                                    endIndent: 20,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                    child: Text(
                                      job.description,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ResponsiveRowColumnItem(
                          child: Card(
                            elevation: 1,
                            child: Column(children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 40, 0, 0),
                                  child: Text(
                                    "Skills Required",
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                                child: Divider(
                                  thickness: 2,
                                  endIndent: 20,
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 0, 20),
                                  child: Wrap(
                                    children: [
                                      for (int i = 0;
                                          i < job.skills.length;
                                          i++)
                                        Wrap(
                                          children: [
                                            Card(
                                              elevation: 1,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Wrap(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        30, 10, 30, 10),
                                                    child: Text(
                                                      job.skills[i],
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              )
                            ]),
                          ),
                        ),
                        ResponsiveRowColumnItem(
                            child: Card(
                          elevation: 1,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 40, 0, 0),
                                  child: Text(
                                    "Project Proposals",
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                                child: Divider(
                                  thickness: 1,
                                  endIndent: 20,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Card(
                                  elevation: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        30, 15, 0, 15),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                        text: TextSpan(
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                            children: <TextSpan>[
                                              TextSpan(
                                                text:
                                                    "${job.proposals.toString()} Freelancers",
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                ),
                                              ),
                                              const TextSpan(
                                                  text: " are bidding"),
                                              const TextSpan(
                                                  text: " for this job")
                                            ]),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              ListView.builder(
                                itemCount: job.bid.length,
                                shrinkWrap: true,
                                itemBuilder: (context, i) {
                                  return BidTile(
                                    job: job,
                                    i: i,
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    rowFlex: 3,
                    child: ResponsiveRowColumn(
                      rowMainAxisAlignment: MainAxisAlignment.start,
                      columnSpacing: 15,
                      layout: ResponsiveRowColumnType.COLUMN,
                      children: [
                        ResponsiveRowColumnItem(
                          child: Card(
                            elevation: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(height: 20),
                                Column(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            job.clientId!.first.profilePicture,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      job.clientId!.first.firstName
                                              .toUpperCase() +
                                          ' ' +
                                          job.clientId!.first.lastName
                                              .toUpperCase(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    RatingBarIndicator(
                                      rating: 2.75,
                                      itemBuilder: (context, index) =>
                                          const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 25.0,
                                      direction: Axis.horizontal,
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Member Since",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                          Text(
                                              job.clientId!.first.createdAt
                                                      .year
                                                      .toString() +
                                                  '-' +
                                                  job.clientId!.first.createdAt
                                                      .month
                                                      .toString() +
                                                  '-' +
                                                  job.clientId!.first.createdAt
                                                      .day
                                                      .toString())
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      const Divider(
                                        thickness: 0.5,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Total Jobs",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                          Text(job.clientId!.first.completedJobs
                                              .toString()),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ResponsiveRowColumnItem(
                          child: Card(
                            elevation: 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 20, 20, 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Profile Link",
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                  const SizedBox(height: 5),
                                  const Divider(
                                    thickness: 0.5,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    initialValue:
                                        job.clientId!.first.profilePicture,
                                    decoration: InputDecoration(
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 0.0),
                                        ),
                                        border: const OutlineInputBorder(),
                                        suffixIcon: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.copy))),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BidTile extends StatelessWidget {
  const BidTile({
    Key? key,
    required this.job,
    required this.i,
  }) : super(key: key);

  final JobDetailEntity job;
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                    job.bid[i].freelancer.profilePicture!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            job.bid[i].freelancer.firstName!.toUpperCase()+
                                ' ' +
                                job.bid[i].freelancer.lastName!.toUpperCase(),
                            style: Theme.of(context).textTheme.headline4,
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
                          const SizedBox(height: 10),
                        ],
                      ),
                      const Expanded(child: SizedBox()),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                          children: [
                            Text(
                              job.bid[i].budget.toString(),
                              style:
                                  Theme.of(context).textTheme.headline4?.merge(
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
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
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

class ProposalForm extends StatelessWidget {
  ProposalForm({Key? key, required this.id}) : super(key: key);

  bool check = false;
  final String id;
  final _budgetController = TextEditingController();
  final _hoursController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "SEND PROPOSALS",
                  style: ResponsiveValue<TextStyle?>(context,
                          defaultValue: Theme.of(context).textTheme.headline4,
                          valueWhen: [
                            Condition.equals(
                                name: TABLET,
                                value: Theme.of(context).textTheme.headline5),
                            Condition.smallerThan(
                                name: TABLET,
                                value: Theme.of(context).textTheme.headline6)
                          ]).value ??
                      Theme.of(context).textTheme.headline4,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  icon: const Icon(Icons.close),
                  splashRadius: 25,
                  padding: EdgeInsets.zero,
                )
              ],
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 7),
                  BudgetFormWidget(controller: _budgetController),
                  const SizedBox(height: 10),
                  HoursFormWidget(controller: _hoursController),
                  const SizedBox(height: 10),
                  DescriptionFormWidget(controller: _descriptionController),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        onChanged: (bool? value) {
                          setState(() {
                            check = value!;
                          });
                        },
                        value: check,
                      ),
                      const Text("agree to the Terms And Conditions"),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30, right: 30),
              child: BlocProvider(
                create: (BuildContext context) => container<JobDetailBloc>(),
                child: ActionButton(
                    id: id,
                    formKey: _formKey,
                    budgetController: _budgetController,
                    hoursController: _hoursController,
                    descriptionController: _descriptionController,
                    check: check),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class ActionButton extends StatelessWidget {
  ActionButton(
      {Key? key,
      required this.id,
      required this.budgetController,
      required this.hoursController,
      required this.descriptionController,
      required this.formKey,
      required this.check})
      : super(key: key);

  final String id;
  final GlobalKey<FormState> formKey;
  final TextEditingController budgetController;
  final TextEditingController hoursController;
  final TextEditingController descriptionController;
  final bool check;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobDetailBloc, JobDetailState>(
      listener: (context, state) {
        if (state is ErrorLoadingAddProposal) {
          showTopSnackBar(
            title: const Text('Error'),
            content: Text(state.message),
            icon: const Icon(Icons.error),
            context: context,
          );
          context.loaderOverlay.hide();
        } else if (state is AddProposalLoaded) {
          showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Adding Proposal'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: SizedBox(
                          height: 200,
                          width: ResponsiveValue<double>(context,
                                  defaultValue: 400,
                                  valueWhen: const [
                                    Condition.smallerThan(
                                        name: TABLET, value: 300)
                                  ]).value ??
                              400,
                          child: SvgPicture.asset(
                            "assets/icons/completed.svg",
                          ),
                        ),
                      ),
                      const Text("Adding Proposal Successful"),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Approve'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.loaderOverlay.hide();
                      context.pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      },
      builder: (context, state) {
        BuildContext tempContext = context;
        return Align(
          alignment: Alignment.bottomRight,
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.secondary),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // getting budget
                    var budget = TextEditingValue(
                      text: budgetController.text,
                    );

                    // getting budget
                    var hours = TextEditingValue(
                      text: hoursController.text,
                    );

                    // getting description
                    var coverLetter = TextEditingValue(
                      text: descriptionController.text,
                    );

                    final payload = AddProposalParams(
                      id,
                      state is Authenticated ? state.user.id : null,
                      double.parse(budget.text),
                      int.parse(hours.text),
                      coverLetter.text,
                      check,
                    );

                    showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Adding Proposal'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: const [
                                Text("You Are Bidding On This Job"),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Approve'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                context.loaderOverlay.hide();
                                BlocProvider.of<JobDetailBloc>(tempContext)
                                    .add(AddProposalEvent(payload: payload));
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Submit Proposal",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class BudgetFormWidget extends StatefulWidget {
  BudgetFormWidget({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  State<BudgetFormWidget> createState() => _BudgetFormWidgetState();
}

class _BudgetFormWidgetState extends State<BudgetFormWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
      ],
      controller: widget.controller,
      onChanged: (String value) {
        var temp = TextEditingValue(
          text: widget.controller.text,
        );
      },
      decoration: const InputDecoration(
        isDense: true,
        label: Text("Budget"),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty || double.parse(value) < 50) {
          return "Incorrect Budget. hint: greater than 50.";
        }
        return null;
      },
    );
  }
}

class HoursFormWidget extends StatefulWidget {
  HoursFormWidget({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  State<HoursFormWidget> createState() => _HoursFormWidgetState();
}

class _HoursFormWidgetState extends State<HoursFormWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp('[0-9]'))
      ],
      controller: widget.controller,
      onChanged: (String value) {
        var temp = TextEditingValue(
          text: widget.controller.text,
        );
      },
      decoration: const InputDecoration(
        isDense: true,
        label: Text("Hours"),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty || double.parse(value) < 2) {
          return "Incorrect Hours. hint: At least it must be 2 hour";
        }
        return null;
      },
    );
  }
}

class DescriptionFormWidget extends StatefulWidget {
  DescriptionFormWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  State<DescriptionFormWidget> createState() => _DescriptionFormWidgetState();
}

class _DescriptionFormWidgetState extends State<DescriptionFormWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 7,
      maxLines: 7,
      controller: widget.controller,
      onChanged: (String value) {
        var temp = TextEditingValue(
          text: widget.controller.text,
        );
      },
      decoration: const InputDecoration(
        isDense: true,
        hintText: "Add CoverLetter",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "CoverLetter is required.";
        }
        return null;
      },
    );
  }
}
