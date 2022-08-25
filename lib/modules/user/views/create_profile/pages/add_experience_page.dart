import 'package:CloudWork_Freelancer/_shared/interface/widgets/show_top_flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../_shared/domain/entities/range_date.dart';
import '../../../../../_shared/interface/widgets/loading_overlay.dart';
import '../../../domain/entities/detail_user.dart';
import '../../../router.dart';
import '../../view_profile/bloc/detail_user_bloc.dart';
import '../bloc/update_profile_bloc.dart';
import '../widgets/widgets.dart';

const _pageTitle = "If you have relevant work experience, add it here.";
const _pageSubtitle =
    "Freelancers who add their experience are twice as likely to win work. But if you’re just starting out, you can still create a great profile. Just head on to the next page.";

class AddExperiencePage extends StatelessWidget {
  const AddExperiencePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveWrapper.of(context).isMobile;
    BlocProvider.of<DetailUserBloc>(context).add(GetDetailUserEvent());
    List<Employment> _employmentList = [];

    return BlocConsumer<DetailUserBloc, DetailUserState>(
      listener: (context, state) {
        if (state is DetailUserLoading) {
          context.loaderOverlay.show();
        }
        if (state is DetailUserLoaded) {
          _employmentList = state.user.employments;
          context.loaderOverlay.hide();
        }
      },
      builder: (context, state) {
        return Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              if (isMobile) const LinearProgressIndicator(value: 0.25),
              _BuildBody(
                employmentList: _employmentList,
              ),
              if (!isMobile) const LinearProgressIndicator(value: 0.25),
              CreateProfileFooter(
                nextRouteTitle: "Next, Add Your Education",
                onPressed: () {
                  context.pushNamed(createProfileEducationRouteName);
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
    required this.employmentList,
  }) : super(key: key);

  final List<Employment> employmentList;

  @override
  State<_BuildBody> createState() => _BuildBodyState();
}

class _BuildBodyState extends State<_BuildBody> {
  final LoadingOverlay _loadingOverlay = LoadingOverlay();

  void saveExperienceFn(Employment employment) {
    final updateProfileBloc = BlocProvider.of<UpdateProfileBloc>(context);
    updateProfileBloc.add(AddExperienceEvent(employment));
    Navigator.of(context, rootNavigator: true).pop();
  }

  void removeExperienceFn(Employment employment) {
    widget.employmentList.removeWhere((element) => element == employment);
    final updateProfileBloc = BlocProvider.of<UpdateProfileBloc>(context);
    updateProfileBloc.add(RemoveExperienceEvent(employment.id!));
  }

  @override
  Widget build(BuildContext context) {
    var isLargerThanMobile = ResponsiveWrapper.of(context).isLargerThan(MOBILE);
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
            int employmentIndex = -1;
            for (int i = 0; i < widget.employmentList.length; i++) {
              if (widget.employmentList[i].id == state.data.id) {
                employmentIndex = i;
              }
            }
            if (employmentIndex != -1) {
              widget.employmentList[employmentIndex] = state.data;
            } else {
              print("state: $state");
              widget.employmentList.add(state.data);
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
                            child: _PlusButton(
                              saveExperienceFn: saveExperienceFn,
                            ),
                          ),
                        for (Employment employment in widget.employmentList)
                          ResponsiveRowColumnItem(
                              child: ExperienceTile(
                            employment: employment,
                            removeExperienceFn: removeExperienceFn,
                            saveExperienceFn: saveExperienceFn,
                          )),
                        isLargerThanMobile
                            ? const ResponsiveRowColumnItem(
                                child: SizedBox(width: 380),
                              )
                            : ResponsiveRowColumnItem(
                                child: AddExperienceButton(
                                  saveExperienceFn: saveExperienceFn,
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

void _showExperienceFormDialog(
    BuildContext context, Function(Employment employment) saveExperienceFn,
    {Employment? employment}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
              height: 600,
              width: 750,
              child: Column(
                children: [
                  const CreateProfileHeader(title: 'Add Work Experience'),
                  const Divider(),
                  ExperienceForm(
                    saveExperienceFn: saveExperienceFn,
                    employment: employment,
                  ),
                ],
              )),
        );
      });
}

void _showExperienceFormGeneralDialog(
    BuildContext context, Function(Employment employment) saveExperienceFn,
    {Employment? employment}) {
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
                  const CreateProfileHeader(title: 'Add Work Experience'),
                  const Divider(),
                  ExperienceForm(
                    saveExperienceFn: saveExperienceFn,
                    employment: employment,
                  )
                ],
              ),
            ),
          ),
        );
      });
}

class _PlusButton extends StatelessWidget {
  const _PlusButton({
    Key? key,
    required this.saveExperienceFn,
  }) : super(key: key);

