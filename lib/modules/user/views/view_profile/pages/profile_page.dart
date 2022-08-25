import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../_core/di/get_It.dart';
import '../bloc/detail_user_bloc.dart';
import '../widgets/profile_display.dart';

class ViewProfilePage extends StatelessWidget {
  const ViewProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: buildBody());
  }

  BlocProvider<DetailUserBloc> buildBody() {
    return BlocProvider(
      create: (context) => container<DetailUserBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              BlocBuilder<DetailUserBloc, DetailUserState>(
                builder: ((context, state) {
                  if (state is DetailUserInitial ||
                      state is DetailUserLoading) {
                    var _profileBloc = BlocProvider.of<DetailUserBloc>(context);
                    _profileBloc.add(GetDetailUserEvent());
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  } else if (state is DetailUserLoaded) {
                    return ProfileDisplay(user: state.user);
                  } else if (state is ErrorLoadingDetailUser) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      child: const Center(
                        child: SingleChildScrollView(
                          child: Text(
                            "message",
                            style: TextStyle(fontSize: 25),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  }

                  return Container();
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

}

