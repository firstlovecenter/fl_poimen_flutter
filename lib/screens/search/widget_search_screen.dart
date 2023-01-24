import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/alert_box.dart';

class SearchScreenWidget extends StatefulHookWidget {
  const SearchScreenWidget({Key? key, required this.query}) : super(key: key);

  final dynamic query;

  @override
  State<SearchScreenWidget> createState() => _SearchScreenWidgetState();
}

class _SearchScreenWidgetState extends State<SearchScreenWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String searchKey = '';

    final searchMutation = useMutation(
      MutationOptions(
        document: widget.query,
        // ignore: void_checks
        update: (cache, result) {
          return cache;
        },
        onCompleted: (resultData) {
          Navigator.of(context).pop();
        },
        onError: (error) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                getGQLException(error),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: PoimenTheme.bad),
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: PoimenTheme.brand,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: PoimenTheme.brand,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: PoimenTheme.brand),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    labelText: 'Search',
                    hintText: 'Search',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a search term';
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      searchKey = value
                          .trim()
                          .replaceAll(RegExp(r'[^a-zA-Z0-9]'), ' ')
                          .replaceAll(RegExp(r'\s+'), ' ');

                      print('variables: $searchKey');
                      searchMutation.runMutation({
                        'searchKey': searchKey,
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
