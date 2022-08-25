part of 'update_profile_bloc.dart';

abstract class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent();

  @override
  List<Object> get props => [];
}

class AddExpertiseEvent extends UpdateProfileEvent {
  final String expertise;

  const AddExpertiseEvent(this.expertise);

  @override
  List<Object> get props => [expertise];
}

class AddExperienceEvent extends UpdateProfileEvent {
  final Employment employment;

  const AddExperienceEvent(this.employment);

  @override
  List<Object> get props => [employment];
}

class RemoveExperienceEvent extends UpdateProfileEvent {
  final String employmentId;

  const RemoveExperienceEvent(this.employmentId);

  @override
  List<Object> get props => [employmentId];
}

class SaveEducationEvent extends UpdateProfileEvent {
  final Education education;

  const SaveEducationEvent(this.education);

  @override
  List<Object> get props => [education];
}

class RemoveEducationEvent extends UpdateProfileEvent {
  final String educationId;

  const RemoveEducationEvent(this.educationId);

  @override
  List<Object> get props => [educationId];
}

class SaveLanguagesEvent extends UpdateProfileEvent {
  final List<Language> languages;

  const SaveLanguagesEvent(this.languages);

  @override
  List<Object> get props => [languages];
}

class SaveSkillsEvent extends UpdateProfileEvent {
  final List<String> skills;

  const SaveSkillsEvent(this.skills);

  @override
  List<Object> get props => [skills];
}

class SaveOverviewEvent extends UpdateProfileEvent {
  final String overview;

  const SaveOverviewEvent(this.overview);

  @override
  List<Object> get props => [overview];
}

class SaveMainServiceEvent extends UpdateProfileEvent {
  final String category;
  final String subcategory;

  const SaveMainServiceEvent(this.category, this.subcategory);

  @override
  List<Object> get props => [category, subcategory];
}

class UploadProfilePictureEvent extends UpdateProfileEvent {
  // ignore: prefer_typing_uninitialized_variables
  final file;

  const UploadProfilePictureEvent(this.file);

  @override
  List<Object> get props => [file];
}

class SaveBasicInfoEvent extends UpdateProfileEvent {
  final String available;
  final String gender;
  final Address address;

  const SaveBasicInfoEvent(this.gender, this.available, this.address);

  @override
  List<Object> get props => [gender, available, address];
}

class ChangeAvailabilityEvent extends UpdateProfileEvent {
  final String available;

  const ChangeAvailabilityEvent(this.available);

  @override
  List<Object> get props => [available];
}

class SaveOtherExperienceEvent extends UpdateProfileEvent {
  final OtherExperience otherExperience;

  const SaveOtherExperienceEvent(this.otherExperience);

  @override
  List<Object> get props => [otherExperience];
}

class RemoveOtherExperienceEvent extends UpdateProfileEvent {
  final String id;

  const RemoveOtherExperienceEvent(this.id);

  @override
  List<Object> get props => [id];
}

class ChangePasswordEvent extends UpdateProfileEvent {
  final String oldPassword;
  final String newPassword;

  const ChangePasswordEvent(this.oldPassword, this.newPassword);

  @override
  List<Object> get props => [oldPassword, newPassword];
}

class DeleteAccountEvent extends UpdateProfileEvent {
  final String reason;
  final String password;

  const DeleteAccountEvent(this.reason, this.password);

  @override
  List<Object> get props => [reason, password];
}
