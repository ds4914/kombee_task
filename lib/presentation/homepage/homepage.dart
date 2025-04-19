import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:kombee_task/core/network/dio_client.dart';
import 'package:kombee_task/core/utils/helpers/api_status.dart';
import 'package:kombee_task/data/repositories/homepage_repo/home_repo.dart';
import 'package:kombee_task/logic/cubits/homepage/homepage_cubit.dart';
import 'package:kombee_task/logic/cubits/homepage/homepage_state.dart';
import 'package:kombee_task/presentation/category_page/category_page.dart';
import 'package:kombee_task/presentation/homepage/widgets/category_widget.dart';
import 'package:kombee_task/presentation/homepage/widgets/design_occasion_widget.dart';
import 'package:kombee_task/presentation/homepage/widgets/fabric_material_widget.dart';
import 'package:kombee_task/presentation/homepage/widgets/header_container.dart';
import 'package:kombee_task/presentation/homepage/widgets/slider_widget.dart';
import 'package:collection/collection.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  HomepageCubit cubit = HomepageCubit(repo: HomeRepo(DioClient()));

  @override
  void initState() {
    cubit.fetchTopItems();
    cubit.fetchMiddleItems();
    cubit.fetchBottomItems();
    super.initState();
  }

  int _currentSliderIndex = 0;
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: _currentTabIndex == 1 ? 60 : 0,
        leading:
            _currentTabIndex == 1
                ? Icon(Icons.arrow_back_ios_new_outlined)
                : SizedBox.shrink(),
        centerTitle: _currentTabIndex == 1 ? true : false,
        title:
            _currentTabIndex == 1
                ? Text("Category")
                : SizedBox(
                  width: 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [Text("Ⓡ", style: TextStyle(fontSize: 10))],
                      ),
                      Text.rich(
                        TextSpan(
                          text: "FAB",
                          style: TextStyle(
                            color: Colors.amberAccent.shade400,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: "CURATE",
                              style: TextStyle(
                                color: Colors.amberAccent.shade400,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 3,
                            width: 3,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.amberAccent.shade400,
                            ),
                          ),
                          Text(
                            " CURATE YOUR OWN FABRIC ",
                            style: TextStyle(
                              fontSize: 8,
                              color: Colors.amberAccent.shade400,
                            ),
                          ),
                          Container(
                            height: 3,
                            width: 3,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.amberAccent.shade400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        actions: [
          Icon(Icons.search),
          Badge(label: Text("1"), child: Icon(Icons.shopping_bag_outlined)),
          Gap(10),
        ],
      ),
      body:
          _currentTabIndex == 0
              ? BlocBuilder<HomepageCubit, HomepageState>(
                bloc: cubit,
                builder: (context, state) {
                  final topRepoModel = state.topRepoModel;
                  final selectedIndex = state.selectedIndex ?? 0;
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state.topApiStatus == ApiStatus.loading)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 8,
                            ),
                            child: SizedBox(
                              height: 140,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: 4,
                                separatorBuilder:
                                    (_, __) => const SizedBox(width: 10),
                                itemBuilder:
                                    (_, __) => const ShimmerBox(
                                      height: 120,
                                      width: 100,
                                    ),
                              ),
                            ),
                          )
                        else if (topRepoModel != null) ...[
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: SizedBox(
                              height: 140,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children:
                                    topRepoModel.mainStickyMenu
                                        .mapIndexed(
                                          (index, data) => GestureDetector(
                                            onTap: () {
                                              cubit.updateSelectedIndex(index);
                                            },
                                            child: HeaderContainer(data: data),
                                          ),
                                        )
                                        .toList(),
                              ),
                            ),
                          ),
                          if (topRepoModel.mainStickyMenu.isNotEmpty &&
                              topRepoModel
                                  .mainStickyMenu[selectedIndex]
                                  .sliderImages
                                  .isNotEmpty)
                            SizedBox(
                              height: 175,
                              child: CarouselSlider.builder(
                                itemCount:
                                    topRepoModel
                                        .mainStickyMenu[selectedIndex]
                                        .sliderImages
                                        .length,
                                itemBuilder: (context, index, realIndex) {
                                  final item =
                                      topRepoModel
                                          .mainStickyMenu[selectedIndex]
                                          .sliderImages[index];
                                  return SliderWidget(data: item);
                                },
                                options: CarouselOptions(
                                  height: 175,
                                  enlargeCenterPage: true,
                                  viewportFraction: 0.75,
                                  enableInfiniteScroll: true,
                                  autoPlay: false,
                                ),
                              ),
                            ),
                          const Gap(10),
                        ],

                        if (state.middleApiStatus == ApiStatus.loading)
                          Column(
                            children: [
                              const ShimmerBox(height: 18, width: 200),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 150,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  separatorBuilder:
                                      (_, __) => const SizedBox(width: 10),
                                  itemBuilder:
                                      (_, __) => const ShimmerBox(
                                        height: 150,
                                        width: 120,
                                      ),
                                ),
                              ),
                            ],
                          )
                        else if (state
                            .middleRepoModel!
                            .shopByCategory!
                            .isNotEmpty) ...[
                          HorizontalCategoryList(
                            title: "Shop By Category",
                            categoryList:
                                state.middleRepoModel!.shopByCategory!,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              "Shop By Fabric Material",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Gap(10),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: SizedBox(
                              height: 150,
                              child: ListView.separated(
                                separatorBuilder: (context, index) => Gap(10),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    state.middleRepoModel!.shopByFabric!.length,
                                itemBuilder:
                                    (context, index) => FabricMaterialWidget(
                                      data:
                                          state
                                              .middleRepoModel!
                                              .shopByFabric![index],
                                    ),
                              ),
                            ),
                          ),
                          Gap(10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              "Unstitched",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Gap(10),
                          SizedBox(
                            height: 300,
                            child: CarouselSlider.builder(
                              itemCount:
                                  state.middleRepoModel!.unstitched!.length,
                              itemBuilder: (context, index, realIndex) {
                                final item =
                                    state.middleRepoModel!.unstitched![index];
                                return UnstitchedSliderWidget(data: item);
                              },
                              options: CarouselOptions(
                                height: 300,
                                autoPlay: false,
                                viewportFraction: 0.6,
                                enlargeCenterPage: true,
                                enlargeStrategy:
                                    CenterPageEnlargeStrategy.scale,
                                enableInfiniteScroll: true,
                                scrollPhysics: const BouncingScrollPhysics(),
                              ),
                            ),
                          ),
                          Gap(10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              "Boutique Collection",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Gap(10),
                          SizedBox(
                            height: 400,
                            child: CarouselSlider.builder(
                              itemCount:
                                  state
                                      .middleRepoModel!
                                      .boutiqueCollection!
                                      .length,
                              itemBuilder: (context, index, realIndex) {
                                final item =
                                    state
                                        .middleRepoModel!
                                        .boutiqueCollection![index];
                                return BoutiqueSliderWidget(data: item);
                              },
                              options: CarouselOptions(
                                height: 400,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _currentSliderIndex = index;
                                  });
                                },
                                autoPlay: false,
                                viewportFraction: 1,
                                enlargeCenterPage: true,
                                enlargeStrategy:
                                    CenterPageEnlargeStrategy.scale,
                                enableInfiniteScroll: true,
                                scrollPhysics: const BouncingScrollPhysics(),
                              ),
                            ),
                          ),
                          Gap(10),
                          Center(
                            child: AnimatedSmoothIndicator(
                              activeIndex: _currentSliderIndex,
                              count:
                                  state
                                      .middleRepoModel!
                                      .boutiqueCollection!
                                      .length,
                              effect: const ExpandingDotsEffect(
                                dotHeight: 6,
                                dotWidth: 6,
                                spacing: 6,
                                activeDotColor: Colors.black,
                                dotColor: Colors.grey,
                                expansionFactor: 1.5,
                              ),
                            ),
                          ),
                          Gap(10),
                        ],
                        if (state.bottomApiStatus == ApiStatus.loading)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 120 / 120,
                                  ),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 6,
                              itemBuilder:
                                  (_, __) =>
                                      const ShimmerBox(height: 120, width: 120),
                            ),
                          )
                        else if (state
                            .bottomRepoModel!
                            .rangeOfPattern!
                            .isNotEmpty) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              "Range Of Pattern",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Gap(10),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: SizedBox(
                              height: 150,
                              child: ListView.separated(
                                separatorBuilder: (context, index) => Gap(10),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    state
                                        .bottomRepoModel!
                                        .rangeOfPattern!
                                        .length,
                                itemBuilder:
                                    (context, index) => RangePatternWidget(
                                      data:
                                          state
                                              .bottomRepoModel!
                                              .rangeOfPattern![index],
                                    ),
                              ),
                            ),
                          ),
                          Gap(10),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text(
                              "Design As Per Occasion",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Gap(10),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 120 / 120,
                                  ),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder:
                                  (context, index) => DesignOccasionWidget(
                                    data:
                                        state
                                            .bottomRepoModel!
                                            .designOccasion![index],
                                  ),
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  state.bottomRepoModel!.designOccasion!.length,
                            ),
                          ),
                          Gap(10),
                        ],
                      ],
                    ),
                  );
                },
              )
              : _currentTabIndex == 1
              ? CategoryPage()
              : _currentTabIndex == 2
              ? const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.brush_outlined), Text("Curate")],
                ),
              )
              : _currentTabIndex == 3
              ? const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.local_offer_outlined), Text("Sale")],
                ),
              )
              : _currentTabIndex == 4
              ? const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.more_horiz), Text("More")],
                ),
              )
              : SizedBox.shrink(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTabIndex,
        onTap: (index) {
          setState(() {
            _currentTabIndex = index;
          });
          print(_currentTabIndex);
        },
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.brush_outlined),
            label: 'Curate',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer_outlined),
            label: 'Sale',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }
}

class ShimmerBox extends StatelessWidget {
  final double height;
  final double width;
  final BorderRadius? borderRadius;

  const ShimmerBox({
    super.key,
    required this.height,
    required this.width,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
      ),
    );
  }
}
