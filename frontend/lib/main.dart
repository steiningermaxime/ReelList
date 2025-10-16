import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'data/local/local_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final localStore = LocalStore();
  await localStore.init();
  
  runApp(
    ProviderScope(
      overrides: [
        localStoreProvider.overrideWithValue(localStore),
      ],
      child: const ReelListApp(),
    ),
  );
}