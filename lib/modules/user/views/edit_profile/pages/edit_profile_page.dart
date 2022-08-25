import 'package:CloudWork_Freelancer/modules/user/views/edit_profile/widgets/experience_form.dart';
import 'package:CloudWork_Freelancer/modules/user/views/edit_profile/widgets/other_experience_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../_core/di/get_It.dart';
import '../../../../../_shared/interface/widgets/show_top_flash.dart';
import '../../../domain/entities/detail_user.dart';
import '../../create_profile/bloc/update_profile_bloc.dart';
import '../../view_profile/bloc/detail_user_bloc.dart';
import '../widgets/edit_language_form.dart';
import '../widgets/widgets.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: buildBody());
  }

  MultiBlocProvider buildBody() {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => container<DetailUserBloc>()),
        BlocProvider(create: (context) => container<UpdateProfileBloc>()),
      ],
      child: Column(
        children: [
          BlocBuilder<DetailUserBloc, DetailUserState>(
            builder: (context, state) {
              if (state is DetailUserInitial) {
                BlocProvider.of<DetailUserBloc>(context)
                    .add(GetDetailUserEvent());
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: const Center(child: CircularProgressIndicator()),
                );
              } else if (state is DetailUserLoading) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: const Center(child: CircularProgressIndicator()),
                );
              } else if (state is DetailUserLoaded) {
                return EditProfileDisplay(user: state.user);
              } else if (state is ErrorLoadingDetailUser) {
                return const EditProfileErrorDisplay();
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}

void _showDialog(BuildContext context, Widget body, String title) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => container<UpdateProfileBloc>(),
          child: Dialog(
            child: SizedBox(
              height: 600,
              width: 750,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  title: Text(
                    title,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  leading: IconButton(
                    color: Theme.of(context).colorScheme.onBackground,
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),
                body: body,
              ),
            ),
          ),
        );
      });
}

void _showGeneralDialog(BuildContext context, Widget body, String title) {
  showGeneralDialog(
    context: context,
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
    pageBuilder: (context, anim, anis) {
      return SafeArea(
        child: SizedBox.expand(
          child: BlocProvider(
            create: (context) => container<UpdateProfileBloc>(),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.background,
                title: Text(
                  title,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                leading: IconButton(
                  color: Theme.of(context).colorScheme.onBackground,
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
              body: body,
            ),
          ),
        ),
      );
    },
  );
}

class EditProfileDisplay extends StatelessWidget {
  const EditProfileDisplay({
    Key? key,
    required this.user,
  }) : super(key: key);

  final DetailUser user;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateProfileBloc, UpdateProfileState>(
      listener: (context, state) {
        if (state is ErrorUpdatingProfile) {
          showTopSnackBar(
            title: const Text('Error'),
            content: Text(state.message),
            icon: const Icon(Icons.error),
            context: context,
          );
        } else if (state is UpdateProfileSuccess) {
          BlocProvider.of<DetailUserBloc>(context).add(GetDetailUserEvent());
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  children: [
                    FirstCardTile(user: user),
                    const Divider(),
                    ExpertiseCardTile(user: user),
                    const Divider(),
                    SkillCardTile(user: user),
                    const Divider(),
                    LanguageCardTile(user: user),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: EducationTile(user: user),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: EmploymentTile(user: user),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OtherExperiencesTile(user: user),
            ),
          ],
        ),
      ),
    );
  }
}

class OtherExperiencesTile extends StatelessWidget {
  const OtherExperiencesTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  final DetailUser user;

