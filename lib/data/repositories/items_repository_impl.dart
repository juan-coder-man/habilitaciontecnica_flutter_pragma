import 'package:flutter/foundation.dart';
import 'package:habilitaciontecnica_flutter_pragma/data/datasources/items_memory_datasource.dart';
import 'package:habilitaciontecnica_flutter_pragma/domain/entities/item.dart';
import 'package:habilitaciontecnica_flutter_pragma/domain/repositories/items_repository.dart';

class ItemsRepositoryImpl extends ChangeNotifier implements ItemsRepository {
  ItemsRepositoryImpl(this._datasource);

  final ItemsMemoryDatasource _datasource;

  @override
  List<Item> get items => _datasource.getAll();

  @override
  Item? getById(String id) => _datasource.getById(id);

  @override
  Future<void> add(Item item) async {
    final id = item.id.isEmpty ? _datasource.generateId() : item.id;
    _datasource.add(item.copyWith(id: id));
    notifyListeners();
  }

  @override
  Future<void> update(Item item) async {
    _datasource.update(item);
    notifyListeners();
  }

  @override
  Future<void> remove(String id) async {
    _datasource.delete(id);
    notifyListeners();
  }
}
