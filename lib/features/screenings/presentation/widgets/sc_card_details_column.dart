import 'package:flutter/material.dart';
import 'package:south_cinema/core/text_input_formatters.dart';
import 'package:south_cinema/features/reservations/presentation/widgets/sc_details_input_row.dart';

class SCCardDetailsColumn extends StatelessWidget {
  const SCCardDetailsColumn({
    super.key,
    required TextEditingController cardFullNameController,
    required TextEditingController cardNumberController,
    required TextEditingController cardExpiryDateController,
    required TextEditingController cardCVVController,
  })  : _cardFullNameController = cardFullNameController,
        _cardNumberController = cardNumberController,
        _cardExpiryDateController = cardExpiryDateController,
        _cardCVVController = cardCVVController;

  final TextEditingController _cardFullNameController;
  final TextEditingController _cardNumberController;
  final TextEditingController _cardExpiryDateController;
  final TextEditingController _cardCVVController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SCDetailsInputRow(
            label: 'Full name:',
            controller: _cardFullNameController,
            keyboardType: TextInputType.text,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SCDetailsInputRow(
            label: 'Card number:',
            controller: _cardNumberController,
            keyboardType: TextInputType.number,
            formatters: cardNumberFormatters,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 90,
              child: SCDetailsInputRow(
                label: 'Exp. date:',
                controller: _cardExpiryDateController,
                keyboardType: TextInputType.number,
                formatters: cardExpiryDateFormatters,
                textFieldWidth: 36,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            SizedBox(
              width: 60,
              child: SCDetailsInputRow(
                label: 'CVV:',
                controller: _cardCVVController,
                keyboardType: TextInputType.number,
                formatters: cardCVVCodeFormatters,
                textFieldWidth: 31,
              ),
            ),
          ],
        ),
      ],
    );
  }
}