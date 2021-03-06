import 'package:flutter/material.dart';
import 'package:infinitlist/ui/homeview.dart';
import 'package:provider/provider.dart';

import 'Streams/StreamExample_Controller.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider<StreamExample_Controller>(
        create: (_) => StreamExample_Controller(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: StreamEx(),
    );
  }
}

class StreamEx extends StatefulWidget {
  StreamEx({Key? key}) : super(key: key);

  @override
  _StreamExState createState() => _StreamExState();
}

class _StreamExState extends State<StreamEx> {
  StreamExample_Controller? _streamExample_Controller;

  @override
  void initState() {
    super.initState();
    _streamExample_Controller =
        Provider.of<StreamExample_Controller>(context, listen: false);
    _streamExample_Controller!.getFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Title"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                _streamExample_Controller!.insertData();
              },
              child: Text("INSERT")),
          ElevatedButton(
              onPressed: () {
                _streamExample_Controller!.getFromAPI();
              },
              child: Text("GET DATA")),
          Text("ABC"),
          // Consumer<StreamExample_Controller>(
          //   builder: (context, value, child) {
          //     if (_streamExample_Controller!.loading) {
          //       return Container(
          //           // child: CircularProgressIndicator(
          //           //   color: Colors.black,
          //           // ),
          //           );
          //     } else {
          //       /*return StreamBuilder<Recipe>(
          //         // initialData: null,
          //         stream: value.getStream(),
          //         builder: (context, AsyncSnapshot<Recipe> snapshot) {
          //           if (snapshot.connectionState == ConnectionState.waiting) {
          //             return CircularProgressIndicator();
          //           } else if (snapshot.hasData) {
          //             return Text(snapshot.data!.name.toString());
          //           } else {
          //             return Container();
          //           }
          //         },
          //       );*/
          //       return Container(
          //         child: Text("value.getFromAPI()"),
          //       );
          //     }
          //   },
          // ),
          StreamBuilder<Recipe>(
            initialData: null,
            stream: _streamExample_Controller!.getStream(),
            builder: (context, AsyncSnapshot<Recipe> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasData) {
                return Text(snapshot.data!.name.toString());
              } else {
                return Container();
              }
            },
          )
        ],
      ),
    );
  }
}
