import 'package:flutter/material.dart';
import 'package:kombee_task/data/models/bottom_repo_model.dart';

class DesignOccasionWidget extends StatelessWidget {
  final DesignOccasion data;

  const DesignOccasionWidget({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(data.image!, fit: BoxFit.cover, height: 120, width: 120),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 35,
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data.subName ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.w500,fontSize: 10),
                    ),
                    Text(
                      data.cta ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.w500,fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
