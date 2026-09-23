import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/menu_item.dart';

class MenuData {
  static final List<MenuItem> defaultItems = [
    const MenuItem(
      id: "meal-1",
      name: "Classic Crispy Chicken Burger",
      category: "Meals",
      price: 8.99,
      description: "Crispy golden fried chicken breast, spicy house mayo, fresh lettuce, and dill pickles in a toasted brioche bun.",
      imageUrl: "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=600&auto=format&fit=crop&q=80",
      rating: 4.8,
      calories: 680,
      prepTime: "10-12 min",
    ),
    const MenuItem(
      id: "meal-2",
      name: "Smoky BBQ Bacon Cheeseburger",
      category: "Meals",
      price: 9.99,
      description: "100% Angus beef patty topped with crispy smoked bacon, melted sharp cheddar, caramelized onions, and smoky BBQ glaze.",
      imageUrl: "https://images.unsplash.com/photo-1550547660-d9450f859349?w=600&auto=format&fit=crop&q=80",
      rating: 4.9,
      calories: 780,
      prepTime: "12-15 min",
    ),
    const MenuItem(
      id: "meal-3",
      name: "Mediterranean Veggie Grain Bowl",
      category: "Meals",
      price: 8.49,
      description: "Fluffy warm quinoa, crisp cucumbers, cherry tomatoes, kalamata olives, creamy feta cheese, and herbal tzatziki sauce.",
      imageUrl: "https://images.unsplash.com/photo-1540420773420-3366772f4999?w=600&auto=format&fit=crop&q=80",
      rating: 4.7,
      calories: 480,
      prepTime: "8-10 min",
    ),
    const MenuItem(
      id: "meal-4",
      name: "Spicy Teriyaki Chicken Rice Bowl",
      category: "Meals",
      price: 9.49,
      description: "Grilled marinated chicken glazed in spicy teriyaki reduction, steamed jasmine rice, wok-tossed broccoli, and toasted sesame seeds.",
      imageUrl: "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=600&auto=format&fit=crop&q=80",
      rating: 4.8,
      calories: 620,
      prepTime: "10-14 min",
    ),
    const MenuItem(
      id: "bev-1",
      name: "Iced Vanilla Oat Latte",
      category: "Beverages",
      price: 4.49,
      description: "Smooth double espresso shot poured over chilled creamy oat milk and infused with artisanal Madagascar vanilla bean syrup.",
      imageUrl: "https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=600&auto=format&fit=crop&q=80",
      rating: 4.9,
      calories: 160,
      prepTime: "3-5 min",
    ),
    const MenuItem(
      id: "bev-2",
      name: "Sparkling Strawberry Mint Lemonade",
      category: "Beverages",
      price: 3.99,
      description: "Freshly squeezed Meyer lemons, crushed organic strawberries, fresh garden mint, and sparkling mountain spring water.",
      imageUrl: "https://images.unsplash.com/photo-1621263764928-df1444c5e859?w=600&auto=format&fit=crop&q=80",
      rating: 4.6,
      calories: 120,
      prepTime: "3-4 min",
    ),
    const MenuItem(
      id: "bev-3",
      name: "Organic Ceremonial Matcha Latte",
      category: "Beverages",
      price: 4.99,
      description: "Whisked Japanese ceremonial grade Uji matcha paired with steamed almond milk and a subtle touch of organic blue agave.",
      imageUrl: "https://images.unsplash.com/photo-1536256263959-770b48d82b0a?w=600&auto=format&fit=crop&q=80",
      rating: 4.7,
      calories: 140,
      prepTime: "4-6 min",
    ),
    const MenuItem(
      id: "snack-1",
      name: "Seasoned Truffle & Herb Fries",
      category: "Snacks",
      price: 4.99,
      description: "Crispy hand-cut russet potatoes tossed in black truffle oil, freshly grated parmesan cheese, and fine Italian parsley.",
      imageUrl: "https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=600&auto=format&fit=crop&q=80",
      rating: 4.9,
      calories: 390,
      prepTime: "6-8 min",
    ),
    const MenuItem(
      id: "snack-2",
      name: "Golden Mozzarella Sticks (6 pcs)",
      category: "Snacks",
      price: 5.49,
      description: "Stretchy whole milk mozzarella wrapped in herb-seasoned breadcrumbs, fried crisp and served with zesty marinara dip.",
      imageUrl: "https://images.unsplash.com/photo-1531749668029-2db88e4276c7?w=600&auto=format&fit=crop&q=80",
      rating: 4.8,
      calories: 440,
      prepTime: "5-7 min",
    ),
    const MenuItem(
      id: "snack-3",
      name: "Warm Cinnamon Sugar Pretzel Bites",
      category: "Snacks",
      price: 4.29,
      description: "Freshly baked soft pretzel nuggets tossed in sweet cinnamon sugar butter, served with warm cream cheese frosting dip.",
      imageUrl: "https://images.unsplash.com/photo-1509440159596-0249088772ff?w=600&auto=format&fit=crop&q=80",
      rating: 4.9,
      calories: 350,
      prepTime: "4-6 min",
    ),
  ];

  static Future<List<MenuItem>> loadMenuItems() async {
    try {
      final jsonString = await rootBundle.loadString('assets/data/menu.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((item) => MenuItem.fromJson(item)).toList();
    } catch (e) {
      // Fallback to built-in items if asset bundle is not yet mounted in test
      return List.from(defaultItems);
    }
  }
}
