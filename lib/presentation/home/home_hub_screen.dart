import 'package:flutter/material.dart';
import 'package:habilitaciontecnica_flutter_pragma/core/routes/app_routes.dart';

class HomeHubScreen extends StatelessWidget {
  const HomeHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _HubOptionCard(
            title: 'Listado de elementos',
            description:
                'Ítems en memoria en este dispositivo. Puedes agregar, abrir el detalle y editar cada entrada.',
            icon: Icons.list_alt_outlined,
            onTap: () => Navigator.pushNamed(context, AppRoutes.items),
          ),
          const SizedBox(height: 12),
          _HubOptionCard(
            title: 'Listado de productos',
            description:
                'Productos de demostración vía el paquete api_fakestore. Consulta fichas y recarga el catálogo.',
            icon: Icons.storefront_outlined,
            onTap: () => Navigator.pushNamed(context, AppRoutes.storePackage),
          ),
        ],
      ),
    );
  }
}

class _HubOptionCard extends StatelessWidget {
  const _HubOptionCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 32, color: theme.colorScheme.primary),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
