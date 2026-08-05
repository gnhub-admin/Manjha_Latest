import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../const.dart';
import '../models/models_model.dart';
import '../providers/models_provider.dart';
import '../widgets/text_widget.dart';

class ModelsDropDownWidget extends StatefulWidget {
  const ModelsDropDownWidget({super.key});

  @override
  State<ModelsDropDownWidget> createState() => _ModelsDropDownWidgetState();
}

class _ModelsDropDownWidgetState extends State<ModelsDropDownWidget> {
  String? currentModel;
  bool isFirstLoading = true;

  final ModelsController modelsController = Get.put(ModelsController());

  @override
  Widget build(BuildContext context) {
    currentModel = modelsController.getCurrentModel;
    return FutureBuilder<List<ModelsModel>>(
        future: modelsController.getAllModels(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              isFirstLoading == true) {
            isFirstLoading = false;
            return const FittedBox(
              child: SpinKitFadingCircle(
                color: Colors.lightBlue,
                size: 30,
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: TextWidget(label: snapshot.error.toString()),
            );
          }
          return snapshot.data == null || snapshot.data!.isEmpty
              ? const SizedBox.shrink()
              : FittedBox(
            child: DropdownButton(
              dropdownColor: scaffoldBackgroundColor,
              iconEnabledColor: Colors.white,
              items: List<DropdownMenuItem<String>>.generate(
                  snapshot.data!.length,
                      (index) => DropdownMenuItem(
                      value: snapshot.data![index].id,
                      child: TextWidget(
                        label: snapshot.data![index].id,
                        fontSize: 15,
                      ))),
              value: currentModel,
              onChanged: (value) {
                setState(() {
                  currentModel = value.toString();
                });
                modelsController.setCurrentModel(
                  value.toString(),
                );
              },
            ),
          );
        });
  }
}
