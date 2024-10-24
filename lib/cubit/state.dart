// abstract class HomeState {}

// class InitState extends HomeState {}

// class GetSourcesLoadingState extends HomeState {}

// class GetSourcesSuccessState extends HomeState {}

// class GetSourcesErrorState extends HomeState {
//   String error;
//   GetSourcesErrorState(this.error);
// }

// class GetArticlesLoadingState extends HomeState {}

// class GetArticlesSuccessState extends HomeState {}

// class GetArticlesErrorState extends HomeState {
//   String error;
//   GetArticlesErrorState(this.error);
// }

// class OnTabSelected extends HomeState {}

// class OnCategoryClick extends HomeState {}

// class OnToggleTab extends HomeState {}

// class StartSearchTab extends HomeState {}

// class CloseSearchTab extends HomeState {}

// class CheckSearchTab extends HomeState {}

// class ClearSearchTab extends HomeState {}

// lib/cubit/state.dart
abstract class HomeState {}

class InitState extends HomeState {}

class GetSourcesLoadingState extends HomeState {}

class GetSourcesSuccessState extends HomeState {}

class GetSourcesErrorState extends HomeState {
  final String error;
  GetSourcesErrorState(this.error);
}

class GetArticlesLoadingState extends HomeState {}

class GetArticlesSuccessState extends HomeState {}

class GetArticlesErrorState extends HomeState {
  final String error;
  GetArticlesErrorState(this.error);
}

class OnTabSelected extends HomeState {}

class StartSearchTab extends HomeState {}

class CloseSearchTab extends HomeState {}

class CheckSearchTab extends HomeState {}

class ClearSearchTab extends HomeState {}

class OnCategoryClick extends HomeState {}

class OnToggleTab extends HomeState {}
