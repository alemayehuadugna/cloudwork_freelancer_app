import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../../../../../_core/di/get_It.dart';
import '../../../../../_shared/interface/widgets/show_top_flash.dart';
import '../../create_profile/bloc/update_profile_bloc.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveWrapper.of(context).isMobile;
    return BlocProvider(
      create: (context) => container<UpdateProfileBloc>(),
      child: BlocListener<UpdateProfileBloc, UpdateProfileState>(
        listener: (context, state) {
          if (state is ErrorUpdatingProfile) {
            showTopSnackBar(
              title: Text(
                "Error",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 16,
                ),
              ),
              content: Text(state.message),
              icon: Icon(
                Icons.error,
                color: Theme.of(context).colorScheme.error,
              ),
              context: context,
            );
          } else if (state is UpdateProfileSuccess) {
            _oldPasswordController.text = "";
            _newPasswordController.text = "";
            _confirmPasswordController.text = "";
            showTopSnackBar(
              title: const Text(
                "Success",
                style: TextStyle(color: Colors.green, fontSize: 16),
              ),
              content: const Text("Password Successfully Changed"),
              icon: const Icon(Icons.error, color: Colors.green),
              context: context,
            );
          }
        },
        child: BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
          builder: (context, state) {
            return Align(
              alignment: isMobile ? Alignment.topCenter : Alignment.center,
              child: SizedBox(
                width: isMobile ? double.infinity : 600,
                child: Container(
                  decoration: isMobile
                      ? null
                      : BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).cardColor,
                          border: Border.all(
                              width: 0.7, color: const Color(0xffdadce0)),
                        ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize:
                          isMobile ? MainAxisSize.max : MainAxisSize.min,
                      children: [
                        if (isMobile)
                          AppBar(
                            title: const Text("Change Password"),
                            leading: const BackButton(),
                          ),
                        if (!isMobile)
                          SizedBox(
                            height: 56,
                            child: Center(
                              child: Text(
                                "Change Password",
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                          ),
                        const Divider(height: 0.5),
                        Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _oldPasswordController,
                                decoration: const InputDecoration(
                                  label: Text("Old Password"),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFFdadce0), width: 0.8),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFFdadce0), width: 0.8),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              TextFormField(
                                validator: passwordValidator,
                                controller: _newPasswordController,
                                decoration: const InputDecoration(
                                  label: Text("New Password"),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFFdadce0), width: 0.8),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFFdadce0), width: 0.8),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              TextFormField(
                                validator: (val) => MatchValidator(
                                        errorText: 'passwords do not match')
                                    .validateMatch(
                                        val!, _newPasswordController.text),
                                controller: _confirmPasswordController,
                                decoration: const InputDecoration(
                                  label: Text("Confirm Password"),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFFdadce0), width: 0.8),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFFdadce0), width: 0.8),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                            ],
                          ),
                        ),
                        if (isMobile) const Expanded(child: SizedBox()),
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                const Size.fromHeight(52),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                BlocProvider.of<UpdateProfileBloc>(context).add(
                                    ChangePasswordEvent(
                                        _oldPasswordController.text,
                                        _newPasswordController.text));
                              }
                            },
                            child: const Text("Update"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
