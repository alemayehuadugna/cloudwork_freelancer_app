import 'package:CloudWork_Freelancer/modules/user/domain/entities/detail_user.dart';
import 'package:CloudWork_Freelancer/modules/user/views/edit_profile/widgets/dialog_bottom_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../../../_shared/interface/widgets/show_top_flash.dart';
import '../../create_profile/bloc/update_profile_bloc.dart';
import '../../create_profile/widgets/widgets.dart';

class OtherExperienceForm extends StatelessWidget {
  OtherExperienceForm({
    Key? key,
    required this.onSave,
    this.otherExperience,
  }) : super(key: key);

  final void Function() onSave;
  final OtherExperience? otherExperience;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController? _descriptionField = TextEditingController();
  final TextEditingController? _subjectField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (otherExperience != null) {
      _descriptionField!.text = otherExperience!.description;
      _subjectField!.text = otherExperience!.subject;
    }
    return BlocListener<UpdateProfileBloc, UpdateProfileState>(
      listener: (context, state) {
        if (state is UpdateProfileSuccess) {
          Navigator.of(context, rootNavigator: true).pop();
          onSave();
        }
        if (state is ErrorUpdatingProfile) {
          showTopSnackBar(
            title: const Text('Error'),
            content: Text(state.message),
            icon: const Icon(Icons.error),
            context: context,
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        validator: RequiredValidator(errorText: "required"),
                        label: 'Subject',
                        controller: _subjectField,
                      ),
                      const SizedBox(height: 20),
                      DescriptionField(controller: _descriptionField),
                    ],
                  ),
                ),
              ),
              DialogBottomActions(onSave: () {
                if (_formKey.currentState!.validate()) {
                  String? id;
                  if (otherExperience != null) {
                    id = otherExperience?.id;
                  }
                  OtherExperience newOtherExperience = OtherExperience(
                    _subjectField!.text,
                    _descriptionField!.text,
                    id: id,
                  );

                  BlocProvider.of<UpdateProfileBloc>(context)
                      .add(SaveOtherExperienceEvent(newOtherExperience));
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
