import 'package:mix_tube_application/stores/counter_store/counter_store.dart';
import 'package:mix_tube_application/stores/login_store/login_store.dart';
import 'package:mix_tube_application/stores/task_store/task_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CounterStore _counterStore;
  late TaskStore _taskStore;
  late LoginStore _loginStore;

  @override
  void initState() {
    super.initState();
    _counterStore = Provider.of<CounterStore>(context, listen: false);
    _taskStore = Provider.of<TaskStore>(context, listen: false);
    _loginStore = Provider.of<LoginStore>(context, listen: false);
    _taskStore.getListTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          TextButton(
              onPressed: () {
                _loginStore.logout();
              },
              child: const Text(
                'Log out',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
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
            )),
            const SizedBox(
              height: 20,
            ),
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
