import 'dart:convert';

/// Model class for inventory items from the JSON structure
class InventoryItem {
  final String type;
  final String item;
  final int tier;
  final int value;

  InventoryItem({
    required this.type,
    required this.item,
    required this.tier,
    required this.value,
  });

  factory InventoryItem.fromJson(Map<String, dynamic> json) {
    return InventoryItem(
      type: json['type'] as String,
      item: json['item'] as String,
      tier: json['tier'] as int,
      value: json['value'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'item': item,
      'tier': tier,
      'value': value,
    };
  }
}

/// Model class for the entire inventory
class Inventory {
  final List<InventoryItem> items;

  Inventory({required this.items});

  factory Inventory.fromJson(Map<String, dynamic> json) {
    final itemsList = json['inventory'] as List;
    final items = itemsList.map((item) => InventoryItem.fromJson(item)).toList();
    return Inventory(items: items);
  }

  Map<String, dynamic> toJson() {
    return {
      'inventory': items.map((item) => item.toJson()).toList(),
    };
  }

  /// Parse inventory from JSON string
  static Inventory fromJsonString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return Inventory.fromJson(json);
  }

  /// Convert inventory to JSON string
  String toJsonString() {
    return jsonEncode(toJson());
  }

  /// Get items by type
  List<InventoryItem> getItemsByType(String type) {
    return items.where((item) => item.type == type).toList();
  }

  /// Get item by type, name and tier
  InventoryItem? getItem(String type, String itemName, int tier) {
    try {
      return items.firstWhere(
        (item) => item.type == type && item.item == itemName && item.tier == tier,
      );
    } catch (e) {
      return null;
    }
  }

  /// Get item value or return 0 if not found
  int getItemValue(String type, String itemName, int tier) {
    final item = getItem(type, itemName, tier);
    return item?.value ?? 0;
  }
}