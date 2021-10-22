import 'package:flutter/material.dart';
import 'package:svran_flutter_study/ext/toast/svran_toast.dart';

class MyLayoutHomePage extends StatefulWidget {
  const MyLayoutHomePage({Key? key}) : super(key: key);

  @override
  State<MyLayoutHomePage> createState() => _MyLayoutPageState();
}

class _MyLayoutPageState extends State<MyLayoutHomePage> {
  bool _isFav = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("布局学习"),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.red.withAlpha(0x33),
            child: Row(
              children: [
                Expanded(child: Container(width: 80, height: 60, color: Colors.red)),
                Expanded(child: Container(width: 30, height: 80, color: Colors.blue)),
                Flexible(
                  child: Container(
                    width: 60,
                    height: 60,
                    child: const Icon(Icons.pets, color: Colors.white),
                    color: Colors.green,
                  ),
                ),
                Container(width: 40, height: 40, color: Colors.yellow),
              ],
            ),
          ),
          Container(
            width: 550,
            margin: const EdgeInsets.all(10),
            color: Colors.green.withAlpha(0x33),
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    svranToast("图片点击了");
                  },
                  child: Positioned(
                    child: Image.asset("assets/img/img_clannad_bg.jpg"),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.black.withAlpha(0x66),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('艾米莉亚', style: TextStyle(fontSize: 20, color: Colors.white)),
                        IconButton(
                          icon: Icon(Icons.favorite, color: _isFav ? Colors.red : Colors.white),
                          onPressed: () {
                            setState(() {
                              _isFav = !_isFav;
                            });
                            svranToast(_isFav ? "收藏了" : "取消收藏了");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
