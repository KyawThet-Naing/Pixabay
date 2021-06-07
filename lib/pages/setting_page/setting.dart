import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pixabay/pages/downloaded_page/downloaded.dart';
import 'package:pixabay/pages/laguage_page/language.dart';
import 'package:pixabay/provider/theme_provider.dart';
import 'package:pixabay/utils/global_widget.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('setting'))),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.language),
            title: Text(
              tr('language'),
              style: GlobalWidget.buildTextStyle(),
            ),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => Language()))
                .then((_) => setState(() {})),
          ),
          ListTile(
            leading: Icon(Icons.photo),
            title: Text(
              tr('download_image'),
              style: GlobalWidget.buildTextStyle(),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => DownloadedImage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.nightlight_round),
            title: Text(
              tr('dark_mode'),
              style: GlobalWidget.buildTextStyle(),
            ),
            trailing: Consumer<ThemeProvider>(
              builder: (context, ThemeProvider tp, child) => Switch(
                value: tp.themeMode == ThemeMode.dark,
                onChanged: (isOn) {
                  if (isOn) {
                    tp.changeDarkTheme();
                  } else {
                    tp.changeLightTheme();
                  }
                },
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
