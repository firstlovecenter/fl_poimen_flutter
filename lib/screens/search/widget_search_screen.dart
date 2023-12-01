import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:provider/provider.dart';

class SearchFieldWidget extends StatefulHookWidget {
  const SearchFieldWidget({Key? key, required this.query}) : super(key: key);

  final dynamic query;

  @override
  State<SearchFieldWidget> createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

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
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: PoimenTheme.brand),
                      borderRadius: BorderRadius.circular(30.0),
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

                      churchState.searchKey = value;
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
