import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../_shared/interface/widgets/show_top_flash.dart';
import '../../../router.dart';
import '../../view_profile/bloc/detail_user_bloc.dart';
import '../bloc/update_profile_bloc.dart';
import '../widgets/widgets.dart';

const _title =
    'Tell us about the work you do. What is the main service you offer?';
const _subtitle =
    "Relevant experience can help your profile stand out. Choose the categories that best describe the type of work you do so we can show you to the right type of clients in search results.";

const _mapList = {
  'Accounting & Consulting': [
    "Accounting & Bookkeeping",
    "Financial Planning",
    "Human Resources",
    "Management Consulting & Analysis",
    "Other - Accounting & Consulting"
  ],
  'Admin Support': [
    "Data Entry & Transcription Services",
    "Market Research & Product Reviews",
    "Project Management",
    "Virtual Assistance"
  ],
  'Customer Service': [
    "Community Management & Tagging",
    "Customer Experience & Tech Support"
  ],
  'Data Science & Analytics': [
    "AI & Machine Learning",
    "Data Analysis & Testing",
    "Data Design & Visualization",
    "Data Extraction/ETL",
    "Data Mining & Management"
  ],
  'Design & Creative': [
    "Art & Illustration",
    "Audio & Music Production",
    "Branding & Logo Design",
    "Graphic, Editorial & Presentation Design",
    "NFT, AR/VR & Game Art",
    "Performing Arts",
    "Photography",
    "Product Design",
    "Video & Animation"
  ],
  "Engineering & Architecture": [
    "3D Modeling & CAD",
    "Buildings & Landscape Architecture",
    "Chemical Engineering",
    "Civil & Structural Engineering",
    "Contract Manufacturing",
    "Electrical & Electronic Engineering",
    "Energy & Mechanical Engineering",
    "Interior & Trade Show Design",
    "Physical Sciences"
  ],
  'IT & Networking': [
    "Database Management & Administration",
    "DevOps & Solutions Architecture",
    "ERP/CRM Software",
    "Information Security & Compliance",
    "Network & System Administration"
  ],
  'Legal': [
    "Corporate & Contract Law",
    "Finance & Tax Law",
    "International & Immigration Law",
    "Public Law"
  ],
  'Sales & Marketing': [
    "Display Advertising",
    "Email & Marketing Automation",
    "Lead Generation & Telemarketing",
    "Marketing & Brand Strategy",
    "SEO & SEM Services",
    "Social Media & PR Services"
  ],
  'Translation': [
    "Legal, Medical & Technical Translation",
    "Translation & Localization"
  ],
  'Web, Mobile & Software Development': [
    "Blockchain, NFT & Cryptocurrency",
    "Desktop Application Development",
    "Ecommerce Development",
    "Game Design & Development",
    "Mobile Development",
    "Other - Software Development",
    "Product Management",
    "QA & Testing",
    "Scripts & Utilities",
    "Web & Mobile Design",
    "Web Development",
  ],
  'Writing': [
    "Content & Copywriting",
    "Creative Writing Services",
    "Editing & Proofreading Services",
    "Grant & Proposal Writing",
    "Other - Writing",
    "Resumes & Cover Letters",
    "Technical Writing",
  ]
};

class AddAreaOfWorkPage extends StatelessWidget {
  const AddAreaOfWorkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveWrapper.of(context).isMobile;
    BlocProvider.of<DetailUserBloc>(context).add(GetDetailUserEvent());
    String? category;
    String? subcategory;

    void updateMainService({String? newCategory, String? newSubcategory}) {
      if (newCategory != null) category = newCategory;
      if (newSubcategory != null) subcategory = newSubcategory;
    }

    return BlocConsumer<DetailUserBloc, DetailUserState>(
      listener: (context, state) async {
        if (state is DetailUserLoading) {
          context.loaderOverlay.show();
        }
        if (state is DetailUserLoaded) {
          context.loaderOverlay.hide();
          if (state.user.mainService != null) {
            category = state.user.mainService!.category;
            subcategory = state.user.mainService!.subcategory;
          }
        }
      },
      builder: (context, state) {
        return Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (isMobile) const LinearProgressIndicator(value: 0.873),
              _BuildBody(
                category: category,
                subcategory: subcategory,
                updateMainService: updateMainService,
              ),
              if (!isMobile) const LinearProgressIndicator(value: 0.873),
              BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
                listener: (context, state) {
                  if (state is ErrorUpdatingProfile) {
                    showTopSnackBar(
                      title: const Text('Error'),
                      content: Text(state.message),
                      icon: const Icon(Icons.error),
                      context: context,
                    );
                  }
                  if (state is UpdateProfileSuccess) {
                    context.pushNamed(createProfileBasicProfileRouteName);
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
                    nextRouteTitle: "Lastly, Add Basic Profile",
                    onPressed: () {
                      if (category != null && subcategory != null) {
                        if (_mapList[category]!.contains(subcategory)) {
                          BlocProvider.of<UpdateProfileBloc>(context).add(
                              SaveMainServiceEvent(category!, subcategory!));
                        } else {
                          showTopSnackBar(
                            title: const Text('Error'),
                            content: const Text(
                              "subcategory does not exists in category",
                            ),
                            icon: const Icon(Icons.error),
                            context: context,
                          );
                        }
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
    required this.category,
    required this.subcategory,
    required this.updateMainService,
  }) : super(key: key);

  final String? category;
  final String? subcategory;
  final void Function({String? newCategory, String? newSubcategory})
      updateMainService;

  @override
  State<_BuildBody> createState() => _BuildBodyState();
}

class _BuildBodyState extends State<_BuildBody> {
  List<String> subCategory = [];
  @override
  Widget build(BuildContext context) {
    if (widget.category != null) {
      subCategory.addAll(_mapList[widget.category]!.toList());
    }
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
            child: Column(
              children: [
                DropdownSearch<String>(
                  dropdownSearchDecoration: const InputDecoration(
                    label: Text("Category"),
                    // constraints: BoxConstraints(maxHeight: 50),
                  ),
                  selectedItem: widget.category,
                  // showSearchBox: false,
                  // mode: Mode.MENU,
                  items: _mapList.keys.toList(),
                  onChanged: (String? value) {
                    setState(() {
                      widget.updateMainService(newCategory: value);
                      subCategory.clear();
                      subCategory.addAll(_mapList[value]!.toList());
                    });
                  },
                ),
                const SizedBox(height: 25),
                DropdownSearch<String>(
                  dropdownSearchDecoration: const InputDecoration(
                    label: Text("Subcategory"),
                    // constraints: BoxConstraints(maxHeight: 50),
                  ),
                  onChanged: (String? value) {
                    widget.updateMainService(newSubcategory: value);
                  },
                  selectedItem: widget.subcategory,
                  // showSearchBox: false,
                  // mode: Mode.MENU,
                  items: subCategory,
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
