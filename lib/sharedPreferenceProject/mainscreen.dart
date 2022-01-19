import 'package:flutter/material.dart';
import 'package:video_player_package/widget/basics/network_player_widget.dart';

// class SharedPrefScreen extends StatelessWidget {
//   const SharedPrefScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Video Player Demo',
//       home: SharedPrefWidget(),
//     );
//   }
// }

class SharedPrefWidget extends StatefulWidget {
  const SharedPrefWidget({Key? key}) : super(key: key);

  @override
  _SharedPrefWidgetState createState() => _SharedPrefWidgetState();
}

class _SharedPrefWidgetState extends State<SharedPrefWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SharedPreference')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('This is our home screen'),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NetworkPlayerWidget(),
                    ));
              },
              child: Text('Video Player'))
        ],
      ),
    );
  }
}
