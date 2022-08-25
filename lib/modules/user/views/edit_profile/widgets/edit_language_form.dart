import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../domain/entities/detail_user.dart';
import '../../create_profile/bloc/update_profile_bloc.dart';
import 'widgets.dart';

class EditLanguageForm extends StatefulWidget {
  const EditLanguageForm({
    Key? key,
    required this.languages,
    required this.onSave,
  }) : super(key: key);

  final List<Language> languages;
  final void Function() onSave;

  @override
  State<EditLanguageForm> createState() => _EditLanguageFormState();
}

class _EditLanguageFormState extends State<EditLanguageForm> {
  final _formKey = GlobalKey<FormState>();

  void addLanguageFn() {
    Language newLanguage = const Language("", "");
    setState(() {
      widget.languages.add(newLanguage);
    });
  }

  void removeLanguageFn(int index) {
    setState(() {
      widget.languages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isLargerThanMobile =
        ResponsiveWrapper.of(context).isLargerThan(MOBILE);
    return BlocListener<UpdateProfileBloc, UpdateProfileState>(
      listener: (context, state) {
        if (state is UpdateProfileSuccess) {
          Navigator.of(context, rootNavigator: true).pop();
          widget.onSave();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: isLargerThanMobile
                    ? 600 - 130
                    : MediaQuery.of(context).size.height - 130,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              // height: 50,
                              padding: const EdgeInsets.all(15),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Language",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              alignment: Alignment.centerLeft,
                              // height: 50,
                              child: Text(
                                "Proficiency",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          )
                        ],
                      ),
                      const Divider(),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.languages.length,
                        itemBuilder: (context, index) {
                          return LanguageTile(
                            index: index,
                            languageList: widget.languages,
                            removeLanguageFn: removeLanguageFn,
                          );
                        },
                      ),
                      const Divider(),
                      TextButton.icon(
                        onPressed: () {
                          addLanguageFn();
                        },
                        label: const Text("Add a language"),
                        icon: const Icon(Icons.add),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              DialogBottomActions(onSave: () {
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<UpdateProfileBloc>(context)
                      .add(SaveLanguagesEvent(widget.languages));
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageTile extends StatelessWidget {
  const LanguageTile({
    Key? key,
    required this.index,
    required this.languageList,
    required this.removeLanguageFn,
  }) : super(key: key);

  final int index;
  final List<Language> languageList;
  final void Function(int index) removeLanguageFn;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: DropdownSearch<String>(
              dropdownSearchDecoration: const InputDecoration(
                isDense: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
              ),
              popupProps: const PopupProps.menu(
                  menuProps: MenuProps(
                      constraints: BoxConstraints(
                maxHeight: 200,
              ))),
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
              dropdownSearchDecoration: const InputDecoration(
                isDense: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
              ),
              popupProps: const PopupProps.menu(
                  menuProps: MenuProps(
                      constraints: BoxConstraints(
                maxHeight: 200,
              ))),
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
              child: RawMaterialButton(
                constraints: const BoxConstraints(maxHeight: 30, maxWidth: 30),
                onPressed: () {
                  removeLanguageFn(index);
                },
                elevation: 1.0,
                fillColor: Theme.of(context).colorScheme.background,
                child: const Icon(Icons.delete, size: 20),
                padding: const EdgeInsets.all(5.0),
                shape: const CircleBorder(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

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
