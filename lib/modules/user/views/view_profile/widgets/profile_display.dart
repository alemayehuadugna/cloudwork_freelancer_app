import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../domain/entities/detail_user.dart';

class ProfileDisplay extends StatelessWidget {
  const ProfileDisplay({
    Key? key,
    required this.user,
  }) : super(key: key);
  final DetailUser user;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PageHeader(user: user),
          const SizedBox(height: 10),
          PageBody(user: user),
        ],
      ),
    );
  }
}

class PageHeader extends StatelessWidget {
  const PageHeader({
    Key? key,
    required this.user,
  }) : super(key: key);
  final DetailUser user;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ResponsiveRowColumn(
            rowPadding: const EdgeInsets.all(10),
            columnPadding: const EdgeInsets.all(10),
            rowSpacing: 20,
            rowMainAxisAlignment: MainAxisAlignment.start,
            layout: ResponsiveWrapper.of(context).isLargerThan('MOBILE_LARGE')
                ? ResponsiveRowColumnType.ROW
                : ResponsiveRowColumnType.COLUMN,
            children: [
              const ResponsiveRowColumnItem(child: SizedBox()),
              ResponsiveRowColumnItem(
                child: Center(
                  child: 
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.network(
                      user.profilePicture,
                      height: 160,
                      width: 160,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              ResponsiveRowColumnItem(
                child: SizedBox(
                  height: ResponsiveWrapper.of(context).isSmallerThan(TABLET)
                      ? null
                      : 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: ResponsiveWrapper.of(context)
                            .isLargerThan('MOBILE_LARGE')
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "${user.firstName} ${user.lastName}".toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.verified,
                            color: user.verified
                                ? Colors.green
                                : Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(0.7),
                            size: 30,
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      IntrinsicHeight(
                        child: ResponsiveRowColumn(
                          columnSpacing: 5,
                          rowSpacing: 3,
                          rowMainAxisAlignment: MainAxisAlignment.center,
                          layout: ResponsiveWrapper.of(context)
                                  .isSmallerThan('MOBILE_LARGE')
                              ? ResponsiveRowColumnType.COLUMN
                              : ResponsiveRowColumnType.ROW,
                          children: [
                            ResponsiveRowColumnItem(
                              child: ResponsiveWrapper.of(context)
                                      .isSmallerThan(TABLET)
                                  ? Flexible(
                                      child:
                                          SizedBox(child: Text(user.expertise)))
                                  : SizedBox(child: Text(user.expertise)),
                            ),
                            ResponsiveRowColumnItem(
                                child: VerticalDivider(
                              color: Theme.of(context).colorScheme.onBackground,
                              thickness: 1,
                            )),
                            ResponsiveRowColumnItem(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      16.0, 5.0, 16.0, 5.0),
                                  child: Text(
                                    user.available,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      IntrinsicHeight(
                        child: ResponsiveRowColumn(
                          columnSpacing: 5,
                          rowSpacing: 3,
                          rowMainAxisAlignment: MainAxisAlignment.center,
                          layout: ResponsiveWrapper.of(context)
                                  .isSmallerThan('MOBILE_LARGE')
                              ? ResponsiveRowColumnType.COLUMN
                              : ResponsiveRowColumnType.ROW,
                          children: [
                            ResponsiveRowColumnItem(
                                child: SizedBox(
                              child: Text(
                                  "Member Since, ${DateFormat.yMMMM().format(user.joinedDate)}"),
                            )),
                            ResponsiveRowColumnItem(
                                child: VerticalDivider(
                              color: Theme.of(context).colorScheme.onBackground,
                              thickness: 1,
                            )),
                            ResponsiveRowColumnItem(
                                child: Text(user.address!.region)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  color: Color(0xFFFEBE42),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                              width: 28,
                              height: 21,
                              child: Center(
                                  child: Text(
                                "3.7",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(fontWeight: FontWeight.bold),
                              )),
                            ),
                            const RatingBar(rating: 3.4),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 4),
          StaggeredGrid.count(
            crossAxisCount:
                ResponsiveValue<int>(context, defaultValue: 4, valueWhen: [
              const Condition.equals(name: MOBILE, value: 2),
              const Condition.largerThan(name: MOBILE, value: 2),
              const Condition.largerThan(name: 'MOBILE_LARGE', value: 4),
              const Condition.largerThan(name: TABLET, value: 4),
            ]).value!,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            children: [
              Tile(
                count: user.completedJobs,
                title: "Completed Jobs",
                extent: 60,
                backgroundColor: const Color.fromARGB(255, 64, 132, 209),
              ),
              Tile(
                count: user.ongoingJobs,
                title: "Ongoing Jobs",
                extent: 60,
                backgroundColor: const Color.fromARGB(255, 190, 38, 109),
              ),
              Tile(
                count: user.cancelledJobs,
                title: "Cancelled Jobs",
                extent: 54,
                backgroundColor: const Color.fromARGB(255, 125, 39, 175),
              ),
              Tile(
                count: user.numberOfReviews,
                title: "Reviews",
                extent: 54,
                backgroundColor: const Color.fromARGB(255, 223, 207, 68),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RatingBar extends StatelessWidget {
  const RatingBar({
    Key? key,
    required this.rating,
  }) : super(key: key);
  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemBuilder: (context, index) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      itemCount: 5,
      itemSize: 22.0,
      direction: Axis.horizontal,
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.count,
    required this.title,
    this.extent,
    this.backgroundColor,
  }) : super(key: key);

  final String title;
  final int count;
  final double? extent;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: extent,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              count.toString(),
              style: TextStyle(
                fontSize: 16,
                color: backgroundColor,
              ),
            ),
            const SizedBox(width: 5),
            Flexible(child: Text(title, style: const TextStyle(fontSize: 14)))
          ],
        ),
      ),
    );
  }
}

class DetailCardTile extends StatelessWidget {
  const DetailCardTile({
    Key? key,
    required this.title,
    required this.rangeDate,
    required this.description,
  }) : super(key: key);

  final String title;
  final String rangeDate;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            rangeDate,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          const SizedBox(height: 6),
          Text(description),
        ],
      ),
    );
  }
}

class CardTile extends StatelessWidget {
  const CardTile({
    Key? key,
    required this.title,
    required this.body,
    this.editButton,
  }) : super(key: key);

  final String title;
  final Widget body;
  final bool? editButton;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            const Divider(),
            SizedBox(
              child: body,
            ),
          ],
        ),
      ),
    );
  }
}