  @override
  Widget build(BuildContext context) {
    void onSave() =>
        BlocProvider.of<DetailUserBloc>(context).add(GetDetailUserEvent());

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 80,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      "Other Experiences",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RawMaterialButton(
                    constraints:
                        const BoxConstraints(maxHeight: 36, maxWidth: 36),
                    onPressed: () {
                      ResponsiveWrapper.of(context).isMobile
                          ? _showGeneralDialog(
                              context,
                              OtherExperienceForm(
                                onSave: onSave,
                              ),
                              "Add Other Experience",
                            )
                          : _showDialog(
                              context,
                              OtherExperienceForm(
                                onSave: onSave,
                              ),
                              "Add Other Experience",
                            );
                    },
                    elevation: 2.0,
                    fillColor: Theme.of(context).colorScheme.background,
                    child: const Icon(Icons.add, size: 26),
                    padding: const EdgeInsets.all(5.0),
                    shape: const CircleBorder(),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              height: 350,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: user.otherExperiences.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    child: SizedBox(
                      width: 300,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.otherExperiences[index].subject,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const SizedBox(height: 10),
                                  Flexible(
                                    child: SizedBox(
                                      child: Text(
                                        user.otherExperiences[index]
                                            .description,
                                        softWrap: true,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                RawMaterialButton(
                                  constraints: const BoxConstraints(
                                      maxHeight: 36, maxWidth: 36),
                                  onPressed: () {
                                    ResponsiveWrapper.of(context).isMobile
                                        ? _showGeneralDialog(
                                            context,
                                            OtherExperienceForm(
                                              onSave: onSave,
                                              otherExperience:
                                                  user.otherExperiences[index],
                                            ),
                                            "Edit Other Experience",
                                          )
                                        : _showDialog(
                                            context,
                                            OtherExperienceForm(
                                              onSave: onSave,
                                              otherExperience:
                                                  user.otherExperiences[index],
                                            ),
                                            "Edit Other Experience",
                                          );
                                  },
                                  elevation: 2.0,
                                  fillColor:
                                      Theme.of(context).colorScheme.background,
                                  child: const Icon(Icons.edit, size: 26),
                                  padding: const EdgeInsets.all(5.0),
                                  shape: const CircleBorder(),
                                ),
                                const SizedBox(width: 5),
                                RawMaterialButton(
                                  constraints: const BoxConstraints(
                                      maxHeight: 36, maxWidth: 36),
                                  onPressed: () {
                                    BlocProvider.of<UpdateProfileBloc>(context)
                                        .add(RemoveOtherExperienceEvent(
                                            user.otherExperiences[index].id!));
                                  },
                                  elevation: 2.0,
                                  fillColor:
                                      Theme.of(context).colorScheme.background,
                                  child: const Icon(Icons.delete, size: 26),
                                  padding: const EdgeInsets.all(5.0),
                                  shape: const CircleBorder(),
                                ),
                              ],
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
      ),
    );
  }
}

class EmploymentTile extends StatelessWidget {
  const EmploymentTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  final DetailUser user;

  @override
  Widget build(BuildContext context) {
    void onSave() =>
        BlocProvider.of<DetailUserBloc>(context).add(GetDetailUserEvent());

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 80,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      "Employments",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RawMaterialButton(
                    constraints:
                        const BoxConstraints(maxHeight: 36, maxWidth: 36),
                    onPressed: () {
                      ResponsiveWrapper.of(context).isMobile
                          ? _showGeneralDialog(
                              context,
                              ExperienceForm(
                                onSave: onSave,
                              ),
                              "Add Employment",
                            )
                          : _showDialog(
                              context,
                              ExperienceForm(
                                onSave: onSave,
                              ),
                              "Add Employment",
                            );
                    },
                    elevation: 2.0,
                    fillColor: Theme.of(context).colorScheme.background,
                    child: const Icon(Icons.add, size: 26),
                    padding: const EdgeInsets.all(5.0),
                    shape: const CircleBorder(),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              height: 350,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: user.employments.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    child: SizedBox(
                      width: 300,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.employments[index].title,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    user.employments[index].company,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "${DateFormat.yMMMM().format(user.employments[index].period.start)} - "
                                    "${DateFormat.yMMMM().format(user.employments[index].period.end)}",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  const SizedBox(height: 5),
                                  Flexible(
                                    child: SizedBox(
                                      child: Text(
                                        user.employments[index].summary,
                                        softWrap: true,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                RawMaterialButton(
                                  constraints: const BoxConstraints(
                                      maxHeight: 36, maxWidth: 36),
                                  onPressed: () {
                                    ResponsiveWrapper.of(context).isMobile
                                        ? _showGeneralDialog(
                                            context,
                                            ExperienceForm(
                                              employment:
                                                  user.employments[index],
                                              onSave: onSave,
                                            ),
                                            "Edit Employment",
                                          )
                                        : _showDialog(
                                            context,
                                            ExperienceForm(
                                              employment:
                                                  user.employments[index],
                                              onSave: onSave,
                                            ),
                                            "Edit Employment",
                                          );
                                  },
                                  elevation: 2.0,
                                  fillColor:
                                      Theme.of(context).colorScheme.background,
                                  child: const Icon(Icons.edit, size: 26),
                                  padding: const EdgeInsets.all(5.0),
                                  shape: const CircleBorder(),
                                ),
                                const SizedBox(width: 5),
                                RawMaterialButton(
                                  constraints: const BoxConstraints(
                                      maxHeight: 36, maxWidth: 36),
                                  onPressed: () {
                                    BlocProvider.of<UpdateProfileBloc>(context)
                                        .add(RemoveExperienceEvent(
                                            user.employments[index].id!));
                                  },
                                  elevation: 2.0,
                                  fillColor:
                                      Theme.of(context).colorScheme.background,
                                  child: const Icon(Icons.delete, size: 26),
                                  padding: const EdgeInsets.all(5.0),
                                  shape: const CircleBorder(),
                                ),
                              ],
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
      ),
    );
  }
}

class EducationTile extends StatelessWidget {
  const EducationTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  final DetailUser user;

  @override
  Widget build(BuildContext context) {
    void onSave() =>
        BlocProvider.of<DetailUserBloc>(context).add(GetDetailUserEvent());

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 80,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      "Educations",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RawMaterialButton(
                    constraints:
                        const BoxConstraints(maxHeight: 36, maxWidth: 36),
                    onPressed: () {
                      ResponsiveWrapper.of(context).isMobile
                          ? _showGeneralDialog(
                              context,
                              EducationForm(
                                // languages: user.languages,
                                onSave: onSave,
                              ),
                              "Add Education",
                            )
                          : _showDialog(
                              context,
                              EducationForm(
                                // languages: user.languages,
                                onSave: onSave,
                              ),
                              "Add Education",
                            );
                    },
                    elevation: 2.0,
                    fillColor: Theme.of(context).colorScheme.background,
                    child: const Icon(Icons.add, size: 26),
                    padding: const EdgeInsets.all(5.0),
                    shape: const CircleBorder(),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              height: 350,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: user.educations.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    child: SizedBox(
                      width: 300,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.educations[index].areaOfStudy,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    user.educations[index].institution,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "${DateFormat.yMMMM().format(user.educations[index].dateAttended.start)} - "
                                    "${DateFormat.yMMMM().format(user.educations[index].dateAttended.end)}",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  const SizedBox(height: 5),
                                  Flexible(
                                    child: SizedBox(
                                      child: Text(
                                        user.educations[index].description,
                                        overflow: TextOverflow.fade,
                                        softWrap: true,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                RawMaterialButton(
                                  constraints: const BoxConstraints(
                                      maxHeight: 36, maxWidth: 36),
                                  onPressed: () {
                                    ResponsiveWrapper.of(context).isMobile
                                        ? _showGeneralDialog(
                                            context,
                                            EducationForm(
                                              education: user.educations[index],
                                              onSave: onSave,
                                            ),
                                            "Edit Education",
                                          )
                                        : _showDialog(
                                            context,
                                            EducationForm(
                                              education: user.educations[index],
                                              onSave: onSave,
                                            ),
                                            "Edit Education",
                                          );
                                  },
                                  elevation: 2.0,
                                  fillColor:
                                      Theme.of(context).colorScheme.background,
                                  child: const Icon(Icons.edit, size: 26),
                                  padding: const EdgeInsets.all(5.0),
                                  shape: const CircleBorder(),
                                ),
                                const SizedBox(width: 5),
                                RawMaterialButton(
                                  constraints: const BoxConstraints(
                                      maxHeight: 36, maxWidth: 36),
                                  onPressed: () {
                                    BlocProvider.of<UpdateProfileBloc>(context)
                                        .add(RemoveEducationEvent(
                                            user.educations[index].id!));
                                  },
                                  elevation: 2.0,
                                  fillColor:
                                      Theme.of(context).colorScheme.background,
                                  child: const Icon(Icons.delete, size: 26),
                                  padding: const EdgeInsets.all(5.0),
                                  shape: const CircleBorder(),
                                ),
                              ],
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
      ),
    );
  }
}

class LanguageCardTile extends StatelessWidget {
  const LanguageCardTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  final DetailUser user;

  @override
  Widget build(BuildContext context) {
    void onSave() =>
        BlocProvider.of<DetailUserBloc>(context).add(GetDetailUserEvent());

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Languages",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.7)),
              ),
              RawMaterialButton(
                constraints: const BoxConstraints(maxHeight: 30, maxWidth: 30),
                onPressed: () {
                  ResponsiveWrapper.of(context).isMobile
                      ? _showGeneralDialog(
                          context,
                          EditLanguageForm(
                            languages: user.languages,
                            onSave: onSave,
                          ),
                          "Edit Languages",
                        )
                      : _showDialog(
                          context,
                          EditLanguageForm(
                            languages: user.languages,
                            onSave: onSave,
                          ),
                          "Edit Languages",
                        );
                },
                elevation: 1.0,
                fillColor: Theme.of(context).colorScheme.background,
                child: const Icon(Icons.edit, size: 20),
                padding: const EdgeInsets.all(5.0),
                shape: const CircleBorder(),
              ),
            ],
          ),
          for (int i = 0; i < user.languages.length; i++)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Text("${user.languages[i].language}" ":",
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(width: 5),
                  Text(user.languages[i].proficiencyLevel,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.6)))
                ],
              ),
            )
        ],
      ),
    );
  }
}

