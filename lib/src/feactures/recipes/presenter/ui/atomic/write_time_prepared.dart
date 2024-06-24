import 'package:app_receitas/src/core/widgets/cookie_export.dart';
import 'package:app_receitas/src/feactures/recipes/presenter/validator/minute_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class WriteTimePrepared extends StatefulWidget {
  final TextEditingController minuteController;
  final TextEditingController hourController;
  final void Function(String) onChangedHour;
  final void Function(String) onChangedMinute;
  const WriteTimePrepared(
      {super.key,
      required this.minuteController,
      required this.hourController,
      required this.onChangedHour,
      required this.onChangedMinute});

  @override
  State<WriteTimePrepared> createState() => _WriteTimePreparedState();
}

class _WriteTimePreparedState extends State<WriteTimePrepared> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            SizedBox(
              width: 80,
              child: CookieTextField(
                controller: widget.hourController,
                onChanged: widget.onChangedHour,
                textAlign: TextAlign.center,
                style: GoogleFonts.jetBrainsMono(
                  textStyle: TextStyle(
                    fontSize: 30,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  LengthLimitingTextInputFormatter(2),
                ],
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 10),
            CookieText(
              text: 'Horas',
              color: Theme.of(context).colorScheme.onSecondary,
              typography: CookieTypography.button,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 40),
          child: CookieText(
            text: ':',
            typography: CookieTypography.title,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        Column(
          children: [
            SizedBox(
              width: 80,
              child: CookieTextField(
                controller: widget.minuteController,
                onChanged: widget.onChangedMinute,
                textAlign: TextAlign.center,
                style: GoogleFonts.jetBrainsMono(
                  textStyle: TextStyle(
                    fontSize: 30,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  LengthLimitingTextInputFormatter(2),
                  MinuteTextInputFormatter(),
                ],
              ),
            ),
            const SizedBox(height: 10),
            CookieText(
              text: 'Minutos',
              color: Theme.of(context).colorScheme.onSecondary,
              typography: CookieTypography.button,
            ),
          ],
        ),
      ],
    );
  }
}
