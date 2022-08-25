import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../_shared/interface/widgets/show_top_flash.dart';
import '../../../domain/entities/detail_user.dart';
import '../../../router.dart';
import '../../view_profile/bloc/detail_user_bloc.dart';
import '../bloc/update_profile_bloc.dart';
import '../widgets/widgets.dart';

const _title = 'Looking good. Next, tell us which languages you speak.';
const _subtitle =
    "CloudWork is global, so clients are often interested to know what languages you speak. English is a must, but do you speak any other languages? ";
const _ethiopianLanguages = [
  "English",
  "Amharic",
  "Afan Oromo",
  'Somali',
  'Sidamo',
  'Wolaytta',
  'Gurage',
  'Afar',
  'Tigrinya',
  'Hadiyya',
  'Gamo',
  'Gedeo',
  'Kafa',
  'Other language'
];
const _languageProficiencyLevel = [
  'Basic',
  'Conversational',
  'Fluent',
  'Native'
];

class AddLanguagePage extends StatelessWidget {
  const AddLanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveWrapper.of(context).isMobile;
    BlocProvider.of<DetailUserBloc>(context).add(GetDetailUserEvent());
    List<Language> languageList = [];
    final _formKey = GlobalKey<FormState>();

    return BlocConsumer<DetailUserBloc, DetailUserState>(
      listener: (context, state) {
        if (state is DetailUserLoading) {
          context.loaderOverlay.show();
        }
        if (state is DetailUserLoaded) {
          languageList = state.user.languages;
          context.loaderOverlay.hide();
        }
      },
      builder: (context, state) {
        return Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (isMobile) const LinearProgressIndicator(value: 0.498),
              Form(
                key: _formKey,
                child: _BuildBody(
                  languageList: languageList,
                  // formKey: _formKey,
                ),
              ),
              if (!isMobile) const LinearProgressIndicator(value: 0.498),
              BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
                listener: (context, state) {
                  if (state is UpdateProfileSuccess) {
                    context.pushNamed(createProfileSkillRouteName);
                  }
                  if (state is ErrorUpdatingProfile) {
                    showTopSnackBar(
                        title: const Text('Error'),
                        content: Text(state.message),
                        icon: const Icon(Icons.error),
                        context: context);
                  }
                },
                builder: (context, state) {
                  if (state is UpdateProfileLoading) {
                    return CreateProfileFooter(
                      nextRouteTitle: "",
                      onPressed: () {},
                      buttonContent: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Saving..."),
                          CircularProgressIndicator(),
                        ],
                      ),
                    );
                  }
                  return CreateProfileFooter(
                    nextRouteTitle: "Now Share Your Skills",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<UpdateProfileBloc>(context)
                            .add(SaveLanguagesEvent(languageList));
                      }
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BuildBody extends StatefulWidget {
  const _BuildBody({
    Key? key,
    required this.languageList,
  }) : super(key: key);

  final List<Language> languageList;

  @override
  State<_BuildBody> createState() => _BuildBodyState();
}

class _BuildBodyState extends State<_BuildBody> {
  void addLanguageFn() {
    Language newLanguage = const Language("", "");
    setState(() {
      widget.languageList.add(newLanguage);
    });
  }

  void removeLanguageFn(int index) {
    setState(() {
      widget.languageList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isLargerThanMobile =
        ResponsiveWrapper.of(context).isLargerThan(MOBILE);

    return Expanded(
        child: SingleChildScrollView(
      child: Column(
        children: [
          const CreateProfileBodyTitleSubtitle(
            title: _title,
            subtitle: _subtitle,
          ),
          SizedBox(
            width: isLargerThanMobile ? 900 : double.infinity,
            child: Padding(
              padding: isLargerThanMobile
                  ? const EdgeInsets.fromLTRB(60, 10, 60, 30)
                  : const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.all(15),
                          alignment: Alignment.centerLeft,
                          child: const Text("Language"),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          alignment: Alignment.centerLeft,
                          height: 50,
                          child: const Text("Proficiency"),
                        ),
                      )
                    ],
                  ),
                  const Divider(),
                  for (int i = 0; i < widget.languageList.length; i++)
                    LanguageTile(
                      removeLanguageFn: removeLanguageFn,
                      index: i,
                      languageList: widget.languageList,
                    ),
                  const Divider(),
                  TextButton.icon(
                    onPressed: () {
                      addLanguageFn();
                    },
                    label: const Text("Add a language"),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}

class LanguageTile extends StatelessWidget {
  const LanguageTile({
    Key? key,
    required this.index,
    required this.languageList,
    required this.removeLanguageFn,
    // required this.onLanguageChangeFn,
    // required this.onProficiencyChangeFn,
  }) : super(key: key);

  final int index;
  final List<Language> languageList;
  final void Function(int index) removeLanguageFn;
  // final void Function(Language language, String lang) onLanguageChangeFn;
  // final void Function(Language language, String pro) onProficiencyChangeFn;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: DropdownSearch<String>(
              // showSearchBox: true,
              // mode: Mode.MENU,
              items: _ethiopianLanguages,
              selectedItem: languageList[index].language,
              onChanged: (String? value) {
                languageList[index] =
                    Language(value!, languageList[index].proficiencyLevel);
              },
              validator: RequiredValidator(errorText: 'required field'),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            flex: 3,
            child: DropdownSearch<String>(
              // mode: Mode.MENU,
              popupProps: PopupProps.menu(
                  menuProps:
                      MenuProps(constraints: BoxConstraints(maxHeight: 210))),
              items: _languageProficiencyLevel,
              onChanged: (String? value) {
                languageList[index] =
                    Language(languageList[index].language, value!);
              },
              selectedItem: languageList[index].proficiencyLevel,
              validator: RequiredValidator(errorText: 'required field'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: SizedBox(
              height: 40,
              child: CircularIconButton(
                icon: Icons.delete,
                onPressed: () {
                  removeLanguageFn(index);
                },
                padding: 1,
              ),
            ),
          )
        ],
      ),
    );
  }
}
