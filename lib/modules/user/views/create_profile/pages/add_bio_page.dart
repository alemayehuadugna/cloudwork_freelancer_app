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

const _title = 'Great! Now write a bio to tell the world about yourself.';
const _subtitle =
    "Help people get to know you at a glance. What work are you best at? Tell them clearly, using paragraphs or bullet points. You can always edit later - just make sure you proofread now!";
const _hintText =
    'Describe your top skills, experiences, and interests. This is one of the first things clients will see on your profile.';

class AddBioPage extends StatelessWidget {
  const AddBioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveWrapper.of(context).isMobile;
    BlocProvider.of<DetailUserBloc>(context).add(GetDetailUserEvent());
    final _formKey = GlobalKey<FormState>();
    TextEditingController? _overviewField = TextEditingController();
    return BlocConsumer<DetailUserBloc, DetailUserState>(
      listener: (context, state) async {
        if (state is DetailUserLoading) {
          context.loaderOverlay.show();
        }
        if (state is DetailUserLoaded) {
          _overviewField.text = state.user.overview;
          context.loaderOverlay.hide();
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
                if (isMobile) const LinearProgressIndicator(value: 0.748),
                _BuildBody(overviewField: _overviewField),
                if (!isMobile) const LinearProgressIndicator(value: 0.748),
                BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
                  listener: (context, state) {
                    if (state is ErrorUpdatingProfile) {
                      showTopSnackBar(
                          title: const Text('Error'),
                          content: Text(state.message),
                          icon: const Icon(Icons.error),
                          context: context);
                    }
                    if (state is UpdateProfileSuccess) {
                      context.pushNamed(createProfileAreaOfWorkRouteName);
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
                            CircularProgressIndicator(),
                          ],
                        ),
                      );
                    }
                    return CreateProfileFooter(
                      nextRouteTitle: "Choose, Your Area of Work",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<UpdateProfileBloc>(context)
                              .add(SaveOverviewEvent(_overviewField.text));
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
    required this.overviewField,
  }) : super(key: key);
  final TextEditingController overviewField;

  @override
  Widget build(BuildContext context) {
    var isLargerThanMobile = ResponsiveWrapper.of(context).isLargerThan(MOBILE);

    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CreateProfileBodyTitleSubtitle(
          title: _title,
          subtitle: _subtitle,
        ),
        SizedBox(
          width: isLargerThanMobile ? 900 * 0.6 : double.infinity,
          child: Padding(
            padding: isLargerThanMobile
                ? const EdgeInsets.only(left: 60)
                : const EdgeInsets.all(15),
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
                  borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.6),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
