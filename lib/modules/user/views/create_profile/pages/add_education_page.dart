import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../_shared/domain/entities/range_date.dart';
import '../../../../../_shared/interface/widgets/show_top_flash.dart';
import '../../../domain/entities/detail_user.dart';
import '../../../router.dart';
import '../../view_profile/bloc/detail_user_bloc.dart';
import '../bloc/update_profile_bloc.dart';
import '../widgets/widgets.dart';

const _pageTitle =
    "Clients like to know what you know - add your education here.";
const _pageSubtitle =
    "You don’t have to have a degree. Adding any relevant education helps make your profile more visible.";

class AddEducationPage extends StatelessWidget {
  const AddEducationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveWrapper.of(context).isMobile;
    BlocProvider.of<DetailUserBloc>(context).add(GetDetailUserEvent());
    List<Education> educationList = [];
    return BlocConsumer<DetailUserBloc, DetailUserState>(
      listener: (context, state) {
        if (state is DetailUserLoading) {
          context.loaderOverlay.show();
        }
        if (state is DetailUserLoaded) {
          educationList = state.user.educations;
          context.loaderOverlay.hide();
        }
      },
      builder: (context, state) {
        return Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              if (isMobile) const LinearProgressIndicator(value: 0.375),
              _BuildBody(educationList: educationList),
              if (!isMobile) const LinearProgressIndicator(value: 0.375),
              CreateProfileFooter(
                nextRouteTitle: "Next, Languages",
                onPressed: () {
                  context.pushNamed(createProfileLanguageRouteName);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BuildBody extends StatelessWidget {
  const _BuildBody({
    Key? key,
    required this.educationList,
  }) : super(key: key);

  final List<Education> educationList;

  @override
  Widget build(BuildContext context) {
    var isLargerThanMobile = ResponsiveWrapper.of(context).isLargerThan(MOBILE);

    void saveEducationFn(Education education) {
      BlocProvider.of<UpdateProfileBloc>(context)
          .add(SaveEducationEvent(education));
    }

    void removeEducationFn(Education education) {
      BlocProvider.of<UpdateProfileBloc>(context)
          .add(RemoveEducationEvent(education.id!));
    }

    return BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
      listener: (context, state) {
        if (state is UpdateProfileLoading) {
          context.loaderOverlay.show();
        }
        if (state is ErrorUpdatingProfile) {
          context.loaderOverlay.hide();
          showTopSnackBar(
            title: const Text('Error'),
            content: Text(state.message),
            icon: const Icon(Icons.error),
            context: context,
          );
        }
        if (state is UpdateProfileSuccess) {
          if (state.data != null) {
            if (state.data is Education) {
              int educationIndex = -1;
              for (int i = 0; i < educationList.length; i++) {
                if (educationList[i].id == state.data.id) {
                  educationIndex = i;
                  break;
                }
              }
              if (educationIndex != -1) {
                educationList[educationIndex] = state.data;
              } else {
                print("state: $state");
                educationList.add(state.data);
              }
            } else {
              educationList.removeWhere((element) => element.id == state.data);
            }
          }
          context.loaderOverlay.hide();
        }
      },
      builder: (context, state) {
        return Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CreateProfileBodyTitleSubtitle(
                  title: _pageTitle,
                  subtitle: _pageSubtitle,
                ),
                SingleChildScrollView(
                  scrollDirection:
                      isLargerThanMobile ? Axis.horizontal : Axis.vertical,
                  child: Padding(
                    padding: isLargerThanMobile
                        ? const EdgeInsets.fromLTRB(380, 30, 0, 30)
                        : const EdgeInsets.all(0),
                    child: ResponsiveRowColumn(
                      columnSpacing: 10,
                      layout: isLargerThanMobile
                          ? ResponsiveRowColumnType.ROW
                          : ResponsiveRowColumnType.COLUMN,
                      children: [
                        if (isLargerThanMobile)
                          ResponsiveRowColumnItem(
                            child: PlusButton(
                              saveEducationFn: saveEducationFn,
                            ),
                          ),
                        for (Education education in educationList)
                          ResponsiveRowColumnItem(
                            child: EducationTile(
                              education: education,
                              removeEducationFn: removeEducationFn,
                              saveEducationFn: saveEducationFn,
                            ),
                          ),
                        isLargerThanMobile
                            ? const ResponsiveRowColumnItem(
                                child: SizedBox(width: 380),
                              )
                            : ResponsiveRowColumnItem(
                                child: AddEducationButton(
                                  saveEducationFn: saveEducationFn,
                                ),
                              )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PlusButton extends StatelessWidget {
  const PlusButton({
    Key? key,
    required this.saveEducationFn,
  }) : super(key: key);

  final void Function(Education education) saveEducationFn;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.only(right: 30.0),
      child: CircularIconButton(
        onPressed: () {
          _showEducationDialog(context, saveEducationFn);
        },
        icon: Icons.add,
        padding: 25,
      ),
    );
  }
}

class AddEducationButton extends StatelessWidget {
  const AddEducationButton({
    Key? key,
    required this.saveEducationFn,
  }) : super(key: key);

  final void Function(Education education) saveEducationFn;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: OutlinedButton.icon(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size.fromHeight(52)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
        onPressed: () {
          _showEducationGeneralDialog(context, saveEducationFn);
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Education'),
      ),
    );
  }
}

void _showEducationGeneralDialog(
    BuildContext context, Function(Education education) saveEducationFn,
    {Education? education, String? title}) {
  showGeneralDialog(
      context: context,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      pageBuilder: (context, anim, anis) {
        return SafeArea(
          child: SizedBox.expand(
            child: Scaffold(
              body: Column(
                children: [
                  CreateProfileHeader(title: title ?? 'Add Education'),
                  const Divider(),
                  EducationForm(
                    education: education,
                    saveEducationFn: saveEducationFn,
                  )
                ],
              ),
            ),
          ),
        );
      });
}

void _showEducationDialog(
    BuildContext context, Function(Education education) saveEducationFn,
    {Education? education, String? title}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
              height: 600,
              width: 750,
              child: Column(
                children: [
                  CreateProfileHeader(title: title ?? 'Add Education'),
                  const Divider(),
                  EducationForm(
                    education: education,
                    saveEducationFn: saveEducationFn,
                  ),
                ],
              )),
        );
      });
}

class EducationForm extends StatefulWidget {
  const EducationForm({
    Key? key,
    required this.saveEducationFn,
    this.education,
  }) : super(key: key);

  final void Function(Education education) saveEducationFn;
  final Education? education;

  @override
  State<EducationForm> createState() => _EducationFormState();
}

class _EducationFormState extends State<EducationForm> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _institutionField;
  TextEditingController? _degreeField;
  TextEditingController? _areaOfStudyField;
  TextEditingController? _startDateField;
  TextEditingController? _endDateField;
  TextEditingController? _descriptionField;

  @override
  void initState() {
    super.initState();
    _institutionField = TextEditingController();
    _degreeField = TextEditingController();
    _areaOfStudyField = TextEditingController();
    _startDateField = TextEditingController();
    _endDateField = TextEditingController();
    _descriptionField = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    bool isLargerThenMobile =
        ResponsiveWrapper.of(context).isLargerThan(MOBILE);
    if (widget.education != null) {
      _institutionField!.text = widget.education!.institution;
      _degreeField!.text = widget.education!.degree;
      _areaOfStudyField!.text = widget.education!.areaOfStudy;
      _startDateField!.text =
          "${widget.education!.dateAttended.start.year}/${widget.education!.dateAttended.start.month}";
      _endDateField!.text =
          "${widget.education!.dateAttended.end.year}/${widget.education!.dateAttended.end.year}";
      _descriptionField!.text = widget.education!.description;
    }
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: isLargerThenMobile
          ? 600 - 70
          : MediaQuery.of(context).size.height - 80,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                children: [
                  CustomTextFormField(
                    label: 'Institution',
                    controller: _institutionField,
                    validator: RequiredValidator(errorText: "required"),
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    label: 'Degree',
                    validator: null,
                    controller: _degreeField,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    validator: RequiredValidator(errorText: "required"),
                    label: 'Area of Study',
                    controller: _areaOfStudyField,
                  ),
                  const SizedBox(height: 20),
                  ResponsiveRowColumn(
                    columnSpacing: 20,
                    rowSpacing: 10,
                    layout: isLargerThenMobile
                        ? ResponsiveRowColumnType.ROW
                        : ResponsiveRowColumnType.COLUMN,
                    children: [
                      ResponsiveRowColumnItem(
                        rowFlex: 1,
                        child: DatePickerTextField(
                          label: 'Start Date',
                          onTab: () => _selectDate(context, 'Start'),
                          controller: _startDateField,
                        ),
                      ),
                      ResponsiveRowColumnItem(
                        rowFlex: 1,
                        // child: endDateTextField(context),
                        child: DatePickerTextField(
                          label: 'End Date',
                          onTab: () => _selectDate(context, 'End'),
                          controller: _endDateField,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  DescriptionField(controller: _descriptionField)
                ],
              ),
            ),
            SizedBox(
                width: isLargerThenMobile ? 95 : double.infinity,
                child: saveButton()),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, String pickerFor) async {
    final DateTime? picked = await showMonthPicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        if (pickerFor == 'Start') {
          startDate = picked;
          _startDateField?.text = "${startDate.year}-${startDate.month}";
        } else {
          endDate = picked;
          _endDateField?.text = "${endDate.year}-${endDate.month}";
        }
      });
    }
  }

  Widget saveButton() {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size.fromHeight(50)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          if (startDate.isAfter(endDate)) {
            showTopSnackBar(
                title: const Text("Invalid Date"),
                content: const Text("Start Date is Greater Than End Date"),
                icon: const Icon(Icons.error),
                context: context);
            return;
          }
          String? id;
          if (widget.education != null) {
            id = widget.education?.id;
          }
          Education education = Education(
            _institutionField!.text,
            RangeDate(startDate, endDate),
            _degreeField!.text,
            _areaOfStudyField!.text,
            _descriptionField!.text,
            id: id,
          );
          widget.saveEducationFn(education);
          Navigator.of(context, rootNavigator: true).pop();
        }
      },
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Save'),
      ),
    );
  }
}

