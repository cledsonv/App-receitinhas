import 'package:app_receitas/src/core/widgets/feactures/cookie_button.dart';
import 'package:app_receitas/src/core/widgets/feactures/cookie_text.dart';
import 'package:app_receitas/src/feactures/recipes/presenter/controller/create_recipe_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class InfoContainerPortion extends StatelessWidget {
  final CreateRecipeController ct;
  final Function(String) onChangedField;
  final Function() onPressedDecresead;
  final Function() onPressedIncrease;
  const InfoContainerPortion(
      {super.key,
      required this.ct,
      required this.onChangedField,
      required this.onPressedDecresead,
      required this.onPressedIncrease});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          CookieText(
            text: 'Porções',
            typography: CookieTypography.button,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          const SizedBox(height: 20),
          CookieText(
            text: 'Quantas porções sua\nreceita pode servir?',
            typography: CookieTypography.title,
            color: Theme.of(context).colorScheme.onSecondary,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/pot.svg',
                height: 70,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onSecondary,
                  BlendMode.srcIn,
                ),
              ),
              IconButton(
                onPressed: onPressedDecresead,
                color: Theme.of(context).colorScheme.onSecondary,
                icon: const Icon(
                  Icons.remove_circle_rounded,
                  size: 30,
                ),
              ),
              SizedBox(
                width: 60,
                child: TextField(
                  controller: ct.portionController,
                  onChanged: onChangedField,
                  maxLength: 3,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    counterText: '',
                    hintStyle: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: onPressedIncrease,
                color: Theme.of(context).colorScheme.onSecondary,
                icon: const Icon(
                  Icons.add_circle_rounded,
                  size: 30,
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: CookieButton(
                  label: 'Voltar',
                  onPressed: () {
                    ct.containerController.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: CookieButton(
                  label: 'Salvar',
                  onPressed: () {
                    if (ct.portion > 0) {
                      ct.pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    } else {
                      final snackBar = SnackBar(
                        content: const CookieText(
                            text:
                                'Informe quantas porções sua receita pode servir'),
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
