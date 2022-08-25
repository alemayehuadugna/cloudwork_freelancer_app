import 'package:CloudWork_Freelancer/modules/user/domain/usecases/employment/save_employment.dart';
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

class ExperienceForm extends StatefulWidget {
  const ExperienceForm({
    Key? key,
    required this.onSave,
    this.employment,
  }) : super(key: key);

  final void Function() onSave;
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
                              validator:
                                  RequiredValidator(errorText: "required"),
                              label: 'City',
                              controller: _cityField,
                            ),
                          ),
                          ResponsiveRowColumnItem(
                            rowFlex: 1,
                            child: CustomTextFormField(
                              validator:
                                  RequiredValidator(errorText: "required"),
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
              DialogBottomActions(
                onSave: () {
                  if (_formKey.currentState!.validate()) {
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

                    BlocProvider.of<UpdateProfileBloc>(context)
                        .add(AddExperienceEvent(employment));
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
}
