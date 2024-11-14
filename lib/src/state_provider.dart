part of prostate;

class StateProvider extends InheritedWidget{
  final StateManager stateManager;

  const StateProvider({
    super.key,
    required super.child,
    required this.stateManager,
});

  static StateManager of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<StateProvider>();
    if (provider == null) throw FlutterError("StateProvider can't found context");
    return provider.stateManager;
  }

  @override
  bool updateShouldNotify(StateProvider oldWidget) {
    return stateManager != oldWidget.stateManager;
  }

}