part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final RequestStatusEnum requestStatusEnum;
  final UserModel? userModel;
  final String? errorMessage;

  const AuthState({
    this.requestStatusEnum = RequestStatusEnum.initial,
    this.userModel,
    this.errorMessage,
  });

  AuthState copyWith({
    RequestStatusEnum? requestStatusEnum,
    UserModel? userModel,
    String? errorMessage,
  }) {
    return AuthState(
      requestStatusEnum: requestStatusEnum ?? this.requestStatusEnum,
      userModel: userModel ?? this.userModel,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [requestStatusEnum, userModel, errorMessage];

}
