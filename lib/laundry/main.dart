import 'package:flutter/material.dart';
import 'package:jxt_toolkits/components/layout.dart';
import 'package:jxt_toolkits/laundry/sku.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/loading.dart';
import 'client.dart';
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

  Future<void> selectLaundry(BuildContext context) async {
    final LaundryRoom result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const LaundrySelect()),
    );
    if (!mounted) return;
    setMyLaundry(result);
  }

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      appbar: AppBar(
        title: const Text('Laundry'),
      ),
      body: Column(children: [
        ElevatedButton(
          child: Text(laundryID == 0 ? 'Select Laundry' : laundryName),
          onPressed: () {
            selectLaundry(context);
          },
        ),
        const SizedBox(height: 8),
        Expanded(child: washingMachineList(laundryID)),
      ]),
    );
  }

  washingMachineList(int laundryID) {
    return RefreshIndicator(
        onRefresh: () {
          return Future(() {
            setState(() {});
          });
        },
        child: FutureBuilder<List<WashingMachine>>(
          future: getWashingMachines(laundryID),
          builder: (context, snapshot) {
            if (laundryID == 0) {
              return const Text('');
            } else if (!snapshot.hasData) {
              return const Loading();
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return washingMachineInfo(snapshot.data![index]);
              },
            );
          },
        ));
  }

  washingMachineInfo(WashingMachine obj) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => SkuPage(obj), settings: const RouteSettings(name: 'sku')),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.fromLTRB(8, 10, 8, 10),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              obj.category == categoryDryingMachine
                  ? const Icon(Icons.local_fire_department)
                  : const Icon(Icons.local_laundry_service),
              const SizedBox(width: 16),
              Text(obj.name),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(64),
                  boxShadow: [
                    BoxShadow(
                      color: (obj.available ? Colors.green : Colors.red).withAlpha(128),
                      blurRadius: 4,
                      spreadRadius: 0.0,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.circle,
                  color: obj.available ? Colors.green[600] : Colors.red[700],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
