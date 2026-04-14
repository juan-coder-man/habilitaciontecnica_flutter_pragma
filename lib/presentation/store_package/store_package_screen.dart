import 'package:api_fakestore/api_fakestore.dart';
import 'package:dartz/dartz.dart' show Either;
import 'package:flutter/material.dart';
import 'package:habilitaciontecnica_flutter_pragma/core/routes/app_routes.dart';

class StorePackageScreen extends StatefulWidget {
  const StorePackageScreen({super.key});

  @override
  State<StorePackageScreen> createState() => _StorePackageScreenState();
}

class _StorePackageScreenState extends State<StorePackageScreen> {
  late Future<Either<ApiFailure, FakeStoreDemoDataModel>> _future;

  @override
  void initState() {
    super.initState();
    _future = FakeStoreApiClient().fetchDemoData();
  }

  void _reload() {
    setState(() {
      _future = FakeStoreApiClient().fetchDemoData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _reload,
            tooltip: 'Recargar',
          ),
        ],
      ),
      body: FutureBuilder<Either<ApiFailure, FakeStoreDemoDataModel>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final either = snapshot.data;
          if (either == null) {
            return Center(
              child: Text('Sin datos.', style: theme.textTheme.bodyLarge),
            );
          }

          return either.fold(
            (failure) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      failure.message,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: _reload,
                      child: const Text('Reintentar'),
                    ),
                  ],
                ),
              ),
            ),
            (data) => ListView(
              padding: const EdgeInsets.only(top: 8, bottom: 24),
              children: [
                ...data.products.map(
                  (p) => Card(
                    child: ListTile(
                      title: Text(
                        p.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        '\$${p.price.toStringAsFixed(2)} · ${p.category}',
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.storePackageProductDetail,
                        arguments: p,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
