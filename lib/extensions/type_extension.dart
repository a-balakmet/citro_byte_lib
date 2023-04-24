extension ObjectExt<T> on T {
  R let<R>(R Function(T that) op) => op(this);
}

extension Ext on Object? {
    void ifNotNull(Function() action) {
        if(this != null){
            action();
        }
    }
}