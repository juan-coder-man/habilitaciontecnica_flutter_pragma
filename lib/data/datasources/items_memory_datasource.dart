import 'package:habilitaciontecnica_flutter_pragma/domain/entities/item_entity.dart';

class ItemsMemoryDatasource {
  ItemsMemoryDatasource() : _items = [] {
    _seedItems();
  }

  final List<ItemEntity> _items;
  int _idCounter = 0;

  void _seedItems() {
    final now = DateTime.now();
    _items.add(
      ItemEntity(
        id: _nextId(),
        title: 'Ejemplo 1',
        description: 'Descripción del primer elemento de ejemplo.',
        createdAt: now.subtract(const Duration(days: 2)),
      ),
    );
    _items.add(
      ItemEntity(
        id: _nextId(),
        title: 'Ejemplo 2',
        description: 'Descripción del segundo elemento de ejemplo.',
        createdAt: now.subtract(const Duration(days: 1)),
      ),
    );
  }

  String _nextId() => '${++_idCounter}';

  String generateId() => _nextId();

  List<ItemEntity> getAll() => List.unmodifiable(_items);

  ItemEntity? getById(String id) {
    try {
      return _items.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  void add(ItemEntity item) {
    _items.add(item);
  }

  void update(ItemEntity item) {
    final index = _items.indexWhere((e) => e.id == item.id);
    if (index >= 0) _items[index] = item;
  }

  void delete(String id) {
    _items.removeWhere((e) => e.id == id);
  }
}
