import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../_core/error/failures.dart';
import '../../../../../_shared/domain/entities/address.dart';
import '../../../domain/entities/detail_user.dart';
import '../../../domain/usecases/add_expertise.dart';
import '../../../domain/usecases/change_availability.dart';
import '../../../domain/usecases/change_password.dart';
import '../../../domain/usecases/delete_account.dart';
import '../../../domain/usecases/education/remove_education.dart';
import '../../../domain/usecases/education/save_education.dart';
import '../../../domain/usecases/employment/remove_employment.dart';
import '../../../domain/usecases/employment/save_employment.dart';
import '../../../domain/usecases/other_experience/remove_other_experience.dart';
import '../../../domain/usecases/other_experience/save_other_experience.dart';
import '../../../domain/usecases/save_basic_info.dart';
import '../../../domain/usecases/save_languages.dart';
import '../../../domain/usecases/save_main_service.dart';
import '../../../domain/usecases/save_overview.dart';
import '../../../domain/usecases/save_skills.dart';
import '../../../domain/usecases/upload_profile_picture.dart';

part 'update_profile_event.dart';
part 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final AddExpertiseUseCase _addExpertise;
  final SaveEmploymentUseCase _addEmployment;
  final RemoveEmploymentUseCase _removeEmployment;
  final SaveEducationUseCase _saveEducation;
  final RemoveEducationUseCase _removeEducation;
  final SaveLanguagesUseCase _saveLanguages;
  final SaveSkillsUseCase _saveSkills;
  final SaveOverviewUseCase _saveOverview;
  final SaveMainServiceUseCase _saveMainService;
  final UploadProfilePictureUseCase _uploadProfilePicture;
  final SaveBasicInfoUseCase _saveBasicInfo;
  final ChangeAvailabilityUseCase _changeAvailability;
  final SaveOtherExperienceUseCase _saveOtherExperience;
  final RemoveOtherExperienceUseCase _removeOtherExperience;
  final ChangePasswordUseCase _changePassword;
  final DeleteAccountUseCase _deleteAccount;
  UpdateProfileBloc({
    required AddExpertiseUseCase addExpertiseUseCase,
    required SaveEmploymentUseCase addEmploymentUseCase,
    required RemoveEmploymentUseCase removeEmploymentUseCase,
    required SaveEducationUseCase saveEducationUseCase,
    required RemoveEducationUseCase removeEducationUseCase,
    required SaveLanguagesUseCase saveLanguagesUseCase,
    required SaveSkillsUseCase saveSkillsUseCase,
    required SaveOverviewUseCase saveOverviewUseCase,
    required SaveMainServiceUseCase saveMainServiceUseCase,
    required UploadProfilePictureUseCase uploadProfilePictureUseCase,
    required SaveBasicInfoUseCase saveBasicInfoUseCase,
    required ChangeAvailabilityUseCase changeAvailabilityUseCase,
    required SaveOtherExperienceUseCase saveOtherExperienceUseCase,
    required RemoveOtherExperienceUseCase removeOtherExperienceUseCase,
    required ChangePasswordUseCase changePasswordUseCase,
    required DeleteAccountUseCase deleteAccountUseCase,
  })  : _addExpertise = addExpertiseUseCase,
        _addEmployment = addEmploymentUseCase,
        _removeEmployment = removeEmploymentUseCase,
        _saveEducation = saveEducationUseCase,
        _removeEducation = removeEducationUseCase,
        _saveLanguages = saveLanguagesUseCase,
        _saveSkills = saveSkillsUseCase,
        _saveOverview = saveOverviewUseCase,
        _saveMainService = saveMainServiceUseCase,
        _uploadProfilePicture = uploadProfilePictureUseCase,
        _saveBasicInfo = saveBasicInfoUseCase,
        _changeAvailability = changeAvailabilityUseCase,
        _saveOtherExperience = saveOtherExperienceUseCase,
        _removeOtherExperience = removeOtherExperienceUseCase,
        _changePassword = changePasswordUseCase,
        _deleteAccount = deleteAccountUseCase,
        super(UpdateProfileInitial()) {
    on<AddExpertiseEvent>(_addExpertiseEvent);
    on<AddExperienceEvent>(_addExperienceEvent);
    on<RemoveExperienceEvent>(_removeExperienceEvent);
    on<SaveEducationEvent>(_saveEducationEvent);
    on<RemoveEducationEvent>(_removeEducationEvent);
    on<SaveLanguagesEvent>(_saveLanguagesEvent);
    on<SaveSkillsEvent>(_saveSkillsEvent);
    on<SaveOverviewEvent>(_saveOverviewEvent);
    on<SaveMainServiceEvent>(_saveMainServiceEvent);
    on<UploadProfilePictureEvent>(_uploadProfilePictureEvent);
    on<SaveBasicInfoEvent>(_saveBasicInfoEvent);
    on<ChangeAvailabilityEvent>(_changeAvailabilityEvent);
    on<SaveOtherExperienceEvent>(_saveOtherExperienceEvent);
    on<RemoveOtherExperienceEvent>(_removeOtherExperienceEvent);
    on<ChangePasswordEvent>(_changePasswordEvent);
    on<DeleteAccountEvent>(_deleteAccountEvent);
  }

  void _deleteAccountEvent(
      DeleteAccountEvent event, Emitter<UpdateProfileState> emit) async {
    emit(UpdateProfileLoading());
    final result = await _deleteAccount(
      DeleteAccountParams(event.reason, event.password),
    );
    emit(result.fold(
      (error) {
        if (error is ServerFailure) {
          return ErrorUpdatingProfile(error.message);
        }
        return const ErrorUpdatingProfile(
            'Error Occurred while Deleting Your Account');
      },
      (_) => const UpdateProfileSuccess(),
    ));
  }

  void _changePasswordEvent(
      ChangePasswordEvent event, Emitter<UpdateProfileState> emit) async {
    emit(UpdateProfileLoading());
    final result = await _changePassword(
        ChangePasswordParams(event.oldPassword, event.newPassword));
    emit(result.fold(
      (error) {
        if (error is ServerFailure) {
          return ErrorUpdatingProfile(error.message);
        }
        return const ErrorUpdatingProfile('Error Changing Password');
      },
      (_) => const UpdateProfileSuccess(),
    ));
  }

  void _removeOtherExperienceEvent(
    RemoveOtherExperienceEvent event,
    Emitter<UpdateProfileState> emit,
  ) async {
    emit(UpdateProfileLoading());
    final result =
        await _removeOtherExperience(RemoveOtherExperienceParams(event.id));
    emit(result.fold(
      (error) {
        if (error is ServerFailure) {
          return ErrorUpdatingProfile(error.message);
        }
        return const ErrorUpdatingProfile('Error Removing Other Experience');
      },
      (_) => const UpdateProfileSuccess(),
    ));
  }

  void _saveOtherExperienceEvent(
    SaveOtherExperienceEvent event,
    Emitter<UpdateProfileState> emit,
  ) async {
    emit(UpdateProfileLoading());
    final result = await _saveOtherExperience(
        SaveOtherExperienceParams(event.otherExperience));
    emit(result.fold(
      (error) {
        if (error is ServerFailure) {
          return ErrorUpdatingProfile(error.message);
        }
        return const ErrorUpdatingProfile('Error Saving Other Experience');
      },
      (_) => const UpdateProfileSuccess(),
    ));
  }

  void _changeAvailabilityEvent(
    ChangeAvailabilityEvent event,
    Emitter<UpdateProfileState> emit,
  ) async {
    emit(UpdateProfileLoading());
    final result =
        await _changeAvailability(ChangeAvailabilityParams(event.available));
    emit(result.fold(
      (error) {
        if (error is ServerFailure) {
          return ErrorUpdatingProfile(error.message);
        }
        return const ErrorUpdatingProfile('Error Changing Availability');
      },
      (_) => const UpdateProfileSuccess(),
    ));
  }

  void _saveBasicInfoEvent(
    SaveBasicInfoEvent event,
    Emitter<UpdateProfileState> emit,
  ) async {
    emit(UpdateProfileLoading());
    final result = await _saveBasicInfo(SaveBasicInfoParams(
      event.address,
      event.available,
      event.gender,
    ));
    emit(result.fold(
      (error) {
        if (error is ServerFailure) {
          return ErrorUpdatingProfile(error.message);
        }
        return const ErrorUpdatingProfile(
            'Error Adding Basic Profile Information');
      },
      (_) => const UpdateProfileSuccess(),
    ));
  }

  void _uploadProfilePictureEvent(
    UploadProfilePictureEvent event,
    Emitter<UpdateProfileState> emit,
  ) async {
    emit(UpdateProfileLoading());
    final result =
        await _uploadProfilePicture(UploadProfilePictureParams(event.file));
    emit(result.fold(
      (error) {
        if (error is ServerFailure) {
          return ErrorUpdatingProfile(error.message);
        }
        return const ErrorUpdatingProfile('Error Uploading Profile Picture');
      },
      (profilePictureUrl) =>
          UpdateProfileSuccess<String>(data: profilePictureUrl),
    ));
  }

  void _addExpertiseEvent(
    AddExpertiseEvent event,
    Emitter<UpdateProfileState> emit,
  ) async {
    emit(UpdateProfileLoading());
    final result = await _addExpertise(AddExpertiseParams(event.expertise));
    emit(result.fold(
      (error) {
        if (error is ServerFailure) {
          return ErrorUpdatingProfile(error.message);
        }
        return const ErrorUpdatingProfile('Error Adding Expertise');
      },
      (_) => const UpdateProfileSuccess(),
    ));
  }

  void _addExperienceEvent(
    AddExperienceEvent event,
    Emitter<UpdateProfileState> emit,
  ) async {
    emit(UpdateProfileLoading());
    final result = await _addEmployment(SaveEmploymentParams(event.employment));
    emit(result.fold(
      (error) {
        if (error is ServerFailure) {
          return ErrorUpdatingProfile(error.message);
        }
        return const ErrorUpdatingProfile('Error Saving Experience');
      },
      (employment) => UpdateProfileSuccess<Employment>(data: employment),
    ));
  }

  void _removeExperienceEvent(
    RemoveExperienceEvent event,
    Emitter<UpdateProfileState> emit,
  ) async {
    emit(UpdateProfileLoading());
    final result = await _removeEmployment(RemoveEmploymentParams(
      event.employmentId,
    ));
    emit(result.fold(
      (error) {
        if (error is ServerFailure) {
          return ErrorUpdatingProfile(error.message);
        }
        return const ErrorUpdatingProfile('Error Removing Experience');
      },
      (_) => const UpdateProfileSuccess(),
    ));
  }

  void _saveEducationEvent(
    SaveEducationEvent event,
    Emitter<UpdateProfileState> emit,
  ) async {
    emit(UpdateProfileLoading());
    final result = await _saveEducation(SaveEducationParams(event.education));
    emit(result.fold(
      (error) {
        if (error is ServerFailure) {
          return ErrorUpdatingProfile(error.message);
        }
        return const ErrorUpdatingProfile('Error Saving Education');
      },
      (education) => UpdateProfileSuccess<Education>(data: education),
    ));
  }

  void _removeEducationEvent(
    RemoveEducationEvent event,
    Emitter<UpdateProfileState> emit,
  ) async {
    emit(UpdateProfileLoading());
    final result =
        await _removeEducation(RemoveEducationParams(event.educationId));
    emit(result.fold(
      (error) {
        if (error is ServerFailure) {
          return ErrorUpdatingProfile(error.message);
        }
        return const ErrorUpdatingProfile('Error Removing Education');
      },
      (removedId) => UpdateProfileSuccess<String>(data: removedId),
    ));
  }

  void _saveLanguagesEvent(
    SaveLanguagesEvent event,
    Emitter<UpdateProfileState> emit,
  ) async {
    emit(UpdateProfileLoading());
    final result = await _saveLanguages(SaveLanguagesParams(event.languages));
    emit(result.fold(
      (error) {
        if (error is ServerFailure) {
          return ErrorUpdatingProfile(error.message);
        }
        return const ErrorUpdatingProfile('Error Saving Languages');
      },
      (_) => const UpdateProfileSuccess(),
    ));
  }

  void _saveSkillsEvent(
    SaveSkillsEvent event,
    Emitter<UpdateProfileState> emit,
  ) async {
    emit(UpdateProfileLoading());
    final result = await _saveSkills(SaveSkillsParams(event.skills));
    emit(result.fold(
      (error) {
        if (error is ServerFailure) {
          return ErrorUpdatingProfile(error.message);
        }
        return const ErrorUpdatingProfile('Error Saving Skills');
      },
      (_) => const UpdateProfileSuccess(),
    ));
  }

  void _saveOverviewEvent(
    SaveOverviewEvent event,
    Emitter<UpdateProfileState> emit,
  ) async {
    emit(UpdateProfileLoading());
    final result = await _saveOverview(SaveOverviewParams(event.overview));
    emit(result.fold(
      (error) {
        if (error is ServerFailure) {
          return ErrorUpdatingProfile(error.message);
        }
        return const ErrorUpdatingProfile('Error Saving Overview');
      },
      (_) => const UpdateProfileSuccess(),
    ));
  }

  void _saveMainServiceEvent(
    SaveMainServiceEvent event,
    Emitter<UpdateProfileState> emit,
  ) async {
    emit(UpdateProfileLoading());
    final result = await _saveMainService(
      SaveMainServiceParams(event.category, event.subcategory),
    );
    emit(result.fold(
      (error) {
        if (error is ServerFailure) {
          return ErrorUpdatingProfile(error.message);
        }
        return const ErrorUpdatingProfile('Error Saving Your Main Service');
      },
      (_) {
        return const UpdateProfileSuccess();
      },
    ));
  }
}
