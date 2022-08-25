import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';

import '../../create_profile/bloc/update_profile_bloc.dart';
import 'dialog_bottom_actions.dart';

class EditSkillsForm extends StatefulWidget {
  const EditSkillsForm({
    Key? key,
    required this.skills,
    required this.onSave,
  }) : super(key: key);

  final List<String> skills;
  final void Function() onSave;

  @override
  State<EditSkillsForm> createState() => _EditSkillsFormState();
}

class _EditSkillsFormState extends State<EditSkillsForm> {
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  bool showError = false;
  String errorMessage = "";

  Widget get _tags {
    return Tags(
      key: _tagStateKey,
      symmetry: false,
      columns: 0,
      textField: _textField,
      itemCount: widget.skills.length,
      alignment: WrapAlignment.start,
      itemBuilder: (index) {
        final item = widget.skills[index];

        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: ItemTags(
            key: Key(index.toString()),
            index: index,
            title: item,
            pressEnabled: false,
            removeButton: ItemTagsRemoveButton(
              margin: const EdgeInsets.only(left: 8.0, right: 5.0),
              icon: Icons.close,
              backgroundColor:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
              color: Theme.of(context).colorScheme.background,
              onRemoved: () {
                setState(() {
                  widget.skills.removeAt(index);
                });
                return true;
              },
            ),
            color:
                Theme.of(context).chipTheme.backgroundColor!.withOpacity(0.7),
            textColor: Theme.of(context).textTheme.headline6!.color!,
            border: Border.all(style: BorderStyle.none),
            active: false,
            elevation: 1,
          ),
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
      lowerCase: true,
      // suggestions: ["javascript", "typescript", "golang"],
      // constraintSuggestion: true,
      onSubmitted: (String str) {
        setState(() {
          widget.skills.add(str);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateProfileBloc, UpdateProfileState>(
      listener: (context, state) {
        if (state is UpdateProfileSuccess) {
          Navigator.of(context, rootNavigator: true).pop();
          widget.onSave();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .chipTheme
                      .backgroundColor!
                      .withOpacity(0.3),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Opacity(
                      opacity: 0.6,
                      child: Text('Skills',
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                    const SizedBox(height: 5),
                    _tags,
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            if (showError)
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            const Expanded(child: SizedBox()),
            DialogBottomActions(onSave: () {
              if (widget.skills.length < 3) {
                setState(() {
                  showError = true;
                  errorMessage = "At least 3 skills are required";
                });
              } else {
                BlocProvider.of<UpdateProfileBloc>(context)
                    .add(SaveSkillsEvent(widget.skills));
              }
            })
          ],
        ),
      ),
    );
  }
}
