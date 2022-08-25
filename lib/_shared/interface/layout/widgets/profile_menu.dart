import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../modules/user/domain/entities/basic_user.dart';
import '../../../../modules/user/router.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/setting/theme_mode_cubit.dart';

class ProfilePopupMenu extends StatelessWidget {
  const ProfilePopupMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeModeCubit, ThemeModeState>(
      builder: (context, state) {
        return BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            BasicUser? currentUser;
            if (authState is Authenticated) {
              currentUser = authState.user;
              return PopupMenuButton(
                iconSize: 30,
                icon: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(currentUser.profilePicture),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      enabled: false, // DISABLED THIS ITEM
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ProfileCard(user: currentUser!),
                                const SizedBox(height: 15),
                                SizedBox(
                                  width: double.infinity,
                                  child: DropdownSearch<String>(
                                    popupProps: const PopupProps.menu(
                                        menuProps: MenuProps(
                                            constraints: BoxConstraints(
                                                maxHeight: 145))),
                                    selectedItem: state == ThemeModeState.dark
                                        ? "Dark"
                                        : ThemeModeState.light == state
                                            ? "Light"
                                            : "System",
                                    // mode: Mode.MENU,
                                    // maxHeight: 145,
                                    items: const [
                                      "System",
                                      "Dark",
                                      "Light",
                                    ],
                                    onChanged: (String? value) {
                                      switch (value!) {
                                        case "System":
                                          BlocProvider.of<ThemeModeCubit>(
                                                  context)
                                              .systemMode();
                                          break;
                                        case "Light":
                                          BlocProvider.of<ThemeModeCubit>(
                                                  context)
                                              .lightMode();
                                          break;
                                        case "Dark":
                                          BlocProvider.of<ThemeModeCubit>(
                                                  context)
                                              .darkMode();
                                          break;
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(height: 15),
                                const LogoutButton(),
                                const SizedBox(height: 10),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ];
                },
              );
            } else {
              return Container();
            }
          },
        );
      },
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: ButtonStyle(
          minimumSize:
              MaterialStateProperty.all(const Size(double.infinity, 45)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
      onPressed: () async {
        final authBloc = BlocProvider.of<AuthBloc>(context);
        authBloc.add(UserLoggedOut());
      },
      icon: const Icon(
        Icons.login,
        size: 18,
      ),
      label: const Text("Logout"),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  final BasicUser user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.goNamed(viewProfileRouteName);
      },
      child: SizedBox(
        width: double.infinity,
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 10),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(user.profilePicture),
                    fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              height: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 5),
                  Text(
                    "${user.firstName} ${user.lastName}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    user.email,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 30),
          ],
        ),
      ),
    );
  }
}
