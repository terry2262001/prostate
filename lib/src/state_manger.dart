part of prostate;

class StateManager {
  final Map<String, Observable<dynamic>> _states = {};
  final _stateHistory = <String, List<dynamic>>{}; // For state history tracking

  T? getState<T>(String key, {T? defaultValue}) {
    if (_states.containsKey(key)) {
      final value = _states[key]?.value;
      if (value is T) {
        return value;
      }
      throw FlutterError(
        "Type mismatch: Expected type $T but found ${value.runtimeType}",
      );
    }
    if (defaultValue != null) {
      _states[key] = Observable<T>(defaultValue);
      return defaultValue;
    }
    return null;
  }


  void setState<T>(String key, T value) {
    if (_states.containsKey(key)) {
      _states[key]?.value = value;
    }else {
      _states[key] = Observable<T>(value);
    }
    _addToHistory(key,value);
  }

  Future<void> setStateAsync<T>(String key, Future<T> futureValue) async {
    if(!_states.containsKey(key)) {
      final initialValue = await futureValue;
      _states[key] = Observable<T>(initialValue);
    } else{
      final state = _states[key];
      if(state is Observable<T>) {
        await state.setValueAsync(futureValue);
      } else {
        throw StateError(
          'Type mismatch: Cannot set async value of type $T for state of type ${state.runtimeType}',
        );
      }
    }
  }

  void setNestedState(String key, dynamic value, List<String> path){
    var currentState = getState<Map<String, dynamic>>(key);
    if(currentState == null) {
      currentState = <String, dynamic>{};
      setState(key, currentState);
    }
    var current = currentState;
    for(var i = 0; i < path.length -1; i++){
      if(current[path[i]] == null) {
        current[path[i]] = <String, dynamic>{};
      }
      current = current[path[i]] as Map<String, dynamic>;
    }
    current[path.last] = value;
    setState(key, currentState);

  }

  void resetState(String key) {
    for (var state in _states.values) {
      state.dispose();
    }
    _states.clear();
    _stateHistory.clear();
  }

  void clearAllState() {
    _states.clear();
  }

  void addStateListener<T>(String key, void Function(T) listener) {
    if (_states.containsKey(key)) {
      final state = _states[key];
      if (state is Observable<T>) {
        state.addListener(listener);
      } else {
        throw StateError(
          'Type mismatch: State at key "$key" is of type ${state.runtimeType}, '
              'but listener expects type Observable<$T>',
        );
      }
    }
  }

  void removeStateListener<T>(String key, void Function(T) listener) {
    if (_states.containsKey(key)) {
      final state = _states[key];
      if (state is Observable<T>) {
        state.removeListener(listener);
      }
    }
  }

  //State history tracking
  void _addToHistory(String key, dynamic value) {
    _stateHistory.putIfAbsent(key, () => []).add(value);
  }
  List<dynamic>? getStateHistory(String key) {
    return _stateHistory[key];
  }

}