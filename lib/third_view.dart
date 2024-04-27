import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_share/flutter_share.dart';

import 'localization.dart';

class ThirdView extends StatefulWidget {
  ThirdView({super.key});

  @override
  State<StatefulWidget> createState() => _ThirdView();
}

class _ThirdView extends State<ThirdView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      TextButton(
          onPressed: () {
            _rateApp(context);
          },
          child: Text(AppLocalizations.of(context)?.translate('rate App') ?? 'Rate App')),
      TextButton(
          onPressed: _share,
          child: Text(AppLocalizations.of(context)?.translate('share App') ?? 'Share App')),
      TextButton(
          onPressed: _contactUs,
          child: Text(AppLocalizations.of(context)?.translate('contact us') ?? 'Contact us'))
    ]));
  }

  void _rateApp(BuildContext context) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Our rating'),
            content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.yellow.shade700),
                  Icon(Icons.star, color: Colors.yellow.shade700),
                  Icon(Icons.star, color: Colors.yellow.shade700),
                  Icon(Icons.star, color: Colors.yellow.shade700),
                  Icon(Icons.star_half, color: Colors.yellow.shade700),
                ]),
            actions: [
              CupertinoButton(
                  child: Text(AppLocalizations.of(context)?.translate('cancel') ?? 'Cancel123'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              CupertinoButton(
                  child: Text(AppLocalizations.of(context)?.translate('submit') ?? 'Submit123'),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  void _contactUs() async {
    Uri uri = Uri.parse(
        'https://energise.notion.site/Flutter-f86d340cadb34e9cb1ef092df4e566b7');
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  Future<void> _share() async {
    await FlutterShare.share(
        title: AppLocalizations.of(context)?.translate('share app') ?? 'Share app123',
        text: AppLocalizations.of(context)?.translate('example share app') ?? 'Example share app123',
        chooserTitle: AppLocalizations.of(context)?.translate('share your app') ?? 'Share your app123'
    );
  }
}
