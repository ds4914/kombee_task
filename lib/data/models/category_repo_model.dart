import 'dart:convert';

CategoryRepoModel categoryRepoModelFromJson(String str) => CategoryRepoModel.fromJson(json.decode(str));

String categoryRepoModelToJson(CategoryRepoModel data) => json.encode(data.toJson());

class CategoryRepoModel {
  final List<Category>? categories;
  final String? bannerImage;
  final String? status;
  final String? message;

  CategoryRepoModel({
    this.categories,
    this.bannerImage,
    this.status,
    this.message,
  });

  factory CategoryRepoModel.fromJson(Map<String, dynamic> json) => CategoryRepoModel(
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
    bannerImage: json["banner_image"],
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "banner_image": bannerImage,
    "status": status,
    "message": message,
  };
}

class Category {
  final String? categoryId;
  final String? categoryName;
  final String? parentId;
  final List<Category>? child;

  Category({
    this.categoryId,
    this.categoryName,
    this.parentId,
    this.child,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    parentId: json["parent_id"],
    child: json["child"] == null ? [] : List<Category>.from(json["child"]!.map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_name": categoryName,
    "parent_id": parentId,
    "child": child == null ? [] : List<dynamic>.from(child!.map((x) => x.toJson())),
  };
}
