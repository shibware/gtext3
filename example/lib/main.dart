import 'package:flutter/material.dart';
import 'package:gtext/gtext.dart';

void main() {
  GText.init(enableCaching: false, to: 'pl');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'GText Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final textController = TextEditingController();
  final languageController = TextEditingController();

  List<GText> items = [];

  void handleApply() {
    items.add(
      GText(
        textController.text,
        toLang:
            languageController.text.isEmpty ? null : languageController.text,
      ),
    );

    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
    languageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: textController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Type text",
                ),
              ),
            ),
            const SizedBox(width: 25),
            Expanded(
              child: TextField(
                controller: languageController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Type language code",
                ),
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: handleApply,
            child: const Text("Add"),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items.elementAt(index);

          return ListTile(
            leading: const Icon(Icons.translate),
            title: item,
            subtitle: item.toLang is String ? Text(item.toLang!) : null,
          );
        },
      ),
    );
  }
}
