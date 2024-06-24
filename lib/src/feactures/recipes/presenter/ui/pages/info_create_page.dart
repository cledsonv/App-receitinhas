import 'package:app_receitas/src/core/widgets/feactures/cookie_button.dart';
import 'package:app_receitas/src/core/widgets/feactures/cookie_text.dart';
import 'package:app_receitas/src/feactures/recipes/presenter/controller/create_recipe_controller.dart';
import 'package:app_receitas/src/feactures/recipes/presenter/ui/atomic/custom_container.dart';
import 'package:app_receitas/src/feactures/recipes/presenter/ui/moleculs/info_container_difficulty_recipe.dart';
import 'package:app_receitas/src/feactures/recipes/presenter/ui/moleculs/info_container_portion.dart';
import 'package:app_receitas/src/feactures/recipes/presenter/ui/moleculs/info_container_time_prepared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InfoCreatePage extends StatefulWidget {
  final CreateRecipeController ct;
  const InfoCreatePage({super.key, required this.ct});

  @override
  State<InfoCreatePage> createState() => _InfoCreatePageState();
}

class _InfoCreatePageState extends State<InfoCreatePage> {
  CreateRecipeController get ct => widget.ct;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 32,
            child: Column(
              children: [
                const SizedBox(height: 10),
                CookieButton(
                  label: 'Voltar',
                  onPressed: () {
                    ct.pageController.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                ).back(context),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CookieText(
                        text: 'Personalize informações básicas',
                        typography: CookieTypography.title,
                      ),
                      const SizedBox(height: 10),
                      const CookieText(
                        text:
                            'Essas informações vão ajudar a indentificar coisas básicas da sua receita, então seja bem consiso.',
                      ),
                      const SizedBox(height: 20),
                      CustomContainer(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Visibility(
                              visible: ct.timePreparedRecipe.inMinutes > 0,
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/clock.svg',
                                    colorFilter: ColorFilter.mode(
                                      Theme.of(context).colorScheme.onPrimary,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  CookieText(
                                    text: ct.durationRecipeString,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/fire.svg',
                                  colorFilter: ColorFilter.mode(
                                    Theme.of(context).colorScheme.onPrimary,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                CookieText(text: ct.difficultyRecipeString)
                              ],
                            ),
                            const SizedBox(width: 16),
                            Visibility(
                              visible: ct.portion > 0,
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/pot.svg',
                                    colorFilter: ColorFilter.mode(
                                      Theme.of(context).colorScheme.onPrimary,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  CookieText(text: '${ct.portion} porções')
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.48,
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: ct.containerController,
                    children: [
                      InfoContainerTimePrepared(
                        ct: ct,
                        onChange: (val) {
                          setState(() {
                            widget.ct.timePreparedRecipe = val;
                            widget.ct.hourController.text =
                                val.inHours.toString();
                            widget.ct.minuteController.text =
                                (val.inMinutes % 60).toString();
                          });
                        },
                        onChangedHour: (value) {
                          setState(
                            () => widget.ct.timePreparedRecipe = Duration(
                              hours: value.isEmpty ? 0 : int.parse(value),
                              minutes:
                                  widget.ct.timePreparedRecipe.inMinutes % 60,
                            ),
                          );
                        },
                        onChangedMinute: (value) {
                          setState(() {
                            widget.ct.timePreparedRecipe = Duration(
                              hours: widget.ct.timePreparedRecipe.inHours,
                              minutes: value.isEmpty ? 0 : int.parse(value),
                            );
                          });
                        },
                      ),
                      InfoContainerDifficultyRecipe(
                        ct: ct,
                        onChanged: (e) {
                          setState(() {
                            widget.ct.difficultyRecipe = e;
                          });
                        },
                      ),
                      InfoContainerPortion(
                        ct: ct,
                        onChangedField: (value) {
                          ct.portion = int.tryParse(value) ?? 0;
                        },
                        onPressedIncrease: () {
                          setState(() {
                            ct.portion++;
                            ct.portionController.text = ct.portion.toString();
                          });
                        },
                        onPressedDecresead: () {
                          if (ct.portion > 0) {
                            ct.portion--;
                          }
                          setState(() {
                            ct.portionController.text = ct.portion.toString();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
