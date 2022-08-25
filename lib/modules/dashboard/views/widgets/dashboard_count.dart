import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardCount extends StatelessWidget {
  const DashboardCount({
    Key? key,
    required this.count,
    required this.label,
    required this.viewMoreRoute,
  }) : super(key: key);

  final String label;
  final String count;
  final String viewMoreRoute;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    count,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary),
                  )
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    const Size.fromHeight(52),
                  ),
                ),
                onPressed: () {
                  context.goNamed(viewMoreRoute);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("View Detail"),
                    Icon(Icons.navigate_next)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
