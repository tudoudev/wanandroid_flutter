import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid_flutter/page/main/viewmodel/demo_view_model.dart';

class HomePageDemo extends StatelessWidget {
  const HomePageDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => DemoViewModel(),
        builder: (context, child) {
          return Scaffold(
            body: Center(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  RedBox(),
                  YellowBox(),
                  BlueBox(),
                  GreenBox(),
                  // Text(Provider.of<DemoViewModel>(context).aaa.toString())
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Provider.of<DemoViewModel>(context, listen: false).change();
              },
              // child: const Icon(Icons.add),
              child: const Icon(Icons.add),
            ),
            // Consumer<DemoViewModel>(builder: (BuildContext context, DemoViewModel value, Widget? child) {
            //   return FloatingActionButton(
            //     onPressed: () {
            //       value.changeAaa();
            //     },
            //     child: const Icon(Icons.add),
            //   );
            // })
          );
        });
  }
}

class RedBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("---------RedBox---------build---------");
    return Container(
      color: Colors.red,
      width: 150,
      height: 150,
      alignment: Alignment.center,
      // child: Text(
      //   "Red:${Provider.of<DemoViewModel>(context).aaa}",
      //   style: const TextStyle(fontSize: 20),
      // ),
      child: Consumer<DemoViewModel>(
          builder: (ctx, state, child) => Text(
                "Red:${state.aaa}",
                style: const TextStyle(fontSize: 20),
              )),
    );
  }
}

class YellowBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("---------YellowBox---------build---------");
    return Container(
      color: Colors.yellow,
      width: 150,
      height: 150,
      alignment: Alignment.center,
      // child: Text("Yellow:${Provider.of<DemoViewModel>(context).aaa}", style: const TextStyle(fontSize: 20)),
      child: Consumer<DemoViewModel>(
          builder: (ctx, state, child) => Text(
                "Yellow:${state.aaa}",
                style: const TextStyle(fontSize: 20),
              )),
    );
  }
}

class BlueBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("---------BlueBox---------build---------");
    return Container(
      color: Colors.blue,
      width: 150,
      height: 150,
      alignment: Alignment.center,
      child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => NextPage()));
          },
          // child: Text("Blue:${Provider.of<DemoViewModel>(context).aaa}", style: const TextStyle(fontSize: 20)),
          child: Consumer<DemoViewModel>(
              builder: (ctx, state, child) => Text(
                    "Blue${state.aaa}",
                    style: const TextStyle(fontSize: 20),
                  ))),
    );
  }
}

class GreenBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("---------GreenBox---------build---------");
    return Container(
      color: Colors.green,
      width: 150,
      height: 150,
      alignment: Alignment.center,
      child: Text("GreenBox:${Provider.of<DemoViewModel>(context).aaa}", style: const TextStyle(fontSize: 20)),
    );
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("---------NextPage---------build---------");
    return Scaffold(
      body: Center(
          child: InkWell(
        onTap: () {
          Provider.of<DemoViewModel>(context, listen: false).change();
        },
        child: Container(
            color: Colors.purple, width: 150, height: 150, alignment: Alignment.center, child: Text("NextPage:${Provider.of<DemoViewModel>(context).aaa}", style: const TextStyle(fontSize: 20))),
      )),
    );
  }
}
