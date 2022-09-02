import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SvranThemeDemoPage extends StatefulWidget {
  const SvranThemeDemoPage({Key? key}) : super(key: key);

  @override
  State<SvranThemeDemoPage> createState() => _SvranThemeDemoPageState();
}

class _SvranThemeDemoPageState extends State<SvranThemeDemoPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.red,
        // 包含了 primaryColor
        primaryColor: Colors.purple,
        //
        accentColor: Colors.green,
        //
        buttonTheme: const ButtonThemeData(
          height: 80,
          minWidth: 10,
        ),
        cardTheme: const CardTheme(
          color: Colors.greenAccent,
          elevation: 5,
        ),
        textTheme: const TextTheme(
          bodyText1: TextStyle(fontSize: 15),
          bodyText2: TextStyle(fontSize: 25),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.backspace),
          ),
          title: const Text("主题学习"),
        ),
        body: Center(
          child: Container(
            color: Colors.red.withAlpha(0x30),
            child: Column(
              children: [
                const Text('Hello word !'),
                Text('Hello word 1!', style: Theme.of(context).textTheme.bodyText1),
                Text('Hello word 2!', style: Theme.of(context).textTheme.bodyText2),
                Switch(value: true, onChanged: (value) {}),
                CupertinoSwitch(
                  value: true,
                  onChanged: (value) {},
                  activeColor: Colors.blue,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('这是啥按钮'),
                ),
                Card(
                  child: Text('你不好card'),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(label: "首页", icon: Icon(Icons.image)),
            BottomNavigationBarItem(label: "其他", icon: Icon(Icons.image)),
          ],
        ),
        floatingActionButton: Theme(
          data: Theme.of(context).copyWith(
              accentColor: Colors.orange, // 这个无法更改覆盖,
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    secondary: Colors.brown, // 这里才能正常更改覆盖.
                  )),
          child: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
