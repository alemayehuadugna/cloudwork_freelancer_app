import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../bloc/list_alert_bloc/alert_bloc.dart';

class AlertPage extends StatelessWidget {
  const AlertPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     BlocProvider.of<AlertBloc>(context).add(SendAlertEvent());
      //   },
      //   child: const Icon(Icons.add),
      // ),
      body: BlocBuilder<AlertBloc, AlertState>(
        builder: (context, state) {
          if (state is AlertLoaded) {
            return ListView.builder(
              itemCount: state.alertList.length,
              itemBuilder: ((context, index) {
                String sentAt = Jiffy(state.alertList[index].sentAt).fromNow();
                return TimelineTile(
                  alignment: TimelineAlign.manual,
                  lineXY: ResponsiveWrapper.of(context).isLargerThan(TABLET)
                      ? 0.1
                      : 0.2,
                  endChild: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Card(
                      elevation: 0.3,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.alertList[index].title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontStyle: FontStyle.italic),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              state.alertList[index].message,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(DateFormat.yMMMMEEEEd()
                                  .format(state.alertList[index].sentAt)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  startChild: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.all(5),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        sentAt,
                      ),
                    ),
                  ),
                );
              }),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
