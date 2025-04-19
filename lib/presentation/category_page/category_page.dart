import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:kombee_task/core/network/dio_client.dart';
import 'package:kombee_task/core/utils/helpers/api_status.dart';
import 'package:kombee_task/data/models/category_repo_model.dart';
import 'package:kombee_task/data/repositories/category_page_repo/category_repo.dart';
import 'package:kombee_task/logic/cubits/category_page/category_page_cubit.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  CategoryPageCubit cubit = CategoryPageCubit(
    repo: CategoryRepo(dioClient: DioClient()),
  );

  @override
  void initState() {
    super.initState();
    cubit.getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryPageCubit, CategoryPageState>(
      bloc: cubit,
      builder: (context, state) {
        if (state.apiStatus == ApiStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        var categoryList = state.categoryRepoModel!.categories!;
        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => Gap(2),
                itemCount: categoryList.length,
                itemBuilder: (context, index) {
                  return CategoryContainer(
                    data: categoryList[index],
                    banner: state.categoryRepoModel!.bannerImage!,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class CategoryContainer extends StatelessWidget {
  final Category data;
  final String banner;

  const CategoryContainer({
    required this.banner,
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 0,
          child: Image.network(
            banner,
            height: 100,
            width: 175,
            fit: BoxFit.fitHeight,
          ),
        ),
        Positioned(
          right: 10,
          top: 45,
          child: Icon(Icons.keyboard_arrow_down_outlined, color: Colors.white),
        ),
        ClipPath(
          clipper: RightSideCurveClipper(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.12,
            width: MediaQuery.of(context).size.width * 0.65,
            color: Colors.blueGrey.shade200,
            padding: const EdgeInsets.only(left: 12.0),
            alignment: Alignment.centerLeft,
            child: Text(
              data.categoryName!,
              style: TextStyle(color: Colors.black87, fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}

class RightSideCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double curveDepth = size.height / 4;

    Path path = Path();
    path.moveTo(0, 0);

    path.lineTo(size.width - curveDepth, 0);

    path.quadraticBezierTo(
      size.width,
      size.height / 2,
      size.width - curveDepth,
      size.height,
    );

    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
