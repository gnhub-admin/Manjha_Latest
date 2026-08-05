import 'package:get/get.dart';
import '../models/models_model.dart';
import '../services/api_service.dart';

class ModelsController extends GetxController {
  // String currentModel = "text-davinci-003";
  String currentModel = "gpt-3.5-turbo";

  String get getCurrentModel {
    return currentModel;
  }

  void setCurrentModel(String newModel) {
    currentModel = newModel;
  }

  List<ModelsModel> modelsList = [];

  List<ModelsModel> get getModelsList {
    return modelsList;
  }

  Future<List<ModelsModel>> getAllModels() async {
    modelsList = await ApiService.getModels();
    return modelsList;
  }
}
