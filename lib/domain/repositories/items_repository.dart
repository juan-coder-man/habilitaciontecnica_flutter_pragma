import 'package:habilitaciontecnica_flutter_pragma/domain/entities/item.dart';

abstract class ItemsRepository {
  List<Item> get items;
  Item? getById(String id);
  Future<void> add(Item item);
  Future<void> update(Item item);
  Future<void> remove(String id);
}
