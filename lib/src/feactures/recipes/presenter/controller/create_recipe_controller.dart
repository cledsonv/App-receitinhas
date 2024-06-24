import 'dart:io';
import 'package:app_receitas/src/feactures/onboarding/domain/enums/difficulty_recipe_enum.dart';
import 'package:app_receitas/src/feactures/recipes/domain/entities/ingredient_entity.dart';
import 'package:app_receitas/src/feactures/recipes/domain/entities/recipe_entity.dart';
import 'package:app_receitas/src/feactures/recipes/domain/repositories/recipe_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

class CreateRecipeController extends ChangeNotifier {
  var listMultiMedia = [];

  final RecipeRepository _repository;

  CreateRecipeController(this._repository);

  TextEditingController titleController = TextEditingController();
  TextEditingController subTitleController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController portionController = TextEditingController();
  List<IngredientsEntity> listIngredient = [];
  PageController pageController = PageController();
  PageController containerController = PageController();
  int currentPage = 0;
  Duration timePreparedRecipe = const Duration(hours: 0, minutes: 0);
  DifficultyRecipe difficultyRecipe = DifficultyRecipe.easy;
  int portion = 0;
  final quillInstructionController = QuillController.basic();
  final quillServerController = QuillController.basic();
  File? thumbImage;
  bool isWriteTime = false;
  final hourController = TextEditingController();
  final minuteController = TextEditingController();

  void init() {
    pageController = PageController(initialPage: 0);
    containerController = PageController(initialPage: 0);
  }

  void onChangedPage(int value) {
    currentPage = value;
    notifyListeners();
  }

  Future<void> pickThumb() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      thumbImage = File(image.path);
    }
    notifyListeners();
  }

  Future<void> pickMultiMedia() async {
    List<XFile> listImage = await ImagePicker().pickMultipleMedia();
    for (var image in listImage) {
      listMultiMedia.add(File(image.path));
    }

    notifyListeners();
  }

  bool showDialogDiscard() {
    return titleController.text.isNotEmpty ||
        subTitleController.text.isNotEmpty ||
        detailsController.text.isNotEmpty ||
        listMultiMedia.isNotEmpty;
  }

  void removeImage(File image) {
    listMultiMedia.removeWhere((e) => e == image);
    notifyListeners();
  }

  // void sendImage() async {
  //   FormData imageData = FormData();
  //   for (var i = 0; i < listMultiMedia.length; i++) {
  //     imageData.files.add(MapEntry('images',
  //         await MultipartFile.fromFile(listMultiMedia[i], filename: '$i.jpg')));
  //   }
  //   dio.post('$url/$path', data: imageData);
  // }

  void addIngredient(IngredientsEntity ingredient) {
    listIngredient.add(ingredient);
  }

  void deleteIngredient(IngredientsEntity ingredient) {
    listIngredient.remove(ingredient);
    notifyListeners();
  }

  Future<void> createRecipe() async {
    RecipeEntity recipe = RecipeEntity(
      title: titleController.text,
      subTitle: subTitleController.text,
      details: detailsController.text,
      serveFood: QuillDeltaToHtmlConverter(
        quillServerController.document.toDelta().toJson(),
      ).convert(),
      difficultyRecipe: DifficultyRecipe.easy,
      images: [],
      ingredients: [],
      instruction: QuillDeltaToHtmlConverter(
        quillInstructionController.document.toDelta().toJson(),
      ).convert(),
      portion: portion,
      timePrepared: timePreparedRecipe.inMinutes,
      thumb: '',
    );
    await _repository.createRecipe(recipe);
  }

  String get durationRecipeString {
    if (timePreparedRecipe.inMinutes == 0) {
      return '';
    }
    if (timePreparedRecipe.inHours == 0) {
      return '${timePreparedRecipe.inMinutes}min';
    }
    return '${timePreparedRecipe.inHours}h ${timePreparedRecipe.inMinutes.remainder(60)}min';
  }

  String get difficultyRecipeString {
    if (difficultyRecipe.name == 'easy') {
      return 'Fácil';
    }
    if (difficultyRecipe.name == 'medium') {
      return 'Médio';
    }

    return 'Difícil';
  }
}
