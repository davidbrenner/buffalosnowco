import 'package:buffalosnowco/widgets/fade_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/theme.dart';
import 'package:flutter_login/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';

class SnowAppBar extends AppBar {
  SnowAppBar({Key? key}) : super(key: key);
  @override
  State<SnowAppBar> createState() => _SnowAppBarState();
}

class _SnowAppBarState extends State<SnowAppBar> {
  Future<bool> _goToLogin(BuildContext context) {
    return Navigator.of(context)
        .pushReplacementNamed('/auth')
        // we dont want to pop the screen, just replace it completely
        .then((_) => false);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final menuBtn = IconButton(
      color: theme.colorScheme.secondary,
      icon: const Icon(FontAwesomeIcons.bars),
      onPressed: () {},
    );
    final signOutBtn = IconButton(
      icon: const Icon(FontAwesomeIcons.signOutAlt),
      color: theme.colorScheme.secondary,
      onPressed: () async {
        await FirebaseAuth.instance.signOut();
        _goToLogin(context);
      },
    );
    final title = Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: Image.asset(
              'assets/images/logo.png',
              filterQuality: FilterQuality.high,
              height: 30,
            ),
          ),
          Text(
            Constants.appName,
            style: theme.textTheme.headline6!.copyWith(
                color: theme.colorScheme.secondary,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );

    return AppBar(
      leading: IconButton(
        color: theme.colorScheme.secondary,
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),

      actions: <Widget>[
        signOutBtn,
      ],
      title: title,
      backgroundColor: Colors.blue,
      elevation: 0,
      // toolbarTextStyle: TextStle(),
      // textTheme: theme.accentTextTheme,
      // iconTheme: theme.accentIconTheme,
    );
  }
}
