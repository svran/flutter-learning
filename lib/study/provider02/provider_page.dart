import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svran_flutter_study/public_code.dart';
import 'package:svran_flutter_study/study/provider02/view_model/counter_view_model.dart';
import 'package:svran_flutter_study/study/provider02/view_model/user_view_model.dart';

class ProviderPage extends StatefulWidget {
  const ProviderPage({Key? key}) : super(key: key);

  @override
  State<ProviderPage> createState() => _ProviderPageState();
}

// 使用共享数据的三种方式和优化
// 1. Provider.of 当数据发生改变的时候,Provider.of 所在的整个Widget 都会重新构建
// 2. Consumer 当Provider 数据发生改变时, 执行 Consumer的 builder.
// 3. Selector 1.selector 对原有数据做类型转换. 2. shouldRebuild 要不要重新构建

class _ProviderPageState extends State<ProviderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("状态管理 Provider"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            SvranShowData01(),
            SvranShowData02(),
            SvranShowData03(),
            SvranShowData04(),
          ],
        ),
      ),
      // 可以对类型做转化.
      // floatingActionButton: Selector<SvranCounterViewModel, SvranNumberViewModel>(
      //   selector: (context,counterVm)=> SvranNumberViewModel(),
      floatingActionButton: Selector<SvranCounterViewModel, SvranCounterViewModel>(
        selector: (context, counterVm) => counterVm,
        shouldRebuild: (per, nex) => false, // 要不要重新构建. false 不重新构建
        builder: (context, counterVm, child) {
          logger.d("Svran: Flutter -> 构建了Fab");
          return FloatingActionButton(
            child: child,
            onPressed: () {
              counterVm.counter += 1;
            },
          );
        },
        child: const Icon(Icons.add), // 这里的 child 就不会重新构建了.
      ),
    );
  }
}

class SvranShowData01 extends StatefulWidget {
  const SvranShowData01({Key? key}) : super(key: key);

  @override
  State<SvranShowData01> createState() => _SvranShowData01State();
}

class _SvranShowData01State extends State<SvranShowData01> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logger.d("Svran: Flutter -> didChangeDependencies");
  }

  @override
  Widget build(BuildContext context) {
    // 使用 Provider.of 整个Widget 都会重新 build
    int counter = Provider.of<SvranCounterViewModel>(context).counter;
    logger.d("Svran: Flutter -> build 01");
    return Card(
      color: Colors.red,
      child: Text(
        '当前计数: $counter',
        style: const TextStyle(fontSize: 30),
      ),
    );
  }
}

class SvranShowData02 extends StatelessWidget {
  const SvranShowData02({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // int counter = Provider.of<SvranCounterViewModel>(context).counter;
    logger.d("Svran: Flutter -> build 02");
    return Container(
      color: Colors.blue,
      // 使用 Consumer 不会整个Widget 重新Build, 只会重新执行 Consumer 的 builder
      child: Consumer<SvranCounterViewModel>(
        builder: (BuildContext context, SvranCounterViewModel value, Widget? child) {
          return Text(
            '当前计数: ${value.counter}',
            style: const TextStyle(fontSize: 30),
          );
        },
      ),
    );
  }
}

class SvranShowData03 extends StatelessWidget {
  const SvranShowData03({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // int counter = Provider.of<SvranCounterViewModel>(context).counter;
    logger.d("Svran: Flutter -> build 02");
    return Container(
      color: Colors.green,
      // 使用 Consumer 不会整个Widget 重新Build, 只会重新执行 Consumer 的 builder
      child: Consumer<SvranUserViewModel>(
        builder: (BuildContext context, SvranUserViewModel value, Widget? child) {
          return Text(
            '当前数据: ${value.user.nickName}',
            style: const TextStyle(fontSize: 30),
          );
        },
      ),
    );
  }
}

class SvranShowData04 extends StatelessWidget {
  const SvranShowData04({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // int counter = Provider.of<SvranCounterViewModel>(context).counter;
    logger.d("Svran: Flutter -> build 02");
    return Container(
      color: Colors.blue,
      // 使用 Consumer 不会整个Widget 重新Build, 只会重新执行 Consumer 的 builder
      child: Consumer2<SvranCounterViewModel, SvranUserViewModel>(
        builder: (
          BuildContext context,
          SvranCounterViewModel value,
          SvranUserViewModel valueUser,
          Widget? child,
        ) {
          return Text(
            '当前计数: ${value.counter}\n 当前数据: ${valueUser.user.nickName}',
            style: const TextStyle(fontSize: 30),
          );
        },
      ),
    );
  }
}
