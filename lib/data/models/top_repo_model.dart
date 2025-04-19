import 'dart:convert';

TopRepoModel topRepoModelFromJson(String str) =>
    TopRepoModel.fromJson(json.decode(str));

String topRepoModelToJson(TopRepoModel data) => json.encode(data.toJson());

class TopRepoModel {
  final List<MainStickyMenu> mainStickyMenu;
  final String status;
  final String message;

  TopRepoModel({
    required this.mainStickyMenu,
    required this.status,
    required this.message,
  });

  factory TopRepoModel.fromJson(Map<String, dynamic> json) => TopRepoModel(
    mainStickyMenu: json["main_sticky_menu"] == null
        ? []
        : List<MainStickyMenu>.from(
      json["main_sticky_menu"]
          .map((x) => MainStickyMenu.fromJson(x)),
    ),
    status: json["status"] ?? "",
    message: json["message"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "main_sticky_menu":
    List<dynamic>.from(mainStickyMenu.map((x) => x.toJson())),
    "status": status,
    "message": message,
  };
}

class MainStickyMenu {
  final String title;
  final String image;
  final String sortOrder;
  final List<SliderImage> sliderImages;

  MainStickyMenu({
    required this.title,
    required this.image,
    required this.sortOrder,
    required this.sliderImages,
  });

  factory MainStickyMenu.fromJson(Map<String, dynamic> json) => MainStickyMenu(
    title: json["title"] ?? "",
    image: json["image"] ?? "",
    sortOrder: json["sort_order"] ?? "",
    sliderImages: json["slider_images"] == null
        ? []
        : List<SliderImage>.from(
        json["slider_images"].map((x) => SliderImage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "image": image,
    "sort_order": sortOrder,
    "slider_images":
    List<dynamic>.from(sliderImages.map((x) => x.toJson())),
  };
}

class SliderImage {
  final String title;
  final String image;
  final String sortOrder;
  final String cta;

  SliderImage({
    required this.title,
    required this.image,
    required this.sortOrder,
    required this.cta,
  });

  factory SliderImage.fromJson(Map<String, dynamic> json) => SliderImage(
    title: json["title"] ?? "",
    image: json["image"] ?? "",
    sortOrder: json["sort_order"] ?? "",
    cta: json["cta"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "image": image,
    "sort_order": sortOrder,
    "cta": cta,
  };
}
