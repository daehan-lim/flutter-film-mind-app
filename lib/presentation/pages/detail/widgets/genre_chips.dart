import 'package:flutter/material.dart';

import '../../../../domain/entity/movie_detail.dart';
import '../../../widgets/custom_shimmer.dart';

class GenreChips extends StatelessWidget {
  final bool isLoading;
  final MovieDetail? detail;

  const GenreChips({super.key, required this.isLoading, this.detail});

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Row(
        children: List.generate(
          4,
              (_) => Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CustomShimmer(width: 60, height: 28, radius: 20),
          ),
        ),
      );
    }
    return Wrap(
      spacing: 8,
      children:
      detail!.genres.map((genre) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white38, width: 2.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            genre,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              // color: Colors.lightBlueAccent.withValues(alpha: 0.99),
            ),
          ),
        );
      }).toList(),
    );
  }
}
