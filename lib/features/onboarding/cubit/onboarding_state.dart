part of 'onboarding_cubit.dart';

class OnboardingState extends Equatable {
  final int currantIndex;

  final bool isLastPage;

  const OnboardingState({this.currantIndex = 0, this.isLastPage = false});
  OnboardingState copyWith({int? currantIndex, bool? isLastPage}) {
    return OnboardingState(
      currantIndex: currantIndex ?? this.currantIndex,
      isLastPage: isLastPage ?? this.isLastPage,
    );
  }

  @override
  List<Object?> get props => [currantIndex, isLastPage];
}
