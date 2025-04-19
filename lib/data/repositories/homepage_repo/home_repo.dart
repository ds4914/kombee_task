import 'package:kombee_task/core/constants/network_urls.dart';
import 'package:kombee_task/core/network/dio_client.dart';
import 'package:kombee_task/data/models/bottom_repo_model.dart';
import 'package:kombee_task/data/models/middle_repo_model.dart';
import 'package:kombee_task/data/models/top_repo_model.dart';

class HomeRepo {
  final DioClient dioClient;

  HomeRepo(this.dioClient);

  Future<TopRepoModel> fetchTopItems() async {
    final response = await dioClient.dio.get(NetworkUrls.topRepo);
    return TopRepoModel.fromJson(response.data);
  }

  Future<MiddleRepoModel> fetchMiddleItems() async {
    final response = await dioClient.dio.get(NetworkUrls.middleRepo);
    return MiddleRepoModel.fromJson(response.data);
  }

  Future<BottomRepoModel> fetchBottomItems() async {
    final response = await dioClient.dio.get(NetworkUrls.bottomRepo);
    return BottomRepoModel.fromJson(response.data);
  }
}
