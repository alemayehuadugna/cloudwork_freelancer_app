import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../dashboard/router.dart';
import '../../user/router.dart';
import '../router.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const SizedBox(
              width: 250,
              child: SettingActions(),
            ),
            Expanded(
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/setting.svg",
                      width: 400,
                      height: 400,
                    ),
                    Text(
                      "Change Your Setting",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 36,
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
          ],
        ),
      ),
    );
  }
}

class SettingMobilePage extends StatelessWidget {
  const SettingMobilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        leading: BackButton(
          onPressed: () {
            context.goNamed(homeRouteName);
          },
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: SettingActions(),
      ),
    );
  }
}

class ViewSetting extends StatelessWidget {
  const ViewSetting({
    Key? key,
    required this.body,
  }) : super(key: key);

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const SizedBox(
              width: 250,
              child: SettingActions(),
            ),
            Expanded(
              child: body,
            ),
          ],
        ),
      ),
    );
  }
}

class ViewSettingMobile extends StatelessWidget {
  const ViewSettingMobile({
    Key? key,
    required this.body,
  }) : super(key: key);

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: body,
    );
  }
}

class SettingActions extends StatelessWidget {
  const SettingActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  const Size.fromHeight(52),
                ),
              ),
              onPressed: () {
                context.goNamed(viewProfileRouteName);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [Text("My Profile"), Icon(Icons.navigate_next)],
              ),
            ),
            const SizedBox(height: 5),
            TextButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  const Size.fromHeight(52),
                ),
              ),
              onPressed: () {
                context.goNamed(editProfileRouteName);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Edit Profile"),
                  Icon(Icons.navigate_next)
                ],
              ),
            ),
            const SizedBox(height: 5),
            TextButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  const Size.fromHeight(52),
                ),
              ),
              onPressed: () {
                context.goNamed(changePasswordRouteName);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Change Password"),
                  Icon(Icons.navigate_next),
                ],
              ),
            ),
            const SizedBox(height: 5),
            TextButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  const Size.fromHeight(52),
                ),
              ),
              onPressed: () {
                context.goNamed(deleteAccountRouteName);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Delete Account"),
                  Icon(Icons.navigate_next),
                ],
              ),
            ),
            const SizedBox(height: 5),
            TextButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  const Size.fromHeight(52),
                ),
              ),
              onPressed: () {
                context.goNamed(giveFeedbackRouteName);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Write Feedback"),
                  Icon(Icons.navigate_next),
                ],
              ),
            ),
            const SizedBox(height: 5),
            TextButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  const Size.fromHeight(52),
                ),
              ),
              onPressed: () {
                context.goNamed(changePasswordRouteName);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Privacy and Policy"),
                  Icon(Icons.navigate_next),
                ],
              ),
            ),
            const SizedBox(height: 5),
            TextButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  const Size.fromHeight(52),
                ),
              ),
              onPressed: () {
                context.goNamed(changePasswordRouteName);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Logout"),
                  Icon(Icons.navigate_next),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
