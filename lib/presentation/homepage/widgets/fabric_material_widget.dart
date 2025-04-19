import 'package:flutter/material.dart';
import 'package:kombee_task/data/models/bottom_repo_model.dart';
import 'package:kombee_task/data/models/middle_repo_model.dart';

class FabricMaterialWidget extends StatelessWidget {
  final ShopBy data;

  const FabricMaterialWidget({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    final imageUrl = data.image ?? '';

    return Stack(
      alignment: Alignment.center,
      children: [
        ClipOval(
          child:
              imageUrl.isNotEmpty
                  ? Image.network(
                    imageUrl,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (_, __, ___) => SizedBox(
                          height: 150,
                          width: 150,
                          child: const Icon(Icons.image_not_supported),
                        ),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return SizedBox(
                        height: 150,
                        width: 150,
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    },
                  )
                  : SizedBox(
                    height: 150,
                    width: 150,
                    child: const Icon(Icons.image_not_supported),
                  ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 70.0),
            child: Text(
              data.name?.toUpperCase() ?? '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RangePatternWidget extends StatelessWidget {
  final RangeOfPattern data;

  const RangePatternWidget({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    final imageUrl = data.image ?? '';
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipOval(
          child:
              imageUrl.isNotEmpty
                  ? Image.network(
                    imageUrl,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (_, __, ___) => SizedBox(
                          height: 150,
                          width: 150,
                          child: const Icon(Icons.image_not_supported),
                        ),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return SizedBox(
                        height: 150,
                        width: 150,
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    },
                  )
                  : SizedBox(
                    height: 150,
                    width: 150,
                    child: const Icon(Icons.image_not_supported),
                  ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 70.0),
            child: SizedBox(
              width: 120,
              child: Text(
                data.name?.toUpperCase() ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
