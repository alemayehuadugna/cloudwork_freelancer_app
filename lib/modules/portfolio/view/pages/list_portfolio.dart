import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../../../dashboard/router.dart';

class ListPortfolioPage extends StatelessWidget {
  const ListPortfolioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ResponsiveWrapper.of(context).isMobile
            ? BackButton(
                onPressed: () {
                  context.goNamed(homeRouteName);
                },
              )
            : null,
        title: const Text("Portfolio"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ResponsiveWrapper.of(context).isLargerThan(MOBILE)
              ? _showAddProvideDialog(
                  context,
                  const DetailPortfolioTile(),
                )
              : _showAddProfileGeneralDialog(
                  context,
                  const DetailPortfolioTile(),
                );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Portfolio'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: ResponsiveWrapper.of(context).isSmallerThan(TABLET)
              ? MediaQuery.of(context).size.height - 65
              : MediaQuery.of(context).size.height - 116,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AlignedGridView.extent(
              maxCrossAxisExtent: 500,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              itemCount: 8,
              itemBuilder: (context, state) {
                return Card(
                  elevation: 1,
                  child: SizedBox(
                    width: 600,
                    // color: Colors.amber,
                    child: Column(
                      children: [
                        const ImageHolder(),
                        SizedBox(
                          height: 100,
                          child: Center(
                            child: Text(
                              "Transport Website",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ImageHolder extends StatefulWidget {
  const ImageHolder({
    Key? key,
  }) : super(key: key);

  @override
  State<ImageHolder> createState() => _ImageHolderState();
}

void _showAddProfileGeneralDialog(BuildContext context, Widget body) {
  showGeneralDialog(
      context: context,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      pageBuilder: (context, anim, anis) {
        return SafeArea(
            child: SizedBox.expand(
          child: body,
        ));
      });
}

void _showAddProvideDialog(BuildContext context, Widget body) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: SizedBox(
          height: 600,
          width: 800,
          child: body,
        ),
      );
    },
  );
}

class _ImageHolderState extends State<ImageHolder> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: InkWell(
        child: Ink.image(
          width: double.infinity,
          height: 350,
          fit: BoxFit.cover,
          image: const AssetImage("assets/images/project-3.jpg"),
          child: isHover
              ? Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            const CircleBorder(),
                          ),
                          fixedSize: MaterialStateProperty.all(
                            const Size(55, 55),
                          ),
                        ),
                        onPressed: () {
                          ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                              ? _showAddProvideDialog(
                                  context, const DetailPortfolioTile())
                              : _showAddProfileGeneralDialog(
                                  context, const DetailPortfolioTile());
                        },
                        child: const Icon(Icons.edit),
                      ),
                      const SizedBox(width: 30),
                      ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            const CircleBorder(),
                          ),
                          fixedSize: MaterialStateProperty.all(
                            const Size(55, 55),
                          ),
                        ),
                        onPressed: () {
                          showAlertDialog(context);
                        },
                        child: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                )
              : null,
        ),
        hoverColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        onTap: () {},
        onHover: (value) {
          setState(() {
            isHover = value;
          });
        },
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text("No"),
    onPressed: () {},
  );
  Widget continueButton = TextButton(
    child: const Text("Yes"),
    onPressed: () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Delete"),
    content: const Text("Are you sure?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class DetailPortfolioTile extends StatefulWidget {
  const DetailPortfolioTile({Key? key}) : super(key: key);

  @override
  State<DetailPortfolioTile> createState() => _DetailPortfolioTileState();
}

class _DetailPortfolioTileState extends State<DetailPortfolioTile> {
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  final skills = ['Web Design', 'UI Design'];

  TagsTextField get _textField {
    return TagsTextField(
      textStyle: const TextStyle(fontSize: 16),
      hintText: "Add a Skill",
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      enabled: true,
      onSubmitted: (String str) {
        setState(() {
          skills.add(str);
        });
      },
    );
  }

  Widget get _tags {
    return Tags(
      key: _tagStateKey,
      symmetry: false,
      columns: 0,
      textField: _textField,
      itemCount: skills.length,
      alignment: WrapAlignment.start,
      itemBuilder: (index) {
        final item = skills[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
          child: ItemTags(
            key: Key(index.toString()),
            index: index,
            title: item,
            pressEnabled: false,
            removeButton: ItemTagsRemoveButton(
              backgroundColor: Theme.of(context).colorScheme.background,
              color: Theme.of(context).colorScheme.onBackground,
              onRemoved: () {
                setState(() {
                  skills.removeAt(index);
                });
                return true;
              },
            ),
            activeColor: Theme.of(context).colorScheme.primary,
            textColor: Theme.of(context).textTheme.headline6!.color!,
            elevation: 1,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Portfolio")),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop();
        },
        label: const Text("  Save  "),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DottedBorder(
                    dashPattern: const [8, 4],
                    strokeWidth: 2,
                    strokeCap: StrokeCap.round,
                    borderType: BorderType.RRect,
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.5),
                    radius: const Radius.circular(5),
                    child: SvgPicture.asset(
                      "assets/icons/image-upload.svg",
                      width: 600,
                      height: 300,
                      // color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 15),
                  OutlinedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                        const Size(200, 52),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text("Select Image"),
                  )
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(label: Text("Title")),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(label: Text("Link")),
              ),
              const SizedBox(height: 10),
              Container(
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
                    const Opacity(
                      opacity: 0.6,
                      child: Text('Skills', style: TextStyle(fontSize: 16)),
                    ),
                    const SizedBox(height: 5),
                    _tags,
                  ],
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                maxLines: 5,
                decoration: const InputDecoration(hintText: "Description"),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
