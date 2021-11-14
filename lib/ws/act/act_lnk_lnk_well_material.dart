import 'package:flutter/material.dart';

class ActLnkLnkWellMaterialDemoPage extends StatefulWidget {
  const ActLnkLnkWellMaterialDemoPage({Key? key}) : super(key: key);

  @override
  State<ActLnkLnkWellMaterialDemoPage> createState() => _ActLnkLnkWellMaterialDemoPageState();
}

class _ActLnkLnkWellMaterialDemoPageState extends State<ActLnkLnkWellMaterialDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BV1RV411v7bX"),
      ),
      body: Center(
        child: SvranA1(),
      ),
    );
  }
}

class SvranA2 extends StatefulWidget {
  const SvranA2({Key? key}) : super(key: key);

  @override
  _SvranA2State createState() => _SvranA2State();
}

class _SvranA2State extends State<SvranA2> {
  bool _big = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: _big ? 200 : 60,
      height: 60,
      child: ElevatedButton(
        // InkWell 水波纹效果,
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
        ),
        // customBorder: StadiumBorder(),
        onPressed: () => setState(() => _big = !_big),
        child: AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: _big
                ? Text('Ready!', style: TextStyle(fontSize: 20, color: Colors.white))
                : Icon(Icons.arrow_forward_rounded, color: Colors.white)),
      ),
    );
  }
}

class SvranA1 extends StatefulWidget {
  const SvranA1({Key? key}) : super(key: key);

  @override
  State<SvranA1> createState() => _SvranA1State();
}

class _SvranA1State extends State<SvranA1> {
  bool _big = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: _big ? 200 : 60,
      height: 60,
      child: Material(
        color: Colors.purple,
        elevation: 4,
        shape: StadiumBorder(), // 体育场边界?? 类似体育场跑到那样的边框
        child: InkWell(
          // InkWell 水波纹效果,
          customBorder: StadiumBorder(),
          onTap: () => setState(() => _big = !_big),
          child: AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: _big
                  ? Text('Ready!', style: TextStyle(fontSize: 20, color: Colors.white))
                  : Icon(Icons.arrow_forward_rounded, color: Colors.white)),
        ),
      ),
    );
  }
}
