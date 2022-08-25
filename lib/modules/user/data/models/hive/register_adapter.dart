import 'package:hive_flutter/hive_flutter.dart';
import '../../../../../_shared/data/models/hive/common_model.dart';
import 'basic_local_user.dart';
import 'detail_local_user_model.dart';

class UserAdapter {
  static void registerUserAdapter() {
    Hive.registerAdapter<OtherExperienceModel>(OtherExperienceModelAdapter());
    Hive.registerAdapter<EmploymentModel>(EmploymentModelAdapter());
    Hive.registerAdapter<EducationModel>(EducationModelAdapter());
    Hive.registerAdapter<LanguageModel>(LanguageModelAdapter());
    Hive.registerAdapter<SocialLinkModel>(SocialLinkModelAdapter());
    Hive.registerAdapter<RatingModel>(RatingModelAdapter());
    Hive.registerAdapter<RangeDateModel>(RangeDateModelAdapter());
    Hive.registerAdapter<AddressModel>(AddressModelAdapter());
    Hive.registerAdapter<MainServiceLocalModel>(MainServiceLocalModelAdapter());
    Hive.registerAdapter<BasicLocalUser>(BasicLocalUserAdapter());
    Hive.registerAdapter<DetailUserLocalModel>(DetailUserLocalModelAdapter());
  }
}
