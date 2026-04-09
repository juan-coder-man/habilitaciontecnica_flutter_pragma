import 'package:flutter/material.dart';
import 'package:habilitaciontecnica_flutter_pragma/core/routes/app_routes.dart';
import 'package:habilitaciontecnica_flutter_pragma/data/repositories/items_repository_impl.dart';
import 'package:habilitaciontecnica_flutter_pragma/presentation/home/widgets/item_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Listado')),
      body: Consumer<ItemsRepositoryImpl>(
        builder: (context, repository, _) {
          final items = repository.items;
          if (items.isEmpty) {
            return Center(
              child: Text(
                'No hay elementos. Agrega uno con el botón +.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: items.length,
            separatorBuilder: (context, index) => const SizedBox(height: 4),
            itemBuilder: (context, index) {
              final item = items[index];
              return ItemCard(
                item: item,
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.details,
                  arguments: item,
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.form),
        tooltip: 'Agregar',
        child: const Icon(Icons.add),
      ),
    );
  }
}