class SkillCardTile extends StatelessWidget {
  const SkillCardTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  final DetailUser user;

  @override
  Widget build(BuildContext context) {
    void onSave() {
      BlocProvider.of<DetailUserBloc>(context).add(GetDetailUserEvent());
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Skills",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.7)),
              ),
              RawMaterialButton(
                constraints: const BoxConstraints(maxHeight: 30, maxWidth: 30),
                onPressed: () {
                  ResponsiveWrapper.of(context).isMobile
                      ? _showGeneralDialog(
                          context,
                          EditSkillsForm(
                            skills: user.skills,
                            onSave: onSave,
                          ),
                          "Edit Expertise",
                        )
                      : _showDialog(
                          context,
                          EditSkillsForm(
                            skills: user.skills,
                            onSave: onSave,
                          ),
                          "Edit Expertise",
                        );
                },
                elevation: 1.0,
                fillColor: Theme.of(context).colorScheme.background,
                child: const Icon(Icons.edit, size: 20),
                padding: const EdgeInsets.all(5.0),
                shape: const CircleBorder(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 10,
            children: [
              for (int i = 0; i < user.skills.length; i++)
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.2),
                        style: BorderStyle.none,
                        width: 0.4,
                      ),
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.06)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                    child: Text(user.skills[i],
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(0.7))),
                  ),
                )
            ],
          )
        ],
      ),
    );
  }
}

