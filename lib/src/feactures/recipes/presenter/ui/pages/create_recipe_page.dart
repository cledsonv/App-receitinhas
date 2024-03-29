import 'package:app_receitas/src/core/global/global_variables.dart';
import 'package:app_receitas/src/core/widgets/cookie_text_field.dart';
import 'package:app_receitas/src/feactures/recipes/presenter/controller/create_recipe_controller.dart';
import 'package:app_receitas/src/feactures/recipes/presenter/ui/moleculs/create_additional_info.dart';
import 'package:app_receitas/src/feactures/recipes/presenter/ui/moleculs/create_back_end_safe_button.dart';
import 'package:app_receitas/src/feactures/recipes/presenter/ui/organisms/create_details_recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class CreateRecipePage extends StatefulWidget {
  static const route = '/create-recipe';
  const CreateRecipePage({super.key});

  @override
  State<CreateRecipePage> createState() => _CreateRecipePageState();
}

class _CreateRecipePageState extends State<CreateRecipePage> {
  final CreateRecipeController ct = di();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    ct.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              const SizedBox(height: 10),
              CreateBackAndSafeButton(ct: ct),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    ct.pickMultiMedia();
                  });
                },
                child: ct.listMultiMedia.isEmpty
                    ? Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.image_sharp),
                      )
                    : FlutterCarousel(
                        options: CarouselOptions(
                          height: 250,
                          showIndicator: true,
                          autoPlay: false,
                          viewportFraction: 1,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 500),
                          padEnds: false,
                        ),
                        items: ct.listMultiMedia
                            .map(
                              (e) => Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Image.file(e),
                                  IconButton(
                                    onPressed: () {
                                      ct.removeImage(e);
                                    },
                                    icon: const Icon(Icons.delete),
                                  )
                                ],
                              ),
                            )
                            .toList(),
                      ),
              ),
              const SizedBox(height: 20),
              CookieTextField.outline(
                hintText: 'Titulo da receita',
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                  topLeft: Radius.circular(16),
                ),
                controller: ct.titleController,
                validator: (value) {
                  if (value!.isEmpty && value.length < 3) {
                    return 'Escreva um titulo, com no minimo 3 letras';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CookieTextField.outline(
                hintText: 'Subtitulo da receita',
                controller: ct.subTitleController,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                  topLeft: Radius.circular(16),
                ),
              ),
              const SizedBox(height: 20),
              const CreateAdditionalInfo(),
              const SizedBox(height: 20),
              CreateDetailsRecipe(ct: ct),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
