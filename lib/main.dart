import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoist/blocs/todos_bloc/todos_bloc.dart';
import 'package:todoist/models/hive_model.dart';
import 'package:todoist/repos/api_service_impl.dart';
import 'package:todoist/screens/home_screen.dart';
import 'package:todoist/utils/get_it_setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HiveModelAdapter());
  setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodosBloc>(
            create: (BuildContext context) =>
                TodosBloc(getIt<ApiServiceImpl>()))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}
