import 'dart:async';

import 'package:flutter/material.dart';
import 'package:habilitaciontecnica_flutter_pragma/core/debug/calculator_demo_log.dart';
import 'package:habilitaciontecnica_flutter_pragma/core/debug/store_demo_log.dart';
import 'package:habilitaciontecnica_flutter_pragma/core/routes/app_routes.dart';
import 'package:habilitaciontecnica_flutter_pragma/core/theme/app_theme.dart';
import 'package:habilitaciontecnica_flutter_pragma/data/datasources/items_memory_datasource.dart';
import 'package:habilitaciontecnica_flutter_pragma/data/datasources/store_remote_datasource.dart';
import 'package:habilitaciontecnica_flutter_pragma/data/repositories/items_repository_impl.dart';
import 'package:habilitaciontecnica_flutter_pragma/data/repositories/store_remote_repository_impl.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(_bootstrapStoreDemo());
  unawaited(_bootstrapCalculatorDemo());
  runApp(const App());
}

Future<void> _bootstrapStoreDemo() async {
  final repository = StoreRemoteRepositoryImpl(StoreRemoteDatasource());
  final result = await repository.fetchDemoData();
  logStoreDemoResult(result, debugPrint);
}

Future<void> _bootstrapCalculatorDemo() async {
  logCalculatorDemo(debugPrint);
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ItemsRepositoryImpl>(
          create: (_) => ItemsRepositoryImpl(ItemsMemoryDatasource()),
        ),
      ],
      child: MaterialApp(
        title: 'Listado',
        theme: AppTheme.theme,
        initialRoute: AppRoutes.home,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
