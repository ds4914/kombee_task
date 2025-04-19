import 'package:flutter/material.dart';
import 'package:kombee_task/data/models/top_repo_model.dart';

class HeaderContainer extends StatelessWidget {
  final MainStickyMenu data;

  const HeaderContainer({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 150,
      margin: const EdgeInsets.only(right: 5),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            // optional rounding
            child: Image.network(
              data.image,
              height: 80,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              border: Border.all(color: Colors.grey.shade500),
            ),
            child: Center(
              child: Text(
                data.title,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
