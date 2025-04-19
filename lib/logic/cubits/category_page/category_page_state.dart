part of 'category_page_cubit.dart';

@immutable
class CategoryPageState extends Equatable {
  String? message;
  ApiStatus apiStatus;
  CategoryRepoModel? categoryRepoModel;

  CategoryPageState({
    this.message,
    this.apiStatus = ApiStatus.initial,
    this.categoryRepoModel,
  });

  CategoryPageState copyWith({
    String? message,
    ApiStatus? apiStatus,
    CategoryRepoModel? categoryRepoModel,
  }) {
    return CategoryPageState(
      apiStatus: apiStatus ?? this.apiStatus,
      message: message ?? this.message,
      categoryRepoModel: categoryRepoModel ?? this.categoryRepoModel,
    );
  }

  @override
  List<Object?> get props => [message, apiStatus, categoryRepoModel];
}
