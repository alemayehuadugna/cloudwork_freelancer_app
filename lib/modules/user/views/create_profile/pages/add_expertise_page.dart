import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../_shared/interface/widgets/show_top_flash.dart';
import '../../../router.dart';
import '../../view_profile/bloc/detail_user_bloc.dart';
import '../bloc/update_profile_bloc.dart';
import '../widgets/widgets.dart';

const _title = "Got it. Now, add a title to tell the world what you do.";
const _subtitle =
    "It’s the very first thing clients see, so make it count. Stand out by describing your expertise in your own words.";

class AddExpertisePage extends StatelessWidget {
  const AddExpertisePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveWrapper.of(context).isMobile;

    final _formKey = GlobalKey<FormState>();
    BlocProvider.of<DetailUserBloc>(context).add(GetDetailUserEvent());
    TextEditingController? _expertiseField = TextEditingController();

    return BlocConsumer<DetailUserBloc, DetailUserState>(
      listener: (context, state) async {
        if (state is DetailUserLoading) {
          context.loaderOverlay.show();
        }
        if (state is DetailUserLoaded) {
          _expertiseField.text = state.user.expertise;
          context.loaderOverlay.hide();
        }
        if (state is ErrorLoadingDetailUser) {
          context.loaderOverlay.hide();
          showTopSnackBar(
            content: const Text('Failed To Load User Information'),
            context: context,
            icon: const Icon(Icons.error),
            title: const Text('Error'),
          );
        }
      },
      builder: (context, state) {
        return Container(
          alignment: Alignment.center,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (isMobile) const LinearProgressIndicator(value: 0.125),
                _BuildBody(controller: _expertiseField),
                if (!isMobile) const LinearProgressIndicator(value: 0.125),
                BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
                  listener: (context, state) {
                    if (state is UpdateProfileSuccess) {
                      context.pushNamed(createProfileExperienceRouteName);
                    } else if (state is ErrorUpdatingProfile) {
                      showTopSnackBar(
                        content: const Text('Failed To Add Expertise'),
                        context: context,
                        icon: const Icon(Icons.error),
                        title: const Text('Error'),
                      );
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
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        ),
                      );
                    }
                    return CreateProfileFooter(
                      nextRouteTitle: "Next, Add Your Experience",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<UpdateProfileBloc>(context)
                              .add(AddExpertiseEvent(_expertiseField.text));
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BuildBody extends StatelessWidget {
  const _BuildBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    var largerThanMobile = ResponsiveWrapper.of(context).isLargerThan(MOBILE);
    return Expanded(
      child: SizedBox(
        width: largerThanMobile ? 900 : double.infinity,
        child: Padding(
          padding: largerThanMobile
              ? const EdgeInsets.fromLTRB(60, 30, 60, 30)
              : const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BigTitleText(
                title: _title,
              ),
              SizedBox(
                width: largerThanMobile ? 900 * 0.6 : double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SubTitleText(subtitle: _subtitle),
                    TextFormField(
                      controller: controller,
                      validator: RequiredValidator(errorText: 'Input required'),
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText:
                            "Example: Full Stack Developer | Web & Mobile",
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
                    )
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
