import 'package:flutter_test/flutter_test.dart';
import 'package:prostate/src/observable.dart';

void main() {
  group('Observable', () {
    test('Initial value is set correctly', () {
      final observable = Observable<int>(10);
      expect(observable.value, 10);
    });

    test('Value updates and notifies listeners', () {
      final observable = Observable<int>(10);
      int? notifiedValue;

      observable.addListener((value) {
        notifiedValue = value;
      });

      observable.value = 20;

      expect(observable.value, 20);
      expect(notifiedValue, 20);
    });

    test('Does not notify listeners if value remains unchanged', () {
      final observable = Observable<int>(10);
      bool wasNotified = false;

      observable.addListener((_) {
        wasNotified = true;
      });

      observable.value = 10;

      expect(wasNotified, false);
    });

    test('Async value updates and notifies async listeners', () async {
      final observable = Observable<int>(10);
      int? notifiedValue;

      observable.addListener((value) {
        notifiedValue = value;
      });

      await observable.setValueAsync(Future.value(30));

      expect(observable.value, 30 );
      expect(notifiedValue, 30);
    });

    test('Listeners can be removed', () {
      final observable = Observable<int>(10);
      bool wasNotified = false;

      final listener = (int value) {
        wasNotified = true;
      };

      observable.addListener(listener);
      observable.removeListener(listener);

      observable.value = 20;

      expect(wasNotified, false);
    });

    test('Async listeners can be removed', () async {
      final observable = Observable<int>(10);
      bool wasNotified = false;

      final listener = (int value) {
        wasNotified = true;
      };

      observable.addListener(listener);
      observable.removeListener(listener);

      await observable.setValueAsync(Future.value(20));

      expect(wasNotified, false);
    });

    test('Dispose clears all listeners', () {
      final observable = Observable<int>(10);

      observable.addListener((_) {});
      observable.addListener((_) {});

      observable.dispose();

      expect(() => observable.value = 20, returnsNormally);
    });
  });
}
