import 'package:CloudWork_Freelancer/modules/user/router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../_shared/interface/layout/widgets/cloudwork_logo.dart';
import '../../../../_shared/interface/layout/widgets/cloudwork_name.dart';
import '../../../../_shared/interface/widgets/rating_bar.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveWrapper.of(context).isMobile;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.3),
        backgroundColor: Theme.of(context).colorScheme.background,
        toolbarHeight: 85,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CloudworkLogo(height: 55),
            const SizedBox(width: 10),
            if (!isMobile)
              const CloudworkName(
                fontSize: 32,
              ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
            child: TextButton.icon(
              onPressed: () {
                context.goNamed(loginRouteName);
              },
              icon: const Icon(Icons.login),
              label: const Text(' Login '),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
            child: TextButton.icon(
              onPressed: () {
                context.goNamed(createAccountRouteName);
              },
              icon: const Icon(Icons.person_add),
              label: const Text('Register'),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: PageView(
        scrollDirection: Axis.vertical,
        // allowImplicitScrolling: true,
        // pageSnapping: true,
        children: const [FirstPage(), SecondPage(), ThirdPage(), FourthPage()],
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveWrapper.of(context).isMobile;
    return Padding(
      padding: EdgeInsets.only(
          left: isMobile ? 40 : 130, right: isMobile ? 40 : 130),
      child: Row(children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "With the Ethiopian's #1 Freelancer Marketplace",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.6)),
                ),
                const Text(
                  "Get the perfect",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 70,
                  ),
                ),
                Text(
                  "Freelancers & Jobs",
                  style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                const Text(
                  "every time",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 70,
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: SvgPicture.asset(
            'assets/icons/Completed-pana.svg',
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ]),
    );
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveWrapper.of(context).isMobile;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(
                  left: isMobile ? 40 : 130, right: isMobile ? 40 : 130),
              child: ResponsiveRowColumn(
                rowSpacing: 10,
                rowCrossAxisAlignment: CrossAxisAlignment.start,
                layout: isMobile
                    ? ResponsiveRowColumnType.COLUMN
                    : ResponsiveRowColumnType.ROW,
                children: [
                  ResponsiveRowColumnItem(
                    rowFlex: 1,
                    child: InkWell(
                      onHover: (val) {
                        setState(() {
                          isHover = val;
                        });
                      },
                      child: Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: SizedBox(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: SvgPicture.asset(
                                    "assets/icons/shared_workspace.svg",
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  "919,207",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "FREELANCERS",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground
                                              .withOpacity(0.6)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    rowFlex: 1,
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: SizedBox(
                          child: Column(
                            children: [
                              Expanded(
                                child: SvgPicture.asset(
                                  "assets/icons/working_remotely.svg",
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                "20 - 100+",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "FREELANCERS PER JOBS",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground
                                            .withOpacity(0.6)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    rowFlex: 1,
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: SizedBox(
                          child: Column(
                            children: [
                              Expanded(
                                child: SvgPicture.asset(
                                  "assets/icons/project_complete.svg",
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                "388,615",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "COMPLETED JOBS",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground
                                            .withOpacity(0.6)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          Expanded(
            flex: 5,
            child: ResponsiveRowColumn(
              layout: isMobile
                  ? ResponsiveRowColumnType.COLUMN
                  : ResponsiveRowColumnType.ROW,
              children: [
                ResponsiveRowColumnItem(
                  rowFlex: 1,
                  child: Stack(
                    children: [
                      Container(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: SizedBox(
                                width: 60.0,
                                height: 100.0,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Center(
                                        child: FaIcon(
                                      FontAwesomeIcons.arrowRight,
                                      size: 30,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    )),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: SvgPicture.asset(
                                "assets/icons/accept_tasks.svg",
                                height: 230,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "I NEED A DEVELOPED PROJECT",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                  ),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              width: 35,
                              child: Divider(
                                thickness: 8,
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              "Get the perfect Developed project for your budget from our creative community.",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                  ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                ResponsiveRowColumnItem(
                  rowFlex: 1,
                  child: Stack(
                    children: [
                      Container(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.08),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: SvgPicture.asset(
                          "assets/icons/time_management.svg",
                          height: 230,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "I NEED A DEVELOPED PROJECT",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              width: 35,
                              child: Divider(
                                thickness: 8,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              "Do you want to earn money, find unlimited clients and build your freelance career?",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveWrapper.of(context).isMobile;
    return Padding(
      padding: EdgeInsets.only(
          left: isMobile ? 40 : 130, right: isMobile ? 40 : 130),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: SvgPicture.asset(
              'assets/icons/share.svg',
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "To make work more convenient, we developed the Cloudwork Mobile App.",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.6)),
                  ),
                  const Text(
                    "This app lets you track your time,",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                    ),
                  ),
                  const Text(
                    "message with clients,",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                    ),
                  ),
                  Text(
                    "post jobs and bid on projects.",
                    style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/app-store.svg',
                        width: 200,
                        height: 120,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      SvgPicture.asset(
                        'assets/icons/app-store.svg',
                        width: 200,
                        height: 120,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FourthPage extends StatelessWidget {
  const FourthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 35,
                  child: Divider(
                    thickness: 8,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Top Reviews",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  "High Performing Developers To Your",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.6)),
                ),
              ],
            ),
          ),
        ),
        Expanded(
            flex: 5,
            child: Column(
              children: [
                SizedBox(
                  height: 350,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 150),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Card(
                            child: SizedBox(
                              width: 500,
                              // color: Colors.amber,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 100,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/img-03.jpg"),
                                                fit: BoxFit.fill),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Deborah Angel",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge
                                                      ?.copyWith(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w700)),
                                              Text(
                                                "CEO",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                              const RatingBar(
                                                size: 25.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Flexible(
                                    child: SizedBox(
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          "Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Quisque velit nisi, pretium ut lacinia in, elementum id enim. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Donec sollicitudin molestie malesuada. Nulla quis lorem ut libero malesuada feugiat. Quisque velit nisi, pretium ut lacinia in, elementum id enim. Pellentesque in ipsum id orci porta dapibus.",
                                          softWrap: true,
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
                    ),
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
