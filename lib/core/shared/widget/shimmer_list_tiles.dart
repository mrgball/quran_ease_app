import 'package:flutter/material.dart';
import 'package:quran_ease/core/config/extension.dart';
import 'package:quran_ease/core/shared/widget/shimmer_loading.dart';

class ShimmerListTiles extends StatelessWidget {
  final bool shrinkWrap;
  final int jumlahItem;
  final ScrollController? controller;

  const ShimmerListTiles({
    super.key,
    this.jumlahItem = 8,
    this.shrinkWrap = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return _buildListViewShimmer(context);
  }

  ListView _buildListViewShimmer(BuildContext context) {
    return ListView.separated(
      shrinkWrap: shrinkWrap,
      itemBuilder: (_, index) => ListTile(
        leading: ShimmerWidget.rounded(
          borderRadius: BorderRadius.circular(50),
          width: context.dp(50),
          height: context.dp(50),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(right: context.dw * 0.3),
          child: ShimmerWidget.rounded(
            borderRadius: BorderRadius.circular(16),
            width: context.dp(80),
            height: context.dp(12),
          ),
        ),
        title: ShimmerWidget.rounded(
          borderRadius: BorderRadius.circular(16),
          width: context.dp(120),
          height: context.dp(18),
        ),
        trailing: ShimmerWidget.rounded(
          borderRadius: BorderRadius.circular(16),
          width: context.dp(32),
          height: context.dp(32),
        ),
      ),
      separatorBuilder: (_, index) => const Divider(),
      itemCount: jumlahItem,
    );
  }
}
