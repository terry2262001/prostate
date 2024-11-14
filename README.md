
# State Management Package Documentation

## Overview
This package provides a custom state management solution for Flutter applications without relying on external packages.  
It supports synchronous and asynchronous state updates, nested state management, and performance optimization.

---

## Getting Started
### Add Get to your pubspec.yaml file:
```
dependencies:
  prostate:
```  
### Import get in files that it will be used:
Import the necessary files into your Flutter project:

```dart
import 'package:prostate/prostate.dart';
```  

### Initialize a `StateManager` instance
```dart
final stateManager = StateManager();
```  

---

## Core Features and Usage

### Initialize State
```dart
stateManager.setState('counter', 0);
```  

### Access State
Retrieve the current value of a state by its key:
```dart
final counter = stateManager.getState<int>('counter');
```  

### Update State Synchronously
```dart
stateManager.setState('counter', (counter ?? 0) + 1);
```  

### Update State Asynchronously
```dart
stateManager.setStateAsync('counter', Future.delayed(Duration(seconds: 2), () => 100));
```  

### Listen to State Changes
Add a listener to observe changes in a state:
```dart
stateManager.addStateListener<int>('counter', (newValue) {
  print('Counter updated: $newValue');
});
```  

### Remove Listeners
```dart
stateManager.removeStateListener<int>('counter', listenerFunction);
```  

### Nested State Management
Manage deeply nested structures:
```dart
stateManager.setNestedState('userProfile', 'newName', ['personalInfo', 'name']);
```  

### UI Updates with `StateBuilder`
```dart
StateBuilder<int>(
  stateKey: 'counter',
  builder: (context, value) {
    return Text('Counter: ${value ?? 0}');
  },
);
```  

### Reset or Clear States
Reset a specific state or all states:
```dart
stateManager.resetState('counter');
stateManager.clearAllStates();
```  

---

## Example Usage

A complete example integrating synchronous and asynchronous updates:

```dart
import 'package:flutter/material.dart';
final stateManager = StateManager();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CounterScreen(),
    );
  }
}

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    stateManager.setState('counter', 0);

    return Scaffold(
      appBar: AppBar(title: Text('State Manager Demo')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StateBuilder<int>(
            stateKey: 'counter',
            builder: (context, value) {
              return Text('Counter: ${value ?? 0}', style: TextStyle(fontSize: 24));
            },
          ),
          ElevatedButton(
            onPressed: () {
              final counter = stateManager.getState<int>('counter') ?? 0;
              stateManager.setState('counter', counter + 1);
            },
            child: Text('Increment'),
          ),
          ElevatedButton(
            onPressed: () async {
              await stateManager.setStateAsync(
                'counter',
                Future.delayed(Duration(seconds: 2), () => 100),
              );
            },
            child: Text('Set Async'),
          ),
        ],
      ),
    );
  }
}
```  

---

## Hướng dẫn sử dụng (Tiếng Việt)

### Tổng quan
Package này cung cấp giải pháp quản lý state tùy chỉnh cho các ứng dụng Flutter mà không cần phụ thuộc vào các package bên ngoài.  
Package hỗ trợ cập nhật state đồng bộ, bất đồng bộ, quản lý state dạng nested và tối ưu hiệu suất.

---

### Bắt đầu sử dụng

#### Thêm package vào dự án của bạn
Import các file cần thiết vào dự án Flutter:
```dart
import 'lib/src/observable.dart';
import 'lib/src/state_manager.dart';
import 'lib/src/state_builder.dart';
```  

#### Khởi tạo một đối tượng `StateManager`
```dart
final stateManager = StateManager();
```  

---

## Chức năng chính và cách sử dụng

### Khởi tạo state
```dart
stateManager.setState('counter', 0);
```  

### Truy xuất state
Lấy giá trị hiện tại của state theo key:
```dart
final counter = stateManager.getState<int>('counter');
```  

### Cập nhật state đồng bộ
```dart
stateManager.setState('counter', (counter ?? 0) + 1);
```  

### Cập nhật state bất đồng bộ
```dart
stateManager.setStateAsync('counter', Future.delayed(Duration(seconds: 2), () => 100));
```  

### Lắng nghe thay đổi của state
Thêm listener để quan sát thay đổi:
```dart
stateManager.addStateListener<int>('counter', (newValue) {
  print('Giá trị counter đã thay đổi: $newValue');
});
```  

### Xóa listener
```dart
stateManager.removeStateListener<int>('counter', listenerFunction);
```  

### Quản lý state dạng nested
Quản lý cấu trúc dữ liệu phức tạp:
```dart
stateManager.setNestedState('userProfile', 'newName', ['personalInfo', 'name']);
```  

### Cập nhật UI với `StateBuilder`
```dart
StateBuilder<int>(
  stateKey: 'counter',
  builder: (context, value) {
    return Text('Counter: ${value ?? 0}');
  },
);
```  

### Reset hoặc xóa state
```dart
stateManager.resetState('counter');
stateManager.clearAllStates();
```  

---

### Ví dụ sử dụng

Ví dụ hoàn chỉnh:

```dart
import 'package:flutter/material.dart';
final stateManager = StateManager();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CounterScreen(),
    );
  }
}

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    stateManager.setState('counter', 0);

    return Scaffold(
      appBar: AppBar(title: Text('Demo State Manager')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StateBuilder<int>(
            stateKey: 'counter',
            builder: (context, value) {
              return Text('Counter: ${value ?? 0}', style: TextStyle(fontSize: 24));
            },
          ),
          ElevatedButton(
            onPressed: () {
              final counter = stateManager.getState<int>('counter') ?? 0;
              stateManager.setState('counter', counter + 1);
            },
            child: Text('Tăng giá trị'),
          ),
          ElevatedButton(
            onPressed: () async {
              await stateManager.setStateAsync(
                'counter',
                Future.delayed(Duration(seconds: 2), () => 100),
              );
            },
            child: Text('Cập nhật bất đồng bộ'),
          ),
        ],
      ),
    );
  }
}
```  

---

### Summary
This documentation provides both English and Vietnamese guides for the custom Flutter state management package.
