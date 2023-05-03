import 'package:flutter/material.dart';
import 'package:south_cinema/core/util/text_input_formatters.dart';
import 'package:south_cinema/features/reservations/presentation/widgets/sc_details_input_row.dart';

class SCPersonalDetailsColumn extends StatelessWidget {
  const SCPersonalDetailsColumn({
    super.key,
    required TextEditingController fullNameController,
    required TextEditingController emailController,
    required TextEditingController mobileNumberController,
  })  : _fullNameController = fullNameController,
        _emailController = emailController,
        _mobileNumberController = mobileNumberController;

  final TextEditingController _fullNameController;
  final TextEditingController _emailController;
  final TextEditingController _mobileNumberController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SCDetailsInputRow(
            label: 'Full name:',
            controller: _fullNameController,
            keyboardType: TextInputType.text,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SCDetailsInputRow(
            label: 'E-mail:',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: SCDetailsInputRow(
            label: 'Mobile number:',
            controller: _mobileNumberController,
            keyboardType: TextInputType.phone,
            formatters: mobileNumberFormatters,
          ),
        ),
      ],
    );
  }
}