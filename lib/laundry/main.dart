import 'package:flutter/material.dart';
import 'package:jxt_toolkits/laundry/washingMachine.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'laundrySelect.dart';
import 'model.dart';

class Laundry extends StatefulWidget {
  const Laundry({super.key});

  @override
  State<Laundry> createState() => _LaundryState();
}

class _LaundryState extends State<Laundry> {
  int laundryID = 0;
  String laundryName = '';

  @override
  void initState() {
    super.initState();
    loadMyLaundry();
  }

  Future<void> loadMyLaundry() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      laundryID = prefs.getInt('laundryID') ?? 0;
      laundryName = prefs.getString('laundryName') ?? '';
    });
  }

  Future<void> setMyLaundry(LaundryRoom laundry) async {
    setState(() {
      laundryID = laundry.id;
      laundryName = laundry.name;
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('laundryID', laundry.id);
    prefs.setString('laundryName', laundry.name);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          ElevatedButton(
            child: Text(laundryID == 0 ? 'Select Laundry' : laundryName),
            onPressed: () {
              selectLaundry(context);
            },
          ),
          const SizedBox(height: 8),
          Expanded(child: WashingMachineList(laundryID)),
        ]);
  }

  Future<void> selectLaundry(BuildContext context) async {
    final LaundryRoom result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const LaundrySelect()),
    );
    if (!mounted) return;
    setMyLaundry(result);
  }
}
