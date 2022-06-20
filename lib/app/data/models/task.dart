import 'dart:convert';

import 'package:flutter/foundation.dart';

class Task {
  final String title;
  final int icon;
  final String color;
  final List<dynamic>? todos;
  Task({
    required this.title,
    required this.icon,
    required this.color,
    this.todos,
  });

  Task copyWith({
    String? title,
    int? icon,
    String? color,
    List<dynamic>? todos,
  }) {
    return Task(
      title: title ?? this.title,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      todos: todos ?? this.todos,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'icon': icon,
      'color': color,
      'todos': todos,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] ?? '',
      icon: map['icon']?.toInt() ?? 0,
      color: map['color'] ?? '',
      todos: List<dynamic>.from(map['todos'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Task(title: $title, icon: $icon, color: $color, todos: $todos)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Task &&
        other.title == title &&
        other.icon == icon &&
        other.color == color;
  }

  @override
  int get hashCode {
    return title.hashCode ^ icon.hashCode ^ color.hashCode ^ todos.hashCode;
  }
}
