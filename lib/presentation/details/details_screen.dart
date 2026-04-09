import 'package:flutter/material.dart';
import 'package:habilitaciontecnica_flutter_pragma/core/routes/app_routes.dart';
import 'package:habilitaciontecnica_flutter_pragma/data/repositories/items_repository_impl.dart';
import 'package:habilitaciontecnica_flutter_pragma/domain/entities/item_entity.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.item});

  final ItemEntity item;

  @override
  Widget build(BuildContext context) {
    final repository = context.watch<ItemsRepositoryImpl>();
    final current = repository.getById(item.id);
    if (current == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detalles')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Elemento no encontrado.',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                TextButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Volver'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Detalles')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              current.title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(current.description, style: theme.textTheme.bodyLarge),
            const SizedBox(height: 16),
            Text(
              'Creado: ${_formatDate(current.createdAt)}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _navigateToForm(context, current),
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('Editar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () =>
                        _deleteAndPop(context, repository, current.id),
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Eliminar'),
                    style: FilledButton.styleFrom(
                      backgroundColor: theme.colorScheme.error,
                      foregroundColor: theme.colorScheme.onError,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _navigateToForm(BuildContext context, ItemEntity item) {
    Navigator.pushNamed(context, AppRoutes.form, arguments: item);
  }

  Future<void> _deleteAndPop(
    BuildContext context,
    ItemsRepositoryImpl repository,
    String id,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar'),
        content: const Text(
          '¿Estás seguro de que deseas eliminar este elemento?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      await repository.remove(id);
      if (context.mounted) Navigator.pop(context);
    }
  }
}