class ExpertiseCardTile extends StatelessWidget {
  const ExpertiseCardTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  final DetailUser user;

  @override
  Widget build(BuildContext context) {
    void onSave() {
      BlocProvider.of<DetailUserBloc>(context).add(GetDetailUserEvent());
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: SizedBox(
                  child: Text(
                    user.expertise,
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.7)),
                  ),
                ),
              ),
              RawMaterialButton(
                constraints: const BoxConstraints(maxHeight: 30, maxWidth: 30),
                onPressed: () {
                  ResponsiveWrapper.of(context).isMobile
                      ? _showGeneralDialog(
                          context,
                          EditExpertiseForm(
                            expertise: user.expertise,
                            onSave: onSave,
                          ),
                          "Edit Expertise",
                        )
                      : _showDialog(
                          context,
                          EditExpertiseForm(
                            expertise: user.expertise,
                            onSave: onSave,
                          ),
                          "Edit Expertise",
                        );
                },
                elevation: 1.0,
                fillColor: Theme.of(context).colorScheme.background,
                child: const Icon(Icons.edit, size: 20),
                padding: const EdgeInsets.all(5.0),
                shape: const CircleBorder(),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  child: Text(
                    user.overview,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              RawMaterialButton(
                constraints: const BoxConstraints(maxHeight: 30, maxWidth: 30),
                onPressed: () {
                  ResponsiveWrapper.of(context).isMobile
                      ? _showGeneralDialog(
                          context,
                          EditOverviewForm(
                            overview: user.overview,
                            onSave: onSave,
                          ),
                          "Edit Overview",
                        )
                      : _showDialog(
                          context,
                          EditOverviewForm(
                            overview: user.overview,
                            onSave: onSave,
                          ),
                          "Edit Overview",
                        );
                },
                elevation: 1.0,
                fillColor: Theme.of(context).colorScheme.background,
                child: const Icon(Icons.edit, size: 20),
                padding: const EdgeInsets.all(5.0),
                shape: const CircleBorder(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FirstCardTile extends StatelessWidget {
  const FirstCardTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  final DetailUser user;

  @override
  Widget build(BuildContext context) {
    void onSave() {
      BlocProvider.of<DetailUserBloc>(context).add(GetDetailUserEvent());
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ResponsiveRowColumn(
        rowSpacing: 20,
        columnSpacing: 15,
        layout: ResponsiveWrapper.of(context).isSmallerThan(TABLET)
            ? ResponsiveRowColumnType.COLUMN
            : ResponsiveRowColumnType.ROW,
        children: [
          ResponsiveRowColumnItem(
              child: SizedBox(
            height: 120,
            width: 120,
            child: Stack(
              clipBehavior: Clip.none,
              fit: StackFit.expand,
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  backgroundImage: NetworkImage(user.profilePicture),
                ),
                Positioned(
                  bottom: 0,
                  right: -25,
                  child: RawMaterialButton(
                    onPressed: () {
                      ResponsiveWrapper.of(context).isMobile
                          ? _showGeneralDialog(
                              context,
                              UploadProfileBody(
                                imageUrl: user.profilePicture,
                                fileUploadSuccess: onSave,
                              ),
                              "Change Profile",
                            )
                          : _showDialog(
                              context,
                              UploadProfileBody(
                                imageUrl: user.profilePicture,
                                fileUploadSuccess: onSave,
                              ),
                              "Change Profile",
                            );
                    },
                    elevation: 1.0,
                    fillColor: Theme.of(context).colorScheme.background,
                    child: const Icon(Icons.edit),
                    padding: const EdgeInsets.all(10.0),
                    shape: const CircleBorder(),
                  ),
                ),
              ],
            ),
          )),
          ResponsiveRowColumnItem(
            child: Column(
              crossAxisAlignment:
                  ResponsiveWrapper.of(context).isSmallerThan(TABLET)
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
              children: [
                Text(
                  "${user.firstName} ${user.lastName}",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.7)),
                ),
                Text(
                    "${user.address!.city}, ${user.address!.region}, Ethiopia"),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.3),
                          style: BorderStyle.solid,
                          width: 0.6,
                        ),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 3.0, 10.0, 3.0),
                        child: Text(
                          user.available,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ),
                    RawMaterialButton(
                      constraints:
                          const BoxConstraints(maxHeight: 30, maxWidth: 30),
                      onPressed: () {
                        ResponsiveWrapper.of(context).isMobile
                            ? _showGeneralDialog(
                                context,
                                EditAvailabilityForm(
                                  available: user.available,
                                  onSave: onSave,
                                ),
                                "Edit Availability",
                              )
                            : _showDialog(
                                context,
                                EditAvailabilityForm(
                                  available: user.available,
                                  onSave: onSave,
                                ),
                                "Edit Availability",
                              );
                      },
                      elevation: 1.0,
                      fillColor: Theme.of(context).colorScheme.background,
                      child: const Icon(Icons.edit, size: 20),
                      padding: const EdgeInsets.all(5.0),
                      shape: const CircleBorder(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
