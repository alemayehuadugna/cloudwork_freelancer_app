import 'package:CloudWork_Freelancer/modules/dashboard/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveWrapper.of(context).isMobile
          ? AppBar(
              title: const Text("Bookmark"),
              leading: BackButton(
                onPressed: () {
                  context.goNamed(homeRouteName);
                },
              ),
            )
          : null,
      body: SizedBox(
        height: MediaQuery.of(context).size.height - 56,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AlignedGridView.extent(
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            maxCrossAxisExtent: 500,
            itemBuilder: (context, index) {
              return Card(
                elevation: 1,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(child: SizedBox()),
                              const SizedBox(width: 50),
                              Container(
                                width: 84,
                                height: 84,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/company.png"),
                                      fit: BoxFit.fill),
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              IconButton(
                                iconSize: 36,
                                splashRadius: 32,
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.favorite_outline,
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                          Text(
                            "AMAZE TECH",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "UI/UX Developer",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground
                                        .withOpacity(0.7),
                                    fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Posted Just Now",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground
                                        .withOpacity(0.7),
                                    fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Alabama, USA",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
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
                              for (int i = 0; i < 3; i++)
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
                                    child: const Text(
                                      "Web Design",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "40 ETB - 500 ETB",
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
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
                                      "4 Days Left",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
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
                                      "14",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                  ],
                                ),
                                const VerticalDivider(width: 0.5),
                                Column(
                                  children: [
                                    Text(
                                      "Job Type",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                    Text(
                                      "Full Time",
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
                    ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          minimumSize: MaterialStateProperty.all(
                              const Size.fromHeight(45))),
                      onPressed: () {},
                      child: const Text("View Profile"),
                    )
                  ],
                ),
              );
            
            },
          ),
        ),
      ),
    );
  }
}
