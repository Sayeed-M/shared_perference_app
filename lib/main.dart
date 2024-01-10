import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shared perferences',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DisplayLayout();
}

class DisplayLayout extends State<MyHomePage> {
  final _controller_key = TextEditingController();
  final _controller_data = TextEditingController();

  String text_to_show = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared perferences'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _controller_key,
            decoration: InputDecoration(hintText: 'Enter the key'),
          ),
          TextField(
            controller: _controller_data,
            decoration: InputDecoration(hintText: 'Enter the data'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  onPressed: () =>
                      saveData(_controller_key.text, _controller_data.text),
                  child: Text(" Save Data"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  onPressed: () => readData(
                    _controller_key.text,
                  ),
                  child: Text(" Read Data"),
                ),
              )
            ],
          ),
          Text('$text_to_show'),
        ],
      ),
    );
  }

  saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    Fluttertoast.showToast(msg: 'saved data!', toastLength: Toast.LENGTH_SHORT);
  }

  readData(String text) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      text_to_show = prefs.getString(text)!;
    });
  }
}
