import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../_shared/domain/entities/range_date.dart';
import '../../../domain/entities/detail_user.dart';
import '../../create_profile/bloc/update_profile_bloc.dart';
import '../../create_profile/widgets/widgets.dart';
import 'widgets.dart';

class EducationForm extends StatefulWidget {
  const EducationForm({
    Key? key,
    required this.onSave,
    this.education,
  }) : super(key: key);

  final void Function() onSave;
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
    if (widget.education != null) {
      _institutionField =
          TextEditingController(text: widget.education!.institution);
      _degreeField = TextEditingController(text: widget.education!.degree);
      _areaOfStudyField =
          TextEditingController(text: widget.education!.areaOfStudy);
      _startDateField = TextEditingController(
          text:
              "${widget.education!.dateAttended.start.year}/${widget.education!.dateAttended.start.month}");
      _endDateField = TextEditingController(
          text:
              "${widget.education!.dateAttended.end.year}/${widget.education!.dateAttended.end.year}");
      _descriptionField =
          TextEditingController(text: widget.education!.description);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLargerThenMobile =
        ResponsiveWrapper.of(context).isLargerThan(MOBILE);

    return BlocListener<UpdateProfileBloc, UpdateProfileState>(
      listener: (context, state) {
        if (state is UpdateProfileSuccess) {
          Navigator.of(context, rootNavigator: true).pop();
          widget.onSave();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
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
              ),
              DialogBottomActions(
                onSave: () {
                  if (_formKey.currentState!.validate()) {
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
                    BlocProvider.of<UpdateProfileBloc>(context)
                        .add(SaveEducationEvent(education));
                  }
                },
              )
            ],
          ),
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
          print("picked date: $picked");
          startDate = picked;
          _startDateField?.text = "${startDate.year}-${startDate.month}";
        } else if (pickerFor == 'End') {
          print("picked date: $picked");
          endDate = picked;
          _endDateField?.text = "${endDate.year}-${endDate.month}";
        }
      });
    }
  }
}
