import 'package:flutter/material.dart';
import 'package:poimen/screens/membership/details/widget_scaffold_with_member_avatar.dart';
import 'package:poimen/mixins/validation_mixin.dart';

class HolyGhostBaptismScreen extends StatefulWidget {
  const HolyGhostBaptismScreen({Key? key}) : super(key: key);

  @override
  State<HolyGhostBaptismScreen> createState() => _HolyGhostBaptismScreenState();
}

class _HolyGhostBaptismScreenState extends State<HolyGhostBaptismScreen> with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  String _baptismDate = '';

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithMemberAvatar(
      title: 'Holy Ghost Baptism',
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              textField(),
              const Padding(padding: EdgeInsets.all(10)),
              submitButton()
            ],
          ),
        )
      ],
    );
  }

  Widget textField() {
    return TextFormField(
      keyboardType: TextInputType.datetime,
      decoration: const InputDecoration(
        labelText: 'Enter Your Baptism Date',
        hintText: '4th November 2021',
      ),
      validator: validateText,
      onSaved: (value) {
        _baptismDate = value!;
      },
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();

          // take both email and password and send to some api
          print('Time to post $_baptismDate to my API');
        }
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      child: const Text('Submit'),
    );
  }
}
