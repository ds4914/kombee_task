import 'package:kombee_task/core/constants/network_urls.dart';
import 'package:kombee_task/core/network/dio_client.dart';
import 'package:kombee_task/data/models/category_repo_model.dart';

class CategoryRepo{
  final DioClient dioClient;
  CategoryRepo({required this.dioClient});

  Future<CategoryRepoModel> getCategory()async{
    final response = await dioClient.dio.get(NetworkUrls.categoryRepo);
    return CategoryRepoModel.fromJson(response.data);
  }
}