import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flash/flash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../_core/di/get_It.dart';
import '../../../../../_shared/domain/entities/address.dart';
import '../../../../../_shared/interface/bloc/auth/auth_bloc.dart';
import '../../../../../_shared/interface/widgets/show_top_flash.dart';
import '../../../domain/entities/detail_user.dart';
import '../../view_profile/bloc/detail_user_bloc.dart';
import '../bloc/update_profile_bloc.dart';
import '../widgets/widgets.dart';

class AddBasicProfilePage extends StatelessWidget {
  AddBasicProfilePage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController? _cityField = TextEditingController();
  final TextEditingController? _areaNameField = TextEditingController();
  final TextEditingController? _postalCodeField = TextEditingController();
  DetailUser? user;
  String? region;
  String? gender;
  String? available;

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveWrapper.of(context).isMobile;
    BlocProvider.of<DetailUserBloc>(context).add(GetDetailUserEvent());

    void assignRegionFn(String? newRegion) => region = newRegion;
    void assignGenderFn(String? newGender) => gender = newGender;
    void assignAvailabilityFn(String? newAvailability) =>
        available = newAvailability;

    return BlocConsumer<DetailUserBloc, DetailUserState>(
      listener: (context, state) {
        if (state is DetailUserLoading) {
          context.loaderOverlay.show();
        }
        if (state is DetailUserLoaded) {
          user = state.user;
          _cityField!.text = state.user.address?.city ?? "";
          _areaNameField!.text = state.user.address?.areaName ?? "";
          _postalCodeField!.text = state.user.address?.postalCode ?? "";
          context.loaderOverlay.hide();
        }
      },
      builder: (context, state) {
        return Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (isMobile) const LinearProgressIndicator(value: 1.0),
              _BuildBody(
                user: user,
                areaNameField: _areaNameField,
                assignAvailableFn: assignAvailabilityFn,
                assignGenderFn: assignGenderFn,
                assignRegionFn: assignRegionFn,
                cityField: _cityField,
                postalCodeField: _postalCodeField,
                formKey: _formKey,
              ),
              if (!isMobile) const LinearProgressIndicator(value: 1.0),
              BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
                listener: (context, state) {
                  if (user != null) {
                    BlocProvider.of<AuthBloc>(context)
                        .add(const GetBasicUserEvent());
                  }
                  if (state is ErrorUpdatingProfile) {
                    showTopSnackBar(
                      content: Text(state.message),
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
                            padding: EdgeInsets.all(12.0),
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      ),
                    );
                  }
                  return CreateProfileFooter(
                    nextRouteTitle: "Finish",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (user != null) {
                          if (user?.profilePicture == '') {
                            showFlash(
                              context: context,
                              duration: Duration(seconds: 2),
                              builder: (context, controller) {
                                return Flash(
                                  controller: controller,
                                  behavior: FlashBehavior.floating,
                                  position: FlashPosition.top,
                                  boxShadows: kElevationToShadow[4],
                                  horizontalDismissDirection:
                                      HorizontalDismissDirection.horizontal,
                                  child: FlashBar(
                                    content: Text('This is a basic flash'),
                                  ),
                                );
                              },
                            );
                          }
                        }
                        final address = Address(
                          region != null ? region! : user!.address!.region,
                          _cityField!.text,
                          _areaNameField!.text.isEmpty
                              ? null
                              : _areaNameField?.text,
                          _postalCodeField!.text.isEmpty
                              ? null
                              : _postalCodeField!.text,
                        );
                        BlocProvider.of<UpdateProfileBloc>(context)
                            .add(SaveBasicInfoEvent(
                          gender ?? user!.gender!,
                          available ?? user!.available,
                          address,
                        ));
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

class _BuildBody extends StatelessWidget {
  const _BuildBody({
    Key? key,
    required this.user,
    required this.areaNameField,
    required this.cityField,
    required this.postalCodeField,
    required this.assignAvailableFn,
    required this.assignGenderFn,
    required this.assignRegionFn,
    required this.formKey,
  }) : super(key: key);

  final DetailUser? user;

  final TextEditingController? cityField;
  final TextEditingController? areaNameField;
  final TextEditingController? postalCodeField;
  final void Function(String? region) assignRegionFn;
  final void Function(String? gender) assignGenderFn;
  final void Function(String? available) assignAvailableFn;
  final Key formKey;

  @override
  Widget build(BuildContext context) {
    var isLargerThanMobile = ResponsiveWrapper.of(context).isLargerThan(MOBILE);
    void fileUploadSuccess() {
      BlocProvider.of<DetailUserBloc>(context).add(GetDetailUserEvent());
    }

    return Expanded(
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
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
                  child: ResponsiveRowColumn(
                    rowSpacing: 10,
                    columnSpacing: 10,
                    rowCrossAxisAlignment: CrossAxisAlignment.start,
                    layout: isLargerThanMobile
                        ? ResponsiveRowColumnType.ROW
                        : ResponsiveRowColumnType.COLUMN,
                    children: [
                      ResponsiveRowColumnItem(
                        rowFlex: 3,
                        child: Column(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: CircleAvatar(
                                radius: 50,
                                child: ClipOval(
                                  child: user != null &&
                                          user!.profilePicture.isNotEmpty
                                      ? Image.network(
                                          user!.profilePicture,
                                          width: 100,
                                          height: 100,
                                        )
                                      : Image.asset(
                                          "assets/images/profile_placeholder.png"),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            OutlinedButton.icon(
                              onPressed: () {
                                isLargerThanMobile
                                    ? _showUploadPhotoDialog(
                                        context,
                                        UploadProfileBody(
                                          imageUrl: user!.profilePicture,
                                          fileUploadSuccess: fileUploadSuccess,
                                        ),
                                      )
                                    : _showUploadPhotoGeneralDialog(
                                        context,
                                        UploadProfileBody(
                                          imageUrl: user!.profilePicture,
                                          fileUploadSuccess: fileUploadSuccess,
                                        ),
                                      );
                              },
                              icon: const Icon(Icons.add),
                              label: const Text('Upload Photo'),
                            )
                          ],
                        ),
                      ),
                      if (isLargerThanMobile)
                        const ResponsiveRowColumnItem(
                            child: VerticalDivider(
                          width: 10,
                          color: Colors.black,
                          thickness: 2,
                        )),
                      ResponsiveRowColumnItem(
                          rowFlex: 5,
                          child: Column(
                            children: [
                              SizedBox(
                                // height: 52,
                                child: DropdownSearch<String>(
                                  validator: RequiredValidator(
                                      errorText: 'region required'),
                                  dropdownSearchDecoration:
                                      const InputDecoration(
                                    isDense: true,
                                    label: Text('Region'),
                                  ),
                                  // showSearchBox: false,
                                  selectedItem: user == null
                                      ? ""
                                      : user!.address == null
                                          ? ""
                                          : user!.address!.region,
                                  // mode: Mode.MENU,
                                  items: _region,
                                  onChanged: (String? value) {
                                    assignRegionFn(value);
                                  },
                                ),
                              ),
                              const SizedBox(height: 15),
                              CustomTextFormField(
                                controller: cityField,
                                label: "City",
                                validator: RequiredValidator(
                                    errorText: "city required"),
                              ),
                              const SizedBox(height: 15),
                              CustomTextFormField(
                                controller: areaNameField,
                                label: "Area Name",
                                validator: null,
                              ),
                              const SizedBox(height: 15),
                              CustomTextFormField(
                                controller: postalCodeField,
                                label: "Postal Code",
                                validator: null,
                              ),
                              const SizedBox(height: 15),
                              ResponsiveRowColumn(
                                rowSpacing: 10,
                                columnSpacing: 10,
                                layout: isLargerThanMobile
                                    ? ResponsiveRowColumnType.ROW
                                    : ResponsiveRowColumnType.COLUMN,
                                children: [
                                  ResponsiveRowColumnItem(
                                    rowFlex: 1,
                                    child: SizedBox(
                                      height: 52,
                                      child: DropdownSearch<String>(
                                        popupProps: const PopupProps.menu(
                                            menuProps: MenuProps(
                                                constraints: BoxConstraints(
                                                    maxHeight: 160))),
                                        validator: RequiredValidator(
                                            errorText: 'availability required'),
                                        // maxHeight: 145,
                                        dropdownSearchDecoration:
                                            const InputDecoration(
                                          label: Text('Availability'),
                                        ),
                                        // mode: Mode.MENU,
                                        selectedItem:
                                            user == null ? "" : user!.available,
                                        items: const [
                                          "Not Available",
                                          "Part Time",
                                          "Full Time",
                                        ],
                                        onChanged: (String? value) {
                                          assignAvailableFn(value);
                                        },
                                      ),
                                    ),
                                  ),
                                  ResponsiveRowColumnItem(
                                    rowFlex: 1,
                                    child: SizedBox(
                                      height: 52,
                                      child: DropdownSearch<String>(
                                        popupProps: const PopupProps.menu(
                                            menuProps: MenuProps(
                                                constraints: BoxConstraints(
                                                    maxHeight: 100))),
                                        validator: RequiredValidator(
                                            errorText: "required"),
                                        // maxHeight: 100,
                                        dropdownSearchDecoration:
                                            const InputDecoration(
                                          isDense: true,
                                          label: Text('Gender'),
                                        ),
                                        // mode: Mode.MENU,
                                        selectedItem:
                                            user == null ? "" : user!.gender,
                                        items: const ["Male", "Female"],
                                        onChanged: (String? value) {
                                          assignGenderFn(value);
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showUploadPhotoGeneralDialog(BuildContext context, Widget body) {
  showGeneralDialog(
    context: context,
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
    pageBuilder: (context, anim, anis) {
      return SafeArea(
        child: SizedBox.expand(
          child: Scaffold(
            body: Column(
              children: [
                const CreateProfileHeader(title: 'Upload Profile Photo'),
                const Divider(),
                body
              ],
            ),
          ),
        ),
      );
    },
  );
}

void _showUploadPhotoDialog(BuildContext context, Widget body) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            height: 600,
            width: 750,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const CreateProfileHeader(title: 'Upload Profile Photo'),
                const Divider(),
                body
              ],
            ),
          ),
        );
      });
}

class UploadProfileBody extends StatefulWidget {
  const UploadProfileBody({
    Key? key,
    required this.imageUrl,
    required this.fileUploadSuccess,
  }) : super(key: key);
  final String imageUrl;
  final void Function() fileUploadSuccess;

  @override
  State<UploadProfileBody> createState() => _UploadProfileBodyState();
}

class _UploadProfileBodyState extends State<UploadProfileBody> {
  PlatformFile? pickedFile;
  @override
  Widget build(BuildContext context) {
    bool isLargerThanMobile =
        ResponsiveWrapper.of(context).isLargerThan(MOBILE);
    return BlocProvider(
      create: (context) => container<UpdateProfileBloc>(),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: isLargerThanMobile
              ? 480
              : MediaQuery.of(context).size.height - 110,
          child: LoaderOverlay(
            useDefaultLoading: false,
            overlayWidget: Center(
              child: SpinKitCircle(
                color: Theme.of(context).colorScheme.secondary,
                size: 50.0,
              ),
            ),
            overlayColor: Colors.black,
            overlayOpacity: 0.7,
            child: BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
              listener: (context, state) {
                if (state is UpdateProfileLoading) {
                  context.loaderOverlay.show();
                }
                if (state is ErrorUpdatingProfile) {
                  context.loaderOverlay.hide();
                  showTopSnackBar(
                    title: const Text('Error'),
                    content: Text(state.message),
                    icon: const Icon(Icons.error),
                    context: context,
                  );
                }
                if (state is UpdateProfileSuccess) {
                  context.loaderOverlay.hide();
                  Navigator.of(context, rootNavigator: true).pop();
                  widget.fileUploadSuccess();
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    pickedFile != null
                        ? kIsWeb
                            ? Container(
                                height: 200,
                                margin: const EdgeInsets.only(bottom: 30),
                                child: Image.memory(pickedFile!.bytes!),
                              )
                            : Container(
                                height: 200,
                                margin: const EdgeInsets.only(bottom: 30),
                                child: Image.file(File(pickedFile!.path!)),
                              )
                        : widget.imageUrl.isNotEmpty
                            ? Container(
                                height: 200,
                                margin: const EdgeInsets.only(bottom: 30),
                                child: Image.network(widget.imageUrl),
                              )
                            : Container(
                                height: 200,
                                margin: const EdgeInsets.only(bottom: 30),
                                child: Image.asset(
                                    "assets/images/profile_placeholder.png"),
                              ),
                    OutlinedButton(
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(const Size(360, 50))),
                      onPressed: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.any,
                          allowMultiple: false,
                        );
                        if (result != null) {
                          setState(() {
                            pickedFile = result.files.single;
                          });
                        } else {
                          // User canceled the picker
                        }
                      },
                      child: const Text("Select Profile Image"),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your photo should:",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        const Text("- Be a close-up of your face"),
                        const SizedBox(height: 5),
                        const Text("- Show your face clearly - no sunglasses!"),
                        const SizedBox(height: 5),
                        const Text("- Be clear and crisp"),
                        const SizedBox(height: 5),
                        const Text("- Have a neutral background"),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: isLargerThanMobile
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                  isLargerThanMobile
                                      ? const Size(100, 50)
                                      : const Size(200, 50),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              },
                              child: const Text(
                                "Cancel",
                              )),
                          ElevatedButton(
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                isLargerThanMobile
                                    ? const Size(100, 50)
                                    : const Size(200, 50),
                              ),
                            ),
                            onPressed: () {
                              BlocProvider.of<UpdateProfileBloc>(context)
                                  .add(UploadProfilePictureEvent(pickedFile));
                            },
                            child: const Text(" Save "),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

const _title = 'A few last details - then you can publish your profile.';
const _subtitle =
    "A professional photo helps you build trust with your clients. To keep things safe and simple, they’ll pay you through us - which is why we need your personal information.";

const _region = [
  "Federal",
  "Tigray",
  "Afar",
  "Amhara",
  "Oromia",
  "Somali",
  "Benishangul-Gumuz",
  "Southern Nations, Nationalities and Peoples Region (SNNPR)",
  "Gambella",
  "Harari",
  "Sidama",
  "South West"
];
