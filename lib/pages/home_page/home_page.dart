import 'package:demo_mobx/stores/counter_store/counter_store.dart';
import 'package:demo_mobx/stores/task_store/task_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CounterStore _counterStore;
  late TaskStore _taskStore;

  @override
  void initState() {
    super.initState();
    _counterStore = Provider.of<CounterStore>(context, listen: false);
    _taskStore = Provider.of<TaskStore>(context, listen: false);
    _taskStore.getListTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Observer(builder: (context) {
              return Text(
                '${_counterStore.count}',
                style: Theme.of(context).textTheme.headlineMedium,
              );
            }),
            Flexible(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Observer(builder: (context) {
                return ListView.builder(
                  itemCount: _taskStore.listTasks.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      child: Text(_taskStore.listTasks[index].title ?? ''),
                    );
                  },
                );
              }),
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _counterStore.increment2,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
