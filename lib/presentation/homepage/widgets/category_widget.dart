import 'package:flutter/material.dart';
import 'package:kombee_task/data/models/middle_repo_model.dart';
import 'package:kombee_task/core/utils/helpers/common_functions.dart';

class _CategoryItem extends StatelessWidget {
  final ShopBy data;
  final double imageHeight;
  final double itemWidth;

  const _CategoryItem({
    required this.data,
    required this.imageHeight,
    required this.itemWidth,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = data.image ?? '';

    return Container(
      width: itemWidth,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      decoration: BoxDecoration(
        color: hexToColor(data.tintColor ?? "#ffffff"),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
            child:
                imageUrl.isNotEmpty
                    ? Image.network(
                      imageUrl,
                      width: itemWidth,
                      height: imageHeight,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (_, __, ___) => SizedBox(
                            height: imageHeight,
                            width: itemWidth,
                            child: const Icon(Icons.image_not_supported),
                          ),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return SizedBox(
                          height: imageHeight,
                          width: itemWidth,
                          child: const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      },
                    )
                    : SizedBox(
                      height: imageHeight,
                      width: itemWidth,
                      child: const Icon(Icons.image_not_supported),
                    ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: hexToColor(data.tintColor ?? "#ffffff"),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(5),
              ),
            ),
            child: Text(
              data.name ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class HorizontalCategoryList extends StatelessWidget {
  final String title;
  final List<ShopBy> categoryList;
  final double height;
  final double imageHeight;
  final double itemWidth;

  const HorizontalCategoryList({
    super.key,
    required this.title,
    required this.categoryList,
    this.height = 180,
    this.imageHeight = 125,
    this.itemWidth = 125,
  });

  @override
  Widget build(BuildContext context) {
    if (categoryList.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: height,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryList.length,
            itemBuilder: (context, index) {
              return _CategoryItem(
                data: categoryList[index],
                imageHeight: imageHeight,
                itemWidth: itemWidth,
              );
            },
          ),
        ),
      ],
    );
  }
}
