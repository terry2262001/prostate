import 'package:flutter_test/flutter_test.dart';
import 'package:prostate/prostate.dart';

void main() {
  group('StateManager', () {
    late StateManager stateManager;

    setUp(() {
      stateManager = StateManager();
    });

    test('Set and get state', () {
      stateManager.setState<int>('counter', 5);

      final state = stateManager.getState<int>('counter');

      expect(state, 5);
    });

    test('State notifies listeners on update', () {
      stateManager.setState<int>('counter', 5);

      int? notifiedValue;
      stateManager.addStateListener<int>('counter', (value) {
        notifiedValue = value;
      });

      stateManager.setState<int>('counter', 10);

      expect(notifiedValue, 10);
    });

    test('Throws error if type mismatch when adding listener', () {
      stateManager.setState<int>('counter', 5);

      expect(
            () => stateManager.addStateListener<String>('counter', (_) {}),
        throwsA(isA<StateError>()),
      );
    });

    test('Reset state removes value and listeners', () {
      stateManager.setState<int>('counter', 5);

      stateManager.resetState('counter');

      expect(stateManager.getState<int>('counter'), isNull);
    });

    test('Clearing all states works', () {
      stateManager.setState<int>('counter', 5);
      stateManager.setState<String>('username', 'John');

      stateManager.clearAllState();

      expect(stateManager.getState<int>('counter'), isNull);
      expect(stateManager.getState<String>('username'), isNull);
    });

    test('Set nested state updates the correct path', () {
      stateManager.setNestedState('settings', 'dark', ['theme']);

      final state = stateManager.getState<Map<String, dynamic>>('settings');

      expect(state, {'theme': 'dark'});
    });

    test('Set nested state works with deeper paths', () {
      stateManager.setNestedState('settings', 'dark', ['appearance', 'theme']);

      final state = stateManager.getState<Map<String, dynamic>>('settings');

      expect(state, {
        'appearance': {'theme': 'dark'}
      });
    });

    test('Get state history tracks updates', () {
      stateManager.setState<int>('counter', 5);
      stateManager.setState<int>('counter', 10);

      final history = stateManager.getStateHistory('counter');

      expect(history, [5, 10]);
    });

    test('Set async state updates the value', () async {
      await stateManager.setStateAsync<int>('counter', Future.value(15));

      final state = stateManager.getState<int>('counter');

      expect(state, 15);
    });

  });
}