  final void Function(Employment employment) saveExperienceFn;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.only(right: 30.0),
      child: CircularIconButton(
        onPressed: () {
          _showExperienceFormDialog(context, saveExperienceFn);
        },
        icon: Icons.add,
        padding: 25,
      ),
    );
  }
}

class AddExperienceButton extends StatelessWidget {
  const AddExperienceButton({
    Key? key,
    required this.saveExperienceFn,
  }) : super(key: key);
  final void Function(Employment employment) saveExperienceFn;
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
          _showExperienceFormGeneralDialog(context, saveExperienceFn);
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Experience'),
      ),
    );
  }
}

class ExperienceForm extends StatefulWidget {
  const ExperienceForm({
    Key? key,
    required this.saveExperienceFn,
    this.employment,
  }) : super(key: key);

  final void Function(Employment employment) saveExperienceFn;
  final Employment? employment;

  @override
  State<ExperienceForm> createState() => _ExperienceFormState();
}

class _ExperienceFormState extends State<ExperienceForm> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _titleField;
  TextEditingController? _companyField;
  TextEditingController? _cityField;
  TextEditingController? _regionField;
  TextEditingController? _startDateField;
  TextEditingController? _endDateField;
  TextEditingController? _descriptionField;

  @override
  void initState() {
    super.initState();
    _titleField = TextEditingController();
    _companyField = TextEditingController();
    _cityField = TextEditingController();
    _regionField = TextEditingController();
    _startDateField = TextEditingController();
    _endDateField = TextEditingController();
    _descriptionField = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    bool isLargerThenMobile =
        ResponsiveWrapper.of(context).isLargerThan(MOBILE);
    if (widget.employment != null) {
      _titleField!.text = widget.employment!.title;
      _companyField!.text = widget.employment!.company;
      _cityField!.text = widget.employment!.city;
      _regionField!.text = widget.employment!.region;
      _startDateField!.text = "${widget.employment!.period.start.year}"
          "-${widget.employment!.period.start.month}";
      _endDateField!.text = "${widget.employment!.period.end.year}"
          "-${widget.employment!.period.end.month}";
      _descriptionField!.text = widget.employment!.summary;
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextFormField(
                      validator: RequiredValidator(errorText: "required"),
                      label: 'Title',
                      controller: _titleField,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      validator: RequiredValidator(errorText: "required"),
                      label: 'Company',
                      controller: _companyField,
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
                          child: CustomTextFormField(
                            validator: RequiredValidator(errorText: "required"),
                            label: 'City',
                            controller: _cityField,
                          ),
                        ),
                        ResponsiveRowColumnItem(
                          rowFlex: 1,
                          child: CustomTextFormField(
                            validator: RequiredValidator(errorText: "required"),
                            label: 'Region',
                            controller: _regionField,
                          ),
                        ),
                      ],
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
                    DescriptionField(controller: _descriptionField),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
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
        firstDate: DateTime(2020, 8),
        lastDate: DateTime(2101));
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

  ElevatedButton saveButton() {
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
          if (widget.employment != null) {
            id = widget.employment?.id;
          }
          Employment employment = Employment(
            _companyField!.text,
            _cityField!.text,
            _regionField!.text,
            _titleField!.text,
            RangeDate(startDate, endDate),
            _descriptionField!.text,
            id: id,
          );

          widget.saveExperienceFn(employment);
        }
      },
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Save'),
      ),
    );
  }
}

class ExperienceTile extends StatelessWidget {
  const ExperienceTile({
    Key? key,
    required this.employment,
    required this.removeExperienceFn,
    required this.saveExperienceFn,
  }) : super(key: key);

  final Employment employment;
  final void Function(Employment employment) removeExperienceFn;
  final void Function(Employment employment) saveExperienceFn;

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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: isLargerThanMobile ? 72 : 40,
                  padding: const EdgeInsets.only(top: 5),
                  alignment: Alignment.topCenter,
                  child: FaIcon(
                    FontAwesomeIcons.suitcase,
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
                          employment.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextWithOpacity(opacity: 0.9, text: employment.company),
                        TextWithOpacity(
                          opacity: 0.6,
                          text:
                              "${employment.period.start.year}/${employment.period.start.month} - "
                              "${employment.period.end.year}/${employment.period.end.month}",
                        ),
                        TextWithOpacity(
                          opacity: 0.6,
                          text: "${employment.city}, ${employment.region}",
                        ),
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
                              ? _showExperienceFormDialog(
                                  context, saveExperienceFn,
                                  employment: employment)
                              : _showExperienceFormGeneralDialog(
                                  context, saveExperienceFn,
                                  employment: employment);
                        },
                        icon: Icons.edit,
                        padding: 11,
                      ),
                      const SizedBox(height: 15),
                      CircularIconButton(
                        onPressed: () {
                          removeExperienceFn(employment);
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
      ),
    );
  }
}
