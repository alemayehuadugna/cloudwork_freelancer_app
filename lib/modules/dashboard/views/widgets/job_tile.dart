import 'package:CloudWork_Freelancer/modules/job/domain/entities/job.dart';
import 'package:CloudWork_Freelancer/modules/job/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class JobTile extends StatelessWidget {
  const JobTile({
    Key? key,
    required this.job,
  }) : super(key: key);

  final JobEntity job;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 400,
        // height: 430,
        child: Card(
          elevation: 1.5,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: job.clientId!.first.profilePicture ==
                                    'profile_image_url'
                                ? AssetImage("assets/images/logo-place.jpg") as ImageProvider
                                : NetworkImage(job.clientId!.first.profilePicture),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Text(
                      job.title,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      job.category,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.7),
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Posted on ${job.createdAt!.year - job.createdAt!.month - job.createdAt!.day}",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.7),
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      job.language!,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.7),
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      spacing: 5,
                      runSpacing: 5,
                      children: [
                        for (int i = 0; i < job.skills.length; i++)
                          Container(
                            width: 80,
                            height: 26,
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .chipTheme
                                  .backgroundColor!
                                  .withOpacity(0.6),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(2.0),
                              child:  Text(
                                job.skills[i],
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      job.budget.toString(),
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.65)),
                    ),
                    const SizedBox(height: 4),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Expiry",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground
                                          .withOpacity(0.65),
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              Text(
                                job.expiry == null ? "Not Specified" :
                                "${job.expiry!.split('::')[0]} Days Left",
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                          const VerticalDivider(width: 0.5),
                          Column(
                            children: [
                              Text(
                                "Proposals",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground
                                          .withOpacity(0.65),
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              Text(
                                job.proposals.toString(),
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                          const VerticalDivider(width: 0.5),
                          Column(
                            children: [
                              Text(
                                "Job Duration",
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              Text(
                                job.duration.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(color: Colors.green),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 3),
                  ],
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    minimumSize:
                        MaterialStateProperty.all(const Size.fromHeight(50))),
                onPressed: () {
                  // context.goNamed(jobDetailRouteName, params: {"id": id});
              context.goNamed(jobDetailRouteName, params: {"id": job.id});

                },
                child: const Text("Bid Now"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
