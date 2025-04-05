import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import '../models/inventory.dart';

class InventoryService {
  static final InventoryService _instance = InventoryService._internal();
  Inventory? _inventory;
  
  // Singleton pattern
  factory InventoryService() {
    return _instance;
  }
  
  InventoryService._internal();
  
  /// Get the inventory instance
  Future<Inventory> getInventory() async {
    if (_inventory != null) {
      return _inventory!;
    }
    
    // Load inventory from file
    await loadInventory();
    return _inventory!;
  }
  
  /// Load inventory from JSON file
  Future<void> loadInventory() async {
    try {
      // In a real app, this would load from local storage or Google Drive
      // For now, we'll load from the bundled JSON file
      final jsonString = await rootBundle.loadString('assets/data/inventory.json');
      _inventory = Inventory.fromJsonString(jsonString);
    } catch (e) {
      // If file doesn't exist or has errors, create an empty inventory
      _inventory = Inventory(items: []);
      print('Error loading inventory: $e');
    }
  }
  
  /// Save inventory to JSON file
  Future<void> saveInventory() async {
    if (_inventory == null) return;
    
    try {
      // In a real app, this would save to local storage or Google Drive
      final jsonString = _inventory!.toJsonString();
      // For demonstration purposes only
      print('Inventory saved: $jsonString');
    } catch (e) {
      print('Error saving inventory: $e');
    }
  }
  
  /// Sync inventory with Google Drive
  Future<bool> syncWithGoogleDrive() async {
    // This would be implemented with Google Drive API
    // For now, just simulate a successful sync
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
  
  /// Update an item in the inventory
  Future<void> updateItem(String type, String itemName, int tier, int newValue) async {
    if (_inventory == null) await loadInventory();
    
    final item = _inventory!.getItem(type, itemName, tier);
    if (item != null) {
      // Find the index of the item
      final index = _inventory!.items.indexOf(item);
      // Create a new item with updated value
      final updatedItem = InventoryItem(
        type: type,
        item: itemName,
        tier: tier,
        value: newValue,
      );
      // Replace the old item with the updated one
      _inventory!.items[index] = updatedItem;
      // Save the updated inventory
      await saveInventory();
    }
  }
}