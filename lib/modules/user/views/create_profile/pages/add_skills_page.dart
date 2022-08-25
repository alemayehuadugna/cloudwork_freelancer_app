import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../_shared/interface/widgets/show_top_flash.dart';
import '../../../router.dart';
import '../../view_profile/bloc/detail_user_bloc.dart';
import '../bloc/update_profile_bloc.dart';
import '../widgets/widgets.dart';

const _title = 'Nearly there! What work are you here to do?';
const _subtitle =
    "Your skills show clients what you can offer, and help us choose which jobs to recommend to you. Add or remove the ones we’ve suggested, or start typing to pick more. It’s up to you.";

class AddSkillsPage extends StatelessWidget {
  const AddSkillsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveWrapper.of(context).isMobile;
    BlocProvider.of<DetailUserBloc>(context).add(GetDetailUserEvent());
    List<String> userSkills = [];
    return BlocConsumer<DetailUserBloc, DetailUserState>(
      listener: (context, state) {
        if (state is DetailUserLoading) {
          context.loaderOverlay.show();
        }
        if (state is DetailUserLoaded) {
          userSkills = state.user.skills;
          context.loaderOverlay.hide();
        }
      },
      builder: (context, state) {
        return Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (isMobile) const LinearProgressIndicator(value: 0.623),
              _BuildBody(userSkills: userSkills),
              if (!isMobile) const LinearProgressIndicator(value: 0.623),
              BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
                listener: (context, state) {
                  if (state is UpdateProfileSuccess) {
                    context.pushNamed(createProfileBioRouteName);
                  }
                  if (state is ErrorUpdatingProfile) {
                    showTopSnackBar(
                        title: const Text('Error'),
                        content: Text(state.message),
                        icon: const Icon(Icons.error),
                        context: context);
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
                    nextRouteTitle: "Now Write Your Bio",
                    onPressed: () {
                      if (userSkills.length < 3) {
                        showTopSnackBar(
                            title: const Text('Error'),
                            content: const Text("must add at least 3 skills"),
                            icon: const Icon(Icons.error),
                            context: context);
                      } else {
                        BlocProvider.of<UpdateProfileBloc>(context)
                            .add(SaveSkillsEvent(userSkills));
                      }
                    },
                  );
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
    required this.userSkills,
  }) : super(key: key);

  final List<String> userSkills;

  @override
  State<_BuildBody> createState() => _BuildBodyState();
}

class _BuildBodyState extends State<_BuildBody> {
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();

  Widget get _tags {
    return Tags(
      key: _tagStateKey,
      symmetry: false,
      columns: 0,
      textField: _textField,
      itemCount: widget.userSkills.length,
      alignment: WrapAlignment.start,
      itemBuilder: (index) {
        final item = widget.userSkills[index];

        return ItemTags(
          key: Key(index.toString()),
          index: index,
          title: item,
          pressEnabled: false,
          removeButton: ItemTagsRemoveButton(
            onRemoved: () {
              setState(() {
                widget.userSkills.removeAt(index);
              });
              return true;
            },
          ),
          textStyle: const TextStyle(fontSize: 16),
          color: Theme.of(context).chipTheme.backgroundColor!,
        );
      },
    );
  }

  TagsTextField get _textField {
    return TagsTextField(
      textStyle: const TextStyle(fontSize: 16),
      hintText: "Add a Skill",
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      enabled: true,
      onSubmitted: (String str) {
        if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(str)) {
          return;
        }
        setState(() {
          widget.userSkills.add(str);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var isLargerThanMobile = ResponsiveWrapper.of(context).isLargerThan(MOBILE);
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CreateProfileBodyTitleSubtitle(
            title: _title,
            subtitle: _subtitle,
          ),
          SizedBox(
            width: isLargerThanMobile ? 900 * 0.8 : double.infinity,
            child: Padding(
              padding: isLargerThanMobile
                  ? const EdgeInsets.only(left: 60)
                  : const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Skill',
                    style: Theme.of(context).primaryTextTheme.headline6,
                  ),
                  const SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).chipTheme.backgroundColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: _tags,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
