import 'package:app_receitas/src/core/widgets/cookie_text.dart';
import 'package:app_receitas/src/feactures/recipes/presenter/ui/atomic/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ViewIntroduceRecipe extends StatelessWidget {
  const ViewIntroduceRecipe({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CookieText(
          text: 'Frango ao Curry com Arroz Basmati',
          typography: CookieTypography.title,
        ),
        const SizedBox(height: 20),
        const CookieText(
          text:
              'Prepare-se para uma viagem de sabores com nossa receita de Frango ao Curry com Arroz Basmati.',
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomContainer(
              child: Row(
                children: [
                  Column(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/clock.svg',
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.onPrimary,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const CookieText(text: '5 min')
                    ],
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
                      const CookieText(text: 'Dificil')
                    ],
                  ),
                  const SizedBox(width: 16),
                  Column(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/pot.svg',
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.onPrimary,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const CookieText(text: '5 porções')
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite,
                  color: Theme.of(context).colorScheme.primary,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
