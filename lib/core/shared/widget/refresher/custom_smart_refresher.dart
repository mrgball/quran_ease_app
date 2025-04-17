import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quran_ease/core/config/extension.dart';

class CustomSmartRefresher extends StatefulWidget {
  final RefreshController controller;
  final Widget? child;
  final VoidCallback? onRefresh;
  final bool isDark;
  final String? idleText;
  final String? releaseText;

  const CustomSmartRefresher({
    super.key,
    required this.controller,
    this.child,
    this.onRefresh,
    this.isDark = true,
    this.idleText,
    this.releaseText,
  });

  @override
  State<CustomSmartRefresher> createState() => _CustomSmartRefresherState();
}

class _CustomSmartRefresherState extends State<CustomSmartRefresher> {
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: widget.controller,
      physics: const BouncingScrollPhysics(),
      onRefresh: widget.onRefresh,
      header: ClassicHeader(
        textStyle: (context.text.bodyMedium ??
                TextStyle(
                    fontSize: 14,
                    color:
                        widget.isDark ? context.blackAccent : context.primary))
            .copyWith(
                color: widget.isDark ? context.blackAccent : context.primary),
        failedIcon: Icon(Icons.error_outline_rounded,
            color: widget.isDark ? context.blackAccent : context.primary),
        failedText: 'Gagal mengambil data',
        refreshingIcon: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
                color: widget.isDark ? context.blackAccent : context.primary)),
        refreshingText: 'Mohon tunggu...',
        completeIcon: Icon(Icons.check_circle_outlined,
            color: widget.isDark ? context.blackAccent : context.primary),
        completeText: 'Berhasil mengambil data',
        releaseIcon: Icon(Icons.refresh,
            color: widget.isDark ? context.blackAccent : context.primary),
        releaseText: widget.releaseText ?? 'Lepas untuk refresh',
        idleIcon: Icon(Icons.arrow_downward,
            color: widget.isDark ? context.blackAccent : context.primary),
        idleText: widget.idleText ?? 'Tarik ke bawah',
        spacing: 12.0,
      ),
      child: widget.child,
    );
  }
}
