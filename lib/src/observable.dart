class Observable<T> {
  T _value;
  final List<void Function(T)> _listeners = [];
  final List<void Function(T)> _asyncListeners = [];

  Observable(this._value);
  T get value => _value;

  set value(T newValue) {
    if (value != newValue) {
      _value = newValue;
          _notifyListener();
    }
  }
  Future<void> setValueAsync(Future<T> futureValue) async {
    final newValue = await futureValue;
    value = newValue;
    _notifyAsyncListeners();
  }

  void addListener(void Function(T) listener) {
    _listeners.add(listener);
  }
  void removeListener(void Function(T) listener) {
    _listeners.remove(listener);
  }
  void _notifyListener() {
    for (var listener in _listeners) {
      listener(_value);
    }
  }
  void _notifyAsyncListeners() async{
    for (var listener in _asyncListeners){
      listener(_value);
    }
  }
  void dispose() {
    _listeners.clear();
    _asyncListeners.clear();
  }
}