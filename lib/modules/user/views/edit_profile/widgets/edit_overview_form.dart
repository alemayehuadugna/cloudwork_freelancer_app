import 'package:CloudWork_Freelancer/modules/user/views/edit_profile/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../create_profile/bloc/update_profile_bloc.dart';

const _hintText =
    'Describe your top skills, experiences, and interests. This is one of the first things clients will see on your profile.';

class EditOverviewForm extends StatelessWidget {
  const EditOverviewForm({
    Key? key,
    required this.overview,
    required this.onSave,
  }) : super(key: key);

  final String overview;
  final void Function() onSave;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController? overviewField = TextEditingController();
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
                  controller: overviewField,
                  keyboardType: TextInputType.multiline,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'empty not allowed'),
                    MinLengthValidator(200,
                        errorText: 'must be at least 200 characters long'),
                  ]),
                  minLines: 8,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintMaxLines: 8,
                    hintText: _hintText,
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
              DialogBottomActions(onSave: () {
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<UpdateProfileBloc>(context)
                      .add(SaveOverviewEvent(overviewField.text));
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
