import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/data/datasources/cat_api_datasource.dart';
import 'features/presentation/bloc/breeds_bloc.dart';
import 'features/presentation/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BreedsBloc(CatApiDatasource())..add(LoadBreeds()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashPage(),
      ),
    );
  }
}