class SkillTile extends StatelessWidget {
  const SkillTile({Key? key, required this.skill}) : super(key: key);

  final String skill;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).chipTheme.backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 5.0, 12.0, 5.0),
        child: Text("+ " + skill),
      ),
    );
  }
}

class PageBody extends StatelessWidget {
  const PageBody({
    Key? key,
    required this.user,
  }) : super(key: key);

  final DetailUser user;

  double langLevel(String value) {
    switch (value) {
      case "Basic":
        return 0.25;
      case "Conversational":
        return 0.5;
      case "Fluent":
        return 0.75;
      case "Native":
        return 1;
      default:
        return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveRowColumn(
      rowCrossAxisAlignment: CrossAxisAlignment.start,
      rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
      layout: ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
          ? ResponsiveRowColumnType.COLUMN
          : ResponsiveRowColumnType.ROW,
      children: [
        ResponsiveRowColumnItem(
          rowFlex: 4,
          child: Column(
            children: [
              CardTile(
                title: "Overview",
                body: Text(user.overview),
              ),
              const SizedBox(height: 10),
              CardTile(
                  title: "Rating",
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingTile(title: "Skill", rating: user.skillRating.rate),
                      RatingTile(
                          title: "Quality of Work",
                          rating: user.skillRating.rate),
                      RatingTile(
                          title: "Availability", rating: user.skillRating.rate),
                      RatingTile(
                          title: "Adherence To Schedule",
                          rating: user.skillRating.rate),
                      RatingTile(
                          title: "Communication",
                          rating: user.skillRating.rate),
                      RatingTile(
                          title: "Cooperation", rating: user.skillRating.rate),
                    ],
                  )),
              const SizedBox(height: 10),
              CardTile(
                title: 'Experience',
                body: ListView.builder(
                  shrinkWrap: true,
                  itemCount: user.employments.length,
                  itemBuilder: (BuildContext context, int i) {
                    return DetailCardTile(
                      title: user.employments[i].title,
                      rangeDate: "${user.employments[i].company} "
                          "${DateFormat.yMMMM().format(user.employments[i].period.start)} - "
                          "${DateFormat.yMMMM().format(user.employments[i].period.end)}",
                      description: user.employments[i].summary,
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              CardTile(
                title: 'Educational Details',
                body: ListView.builder(
                  itemCount: user.educations.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return DetailCardTile(
                        title: user.educations[index].areaOfStudy,
                        rangeDate: "${user.educations[index].institution} "
                            "${DateFormat.yMMMM().format(user.educations[index].dateAttended.start)} - "
                            "${DateFormat.yMMMM().format(user.educations[index].dateAttended.end)}",
                        description: user.educations[index].description);
                  },
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
        ResponsiveRowColumnItem(
          rowFlex: 2,
          child: Column(
            children: [
              if (ResponsiveWrapper.of(context).isSmallerThan(TABLET))
                const SizedBox(height: 8),
              CardTile(
                title: 'LANGUAGE',
                body: ListView.builder(
                  shrinkWrap: true,
                  itemCount: user.languages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        const SizedBox(height: 8),
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: Text(user.languages[index].language),
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          color: Theme.of(context).colorScheme.secondary,
                          value:
                              langLevel(user.languages[index].proficiencyLevel),
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer
                              .withOpacity(0.15),
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              CardTile(
                title: 'ABOUT ME',
                body: Column(
                  children: [
                    const SizedBox(height: 8),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Opacity(
                        opacity: 0.6,
                        child: Text(
                          'Gender',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        user.gender!,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Opacity(
                        opacity: 0.6,
                        child: Text(
                          'Experience',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        '5 Year',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Opacity(
                        opacity: 0.6,
                        child: Text(
                          'Location',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${user.address!.region}/${user.address!.city}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              CardTile(
                title: 'Technical Skills',
                body: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        for (int i = 0; i < user.skills.length; i++)
                          SkillTile(skill: user.skills[i]),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CardTile(
                title: 'Social Links',
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: user.socialLinks.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Text(
                        user.socialLinks[index].link,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      );
                    },
                    // children: [
                    // const Text(
                    //   "http://www.facebook.com/john...",
                    //   maxLines: 1,
                    //   overflow: TextOverflow.ellipsis,
                    //   softWrap: false,
                    // ),
                    // ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CardTile(
                title: 'Profile Link',
                body: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: TextFormField(
                    initialValue:
                        'https://www.cloudwork.com/freelancer/daren/12454687',
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.copy))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RatingTile extends StatelessWidget {
  const RatingTile({
    Key? key,
    required this.rating,
    required this.title,
  }) : super(key: key);

  final String title;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.7)),
              ),
            ),
          ),
          const SizedBox(width: 10),
          RatingBar(rating: rating),
          Container(
            decoration: const BoxDecoration(
                color: Color(0xFFFEBE42),
                borderRadius: BorderRadius.all(Radius.circular(6))),
            width: 28,
            height: 21,
            child: Center(
                child: Text(
              rating.toString(),
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
            )),
          ),
        ],
      ),
    );
  }
}
