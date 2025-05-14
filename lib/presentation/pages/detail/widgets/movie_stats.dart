import 'package:film_mind/core/extensions/number_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entity/movie_detail.dart';
import '../../../widgets/custom_shimmer.dart';

class MovieStats extends StatelessWidget {
  final bool isLoading;
  final MovieDetail? detail;

  const MovieStats({super.key, required this.isLoading, this.detail});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children:
            isLoading
                ? List.generate(
                  5,
                  (index) => Container(
                    width: 130,
                    margin: const EdgeInsets.only(right: 12),
                    child: CustomShimmer(width: 130, height: 100, radius: 12),
                  ),
                )
                : [
                  _buildStatItem(
                    '평점',
                    detail!.voteAverage?.formatDecimal(decimalDigits: 2) ?? '',
                  ),
                  _buildStatItem(
                    '평점투표수',
                    detail!.voteCount?.formatDecimal(decimalDigits: 0) ?? '',
                  ),
                  _buildStatItem(
                    '인기점수',
                    detail!.popularity?.formatDecimal(decimalDigits: 2) ?? '',
                  ),
                  _buildStatItem('예산', detail!.budget),
                  _buildStatItem('수익', detail!.revenue),
                ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[700]!, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: TextStyle(fontSize: 14)),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
