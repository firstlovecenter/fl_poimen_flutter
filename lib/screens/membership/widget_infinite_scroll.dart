import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:poimen/screens/membership/models_membership.dart';

class MemberListView extends StatefulWidget {
  const MemberListView({
    Key? key,
    required this.fetchMore,
  }) : super(key: key);

  final Future<void> Function(Map<String, dynamic>)? fetchMore;

  @override
  State<MemberListView> createState() => _MemberListViewState();
}

class _MemberListViewState extends State<MemberListView> {
  static const _pageSize = 7;

  final PagingController<int, MemberForList> _pagingController = PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      widget.fetchMore({'first': _pageSize, 'after': pageKey}).then((value) {
        _pagingController.appendLastPage([]);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      // Don't worry about displaying progress or error indicators on screen; the
      // package takes care of that. If you want to customize them, use the
      // [PagedChildBuilderDelegate] properties.
      PagedListView<int, MemberForList>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<MemberForList>(
            itemBuilder: (context, item, index) => const Text('dasgf')),
      );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
