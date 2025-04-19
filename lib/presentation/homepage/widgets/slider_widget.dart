import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kombee_task/data/models/middle_repo_model.dart';
import 'package:kombee_task/data/models/top_repo_model.dart';

class SliderWidget extends StatelessWidget {
  final SliderImage data;

  const SliderWidget({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.network(
                data.image,
                height: 120,
                width: double.maxFinite - 50,
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.amberAccent.shade100,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                width: double.maxFinite,
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: 175,
            margin: EdgeInsets.only(top: 40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: Text(data.title, textAlign: TextAlign.center),
          ),
        ),
      ],
    );
  }
}

class UnstitchedSliderWidget extends StatelessWidget {
  final Unstitched data;

  const UnstitchedSliderWidget({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          data.image ?? '',
          height: 300,
          width: double.maxFinite,
          fit: BoxFit.cover,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(top: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5,
                  ),
                  child: Text(
                    data.description?.toUpperCase() ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                  ),
                  child: Text(
                    data.name ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red.shade400,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class BoutiqueSliderWidget extends StatelessWidget {
  final BoutiqueCollection data;

  const BoutiqueSliderWidget({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          data.bannerImage ?? '',
          height: 400,
          width: double.maxFinite,
          fit: BoxFit.fitHeight,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
            margin: EdgeInsets.only(top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  data.name ?? '',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
                Gap(10),
                Text(
                  'EXPLORE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                Gap(10),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
