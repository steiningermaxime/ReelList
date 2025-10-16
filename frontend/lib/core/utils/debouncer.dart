import 'dart:async';

import 'package:flutter/foundation.dart';

class Debouncer {
  Debouncer({
    required this.duration,
  });

  final Duration duration;
  Timer? _timer;

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }

  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  void dispose() {
    cancel();
  }
}

class DebouncedFunction<T> {
  DebouncedFunction({
    required this.function,
    this.duration = const Duration(milliseconds: 300),
  });

  final Future<T> Function() function;
  final Duration duration;
  Timer? _timer;
  bool _isRunning = false;

  Future<T?> call() async {
    _timer?.cancel();

    final completer = Completer<T?>();

    _timer = Timer(duration, () async {
      if (_isRunning) {
        completer.complete(null);
        return;
      }

      _isRunning = true;
      try {
        final result = await function();
        completer.complete(result);
      } catch (e) {
        completer.completeError(e);
      } finally {
        _isRunning = false;
      }
    });

    return completer.future;
  }

  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  void dispose() {
    cancel();
  }
}

extension DebouncedCallback on VoidCallback {
  VoidCallback debounce([Duration duration = const Duration(milliseconds: 300)]) {
    Timer? timer;
    return () {
      timer?.cancel();
      timer = Timer(duration, this);
    };
  }
}
