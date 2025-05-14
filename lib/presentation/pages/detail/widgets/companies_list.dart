import 'package:flutter/material.dart';

import '../../../../domain/entity/movie_detail.dart';
import '../../../widgets/app_cached_image.dart';
import '../../../widgets/custom_shimmer.dart';

class CompaniesList extends StatelessWidget {
  final bool isLoading;
  final MovieDetail? detail;

  const CompaniesList({required this.isLoading, this.detail, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child:
          isLoading
              ? CustomShimmer(width: double.infinity, height: 70, radius: 12)
              : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: detail?.productionCompanyLogos.length ?? 0,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: AppCachedImage(
                        imageUrl: detail!.productionCompanyLogos[index],
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
