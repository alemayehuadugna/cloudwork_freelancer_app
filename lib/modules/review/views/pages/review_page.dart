import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../../../../_core/di/get_It.dart';
import '../../../../_shared/interface/bloc/auth/auth_bloc.dart';
import '../../domain/entities/review.dart';
import '../bloc/list_review_bloc/list_review_bloc.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ListReviewBloc>(
      create: (context) => container(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Reviews"),
        ),
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height - 112,
              width: double.infinity,
              child: BlocBuilder<ListReviewBloc, ListReviewState>(
                builder: (context, state) {
                  if (state is ListReviewInitial) {
                    BlocProvider.of<ListReviewBloc>(context).add(
                        QueryReviewListEvent(filter: {
                      "reviewedId":
                          authState is Authenticated ? authState.user.id : null
                    }));
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ListReviewLoaded) {
                    var reviews = state.reviews;
                    return ListView.builder(
                      itemCount: reviews.data!.length,
                      itemBuilder: (context, index) {
                        return ReviewTile(
                          review: reviews.data![index],
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class ReviewTile extends StatelessWidget {
  const ReviewTile({
    Key? key,
    required this.review,
  }) : super(key: key);

  final Review review;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Card(
        elevation: null,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                review.title,
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 3),
              Text(review.comment),
              const SizedBox(height: 20),
              Row(children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Color(0xFFFEBE42),
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  width: 28,
                  height: 21,
                  child: Center(
                      child: Text(
                    "${review.rate}",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  )),
                ),
                RatingBar(rating: review.rate),
              ]),
              const SizedBox(width: 25),
              Text(
                DateFormat.yMMMMEEEEd().format(review.createdAt!),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RatingBar extends StatelessWidget {
  const RatingBar({Key? key, required this.rating}) : super(key: key);

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
      itemSize: 25.0,
      direction: Axis.horizontal,
    );
  }
}
