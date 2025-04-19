import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kombee_task/core/utils/helpers/api_status.dart';
import 'package:kombee_task/data/models/category_repo_model.dart';
import 'package:kombee_task/data/repositories/category_page_repo/category_repo.dart';
import 'package:meta/meta.dart';

part 'category_page_state.dart';

class CategoryPageCubit extends Cubit<CategoryPageState> {
  CategoryRepo repo;

  CategoryPageCubit({required this.repo}) : super(CategoryPageState());

  getCategory() async {
    emit(state.copyWith(apiStatus: ApiStatus.loading));
    try {
      var response = await repo.getCategory();
      if (response.status == "18") {
        emit(
          state.copyWith(
            apiStatus: ApiStatus.success,
            categoryRepoModel: response,
          ),
        );
      } else {
        emit(state.copyWith(apiStatus: ApiStatus.failed));
      }
    } on Exception catch (e) {
      print("Error in fetchCategory: $e");
    }
  }
}
