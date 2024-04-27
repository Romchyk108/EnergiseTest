import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:math';
import 'package:hive/hive.dart';

import 'data.dart';
import 'localization.dart';

class SecondView extends StatefulWidget {
  SecondView({super.key});

  @override
  State<StatefulWidget> createState() => _SecondView();
}

class _SecondView extends State<SecondView> with TickerProviderStateMixin {
  late IPData? data;
  // var dataBox = Hive.box<IPData>('data');

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List<Widget> fields = [
      Text('${AppLocalizations.of(context)?.translate('country') ?? 'country123'} - ${data?.country}'),
      Text('${AppLocalizations.of(context)?.translate('region name') ?? 'region name123'} - ${data?.regionName}'),
      Text('${AppLocalizations.of(context)?.translate('city') ?? 'city123'} - ${data?.city}'),
      Text('${AppLocalizations.of(context)?.translate('timezone') ?? 'timezone123'} - ${data?.timezone}'),
    ];

    Widget map(IPData? data) {
      return FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(data?.lat ?? 0.0, data?.lon ?? 0.0),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          )
        ]);
    }

    return Scaffold(
        body: RefreshIndicator(
        onRefresh: _fetchData,
        child:  Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          width: size.width * 0.8, height: size.height * 0.5, child: map(data)),
      SizedBox(height: size.height * 0.02),
      Container(
          height: size.height * 0.2,
          width: size.width * 0.9,
          child: buildWheelScrollView(
              itemsCount: fields.length,
              itemBuilder: (context, index) {
                AnimationController controller = AnimationController(
                  duration: const Duration(milliseconds: 1000),
                  animationBehavior: AnimationBehavior.normal,
                  vsync: this,
                );
                return fields[index];
              })),
      SizedBox(height: size.height * 0.02),
      Container(
          width: size.width * 0.85,
          child: ElevatedButton(
              onPressed: _fetchData,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15)),
              child: Text(AppLocalizations.of(context)?.translate('reload') ?? "reload123",
                  style: TextStyle(fontSize: 18, color: Colors.black))))
    ]))));
  }

  Widget buildWheelScrollView({
    required int itemsCount,
    required Widget Function(BuildContext, int) itemBuilder,
  }) {
    return Expanded(
        child: ListWheelScrollView.useDelegate(
      itemExtent: 25,
      childDelegate: ListWheelChildBuilderDelegate(
        builder: itemBuilder,
        childCount: itemsCount,
      ),
      physics: const FixedExtentScrollPhysics(),
      useMagnifier: true,
      magnification: 1.5,
    ));
  }

  Future<void> _fetchData() async {
    int number = Random().nextInt(255);
    try {
      http.Response response = await http
          .get(Uri.parse('http://ip-api.com/json/176.98.$number.$number'));
      print('response.statusCode - ${response.statusCode}');
      if (response.statusCode == 200) {
        setState(() {
          data = IPData.fromJson(json.decode(response.body));
          // if (data != null) {
          //   dataBox.put('ipData', data!);
          // }
        });
        // await dataBox.close();
      } else {
        // setState(() {
        //   data = dataBox.get('ipData');
        // });
        // await dataBox.close();
      }
    } catch (e) {
      print(e.toString());
      // setState(() {
      //   data = dataBox.get('ipData');
      // });
      // await dataBox.close();
    }
  }
}
