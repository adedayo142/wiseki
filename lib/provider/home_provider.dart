import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wiseki/database/database_helper.dart';
import 'package:wiseki/model/note.dart';
import 'package:flutter/material.dart';
part "home_provider.g.dart";


@riverpod
class HomeState extends _$HomeState {
  @override
  List<Notes> build() {
    return [];
  }

  void addNote(Notes notes) async {
    await DatabaseTable.createItem(Notes as Notes);
    refresh();
  }
  void refresh() async {
    final data = await DatabaseTable.getItems();
    state = data.map((e) => Notes.fromJson(e)).toList();
  }

  void addNotes(Notes notes) {}
}
