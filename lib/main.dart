import 'package:demo_mobx/configs/di.dart';
import 'package:demo_mobx/pages/home_page/home_page.dart';
import 'package:demo_mobx/stores/counter_store/counter_store.dart';
import 'package:demo_mobx/stores/task_store/task_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future main() async {
  setUpDependencyInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CounterStore>(create: (_) => getIt.get<CounterStore>()),
        Provider<TaskStore>(create: (_) => getIt.get<TaskStore>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
