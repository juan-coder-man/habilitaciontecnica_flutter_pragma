import 'package:habilitaciontecnica_flutter_pragma/domain/entities/item_entity.dart';

abstract class ItemsRepository {
  List<ItemEntity> get items;
  ItemEntity? getById(String id);
  Future<void> add(ItemEntity item);
  Future<void> update(ItemEntity item);
  Future<void> remove(String id);
}
