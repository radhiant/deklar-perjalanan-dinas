import 'controller.dart';

class FxControllerStore {
  static final Map<String, FxController> _controllers = {};

  static T putOrFind<T extends FxController>(T controller, {String? tag, bool save=true}) {

    String key = tag ?? controller.getTag();

    if (_controllers.containsKey(key)) {
      T controller = _controllers[key] as T;
      controller.save = controller.save && save;
      return controller;
    } else {
      return put(controller, tag: tag, save: save);
    }
  }

  static T put<T extends FxController>(T controller, {String? tag, bool save=true}) {
    String key = tag ?? controller.getTag();

    _controllers[key] = controller;
    controller.save = controller.save && save;

    return controller;
  }

  static void delete<T extends FxController>(T controller, {String? tag}){
    String key = tag ?? controller.getTag();

    _controllers.remove(key);
  }

  static void resetStore(){
    _controllers.clear();
  }

}