class EducationTile extends StatelessWidget {
  const EducationTile({
    Key? key,
    required this.saveEducationFn,
    required this.removeEducationFn,
    required this.education,
  }) : super(key: key);

  final void Function(Education education) saveEducationFn;
  final void Function(Education education) removeEducationFn;
  final Education education;

  @override
  Widget build(BuildContext context) {
    var isLargerThanMobile = ResponsiveWrapper.of(context).isLargerThan(MOBILE);
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
      child: Card(
        elevation: 1,
        child: SizedBox(
          width: isLargerThanMobile ? 390 : double.infinity,
          height: isLargerThanMobile ? 280 : 120,
          child: Row(
            children: [
              Container(
                width: isLargerThanMobile ? 72 : 40,
                padding: const EdgeInsets.only(top: 5),
                alignment: Alignment.topCenter,
                child: FaIcon(
                  FontAwesomeIcons.buildingColumns,
                  size: isLargerThanMobile ? 48 : 30,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 5, left: 5),
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        education.institution,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextWithOpacity(
                          opacity: 0.9, text: education.areaOfStudy),
                      TextWithOpacity(
                          opacity: 0.6,
                          text:
                              "${education.dateAttended.start.year}/${education.dateAttended.start.month} - ${education.dateAttended.end.year}/${education.dateAttended.end.month}"),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
              Container(
                width: 50,
                padding: const EdgeInsets.only(top: 5, right: 5),
                alignment: Alignment.topRight,
                child: Column(
                  children: [
                    CircularIconButton(
                      onPressed: () {
                        isLargerThanMobile
                            ? _showEducationDialog(
                                context,
                                saveEducationFn,
                                education: education,
                                title: 'Edit Education',
                              )
                            : _showEducationGeneralDialog(
                                context,
                                saveEducationFn,
                                education: education,
                                title: 'Edit Education',
                              );
                      },
                      icon: Icons.edit,
                      padding: 11,
                    ),
                    const SizedBox(height: 15),
                    CircularIconButton(
                      onPressed: () {
                        removeEducationFn(education);
                      },
                      icon: Icons.delete,
                      padding: 11,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
