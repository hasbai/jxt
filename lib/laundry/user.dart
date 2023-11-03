import 'package:flutter/material.dart';
import 'package:jxt_toolkits/components/layout.dart';
import 'package:jxt_toolkits/laundry/api.dart';

import '../components/loading.dart';
import 'model.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<StatefulWidget> createState() => _UserPage();
}

class _UserPage extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Skeleton(
      appbar: AppBar(
        title: const Text('User'),
      ),
      body: FutureBuilder(
        future: getUserInfo(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Loading();
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return ui(snapshot.data!);
        },
      )
    );
  }

  ui(User user){
    return Align(
      alignment: Alignment.topCenter,
      child: Wrap(
        direction: Axis.vertical,
        spacing: 16,
        children: [
          Image.network(user.avatar),
          Text('Nickname: ${user.nickname}'),
          Text('Gender: ${user.gender}'),
          Text('Phone: ${user.phone}'),
        ]
      ),
    );
  }
}