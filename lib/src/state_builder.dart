part of prostate;

class StateBuilder<T> extends StatefulWidget {
  final String stateKey;
  final Widget Function(BuildContext context, T? value) builder;
  final T? defaultValue;

  const StateBuilder({
    super.key,
    required this.stateKey,
    required this.builder,
    this.defaultValue,
  });

  @override
  State<StateBuilder<T>> createState() => _StateBuilderState<T>();
}

class _StateBuilderState<T> extends State<StateBuilder<T>> {
  late StateManager _stateManager;
  T? _value;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _stateManager = StateProvider.of(context);
    _value = _stateManager.getState<T>(widget.stateKey,
        defaultValue: widget.defaultValue);
    _stateManager.addStateListener<T>(widget.stateKey, _onStateChanged);
  }

  void _onStateChanged(T newValue) {
    if (mounted) {
      setState(() {
        _value = newValue;
      });
    }
  }

  @override
  void dispose() {
    _stateManager.removeStateListener<T>(widget.stateKey, _onStateChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _value);
  }
}