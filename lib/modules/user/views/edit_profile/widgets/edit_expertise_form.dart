import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../create_profile/bloc/update_profile_bloc.dart';
import 'widgets.dart';

class EditExpertiseForm extends StatelessWidget {
  const EditExpertiseForm({
    Key? key,
    required this.expertise,
    required this.onSave,
  }) : super(key: key);

  final String expertise;
  final void Function() onSave;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController? _expertiseField = TextEditingController(text: expertise);
    return BlocListener<UpdateProfileBloc, UpdateProfileState>(
      listener: (context, state) {
        if (state is UpdateProfileSuccess) {
          Navigator.of(context, rootNavigator: true).pop();
          onSave();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: _expertiseField,
                  validator: RequiredValidator(errorText: 'Input required'),
                  decoration: const InputDecoration(
                    isDense: true,
                    label: Text("Expertise"),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFdadce0), width: 0.6),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFdadce0), width: 0.6),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              DialogBottomActions(
                onSave: () {
                  if (_formKey.currentState!.validate()) {
                    BlocProvider.of<UpdateProfileBloc>(context)
                        .add(AddExpertiseEvent(_expertiseField.text));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
