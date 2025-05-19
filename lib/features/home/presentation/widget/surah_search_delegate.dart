import 'package:flutter/material.dart';
import 'package:quran_ease/core/config/route.dart';
import 'package:quran_ease/features/home/domain/entity/surah.dart';

class SurahSearchDelegate extends SearchDelegate<String> {
  final List<Surah> surahList;

  SurahSearchDelegate(this.surahList);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = surahList.where((surah) {
      return surah.namaLatin.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final surah = suggestions[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text(surah.nomor.toString()),
          ),
          title: Text(surah.namaLatin),
          subtitle: Text(surah.arti),
          onTap: () {
            Navigator.of(context).pushNamed(
              MyRouter.routeDetailSurah,
              arguments: {'surah': surah},
            );
            close(context, surah.namaLatin);
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Bisa tampilkan hasil lebih spesifik atau sama dengan suggestions
    return buildSuggestions(context);
  }
}
