import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Language extends StatelessWidget {
  const Language({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('language')),
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () => context.setLocale(Locale('en', 'US')),
            leading: Text('English',
                style: TextStyle(fontFamily: 'CreteRound', fontSize: 18)),
            trailing: context.locale.languageCode == 'en'
                ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                : Text('select',
                    style: TextStyle(fontFamily: 'CreteRound', fontSize: 18)),
          ),
          ListTile(
            onTap: () => context.setLocale(Locale('my', 'MM')),
            leading: Text(
              'မြန်မာ',
              style: TextStyle(fontFamily: 'MM3', fontSize: 18),
            ),
            trailing: context.locale.languageCode == 'my'
                ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                : Text('select',
                    style: TextStyle(fontFamily: 'CreteRound', fontSize: 18)),
          ),
        ],
      ),
    );
  }
}
