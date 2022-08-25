import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../create_profile/bloc/update_profile_bloc.dart';
import 'widgets.dart';

class EditAvailabilityForm extends StatelessWidget {
  const EditAvailabilityForm({
    Key? key,
    required this.available,
    required this.onSave,
  }) : super(key: key);

  final String available;
  final void Function() onSave;

  @override
  Widget build(BuildContext context) {
    String? newAvailable;
    return BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
      listener: (context, state) {
        if (state is UpdateProfileSuccess) {
          Navigator.of(context, rootNavigator: true).pop();
          onSave();
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                child: DropdownSearch<String>(
                  popupProps: const PopupProps.menu(
                    menuProps: MenuProps(
                      elevation: 1,
                      constraints: BoxConstraints(maxHeight: 144),
                    ),
                  ),
                  items: const ['Not Available', 'Full Time', 'Part Time'],
                  selectedItem: available,
                  onChanged: (value) {
                    newAvailable = value;
                  },
                ),
              ),
              const Expanded(child: SizedBox()),
              DialogBottomActions(onSave: () {
                if (newAvailable != null) {
                  BlocProvider.of<UpdateProfileBloc>(context)
                      .add(ChangeAvailabilityEvent(newAvailable!));
                }
              })
            ],
          ),
        );
      },
    );
  }
}
