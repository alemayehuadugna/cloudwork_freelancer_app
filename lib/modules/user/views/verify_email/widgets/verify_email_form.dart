import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'widgets.dart';

class VerifyEmailForm extends StatefulWidget {
  const VerifyEmailForm({Key? key}) : super(key: key);

  @override
  State<VerifyEmailForm> createState() => _VerifyEmailFormState();
}

class _VerifyEmailFormState extends State<VerifyEmailForm> {
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveWrapper.of(context).isMobile;
    return Container(
      padding: const EdgeInsets.fromLTRB(40, 48, 40, 36),
      width: isMobile ? null : 448,
      decoration: isMobile
          ? null
          : BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).cardColor,
              border: Border.all(width: 0.7, color: const Color(0xffdadce0)),
            ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 160,
              child: ClipRRect(
                child: SvgPicture.asset("assets/icons/new_email.svg"),
                borderRadius: BorderRadius.circular(60.0),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Text(
                'Verify Your Email',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 24, 0, 24),
              child: Text(
                'Please enter the OTP sent on your registered Email Address.',
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OtpInput(_fieldOne, true),
                OtpInput(_fieldTwo, false),
                OtpInput(_fieldThree, false),
                OtpInput(_fieldFour, false),
              ],
            ),
            VerifyButton(
              fieldOne: _fieldOne,
              fieldTwo: _fieldTwo,
              fieldThree: _fieldThree,
              fieldFour: _fieldFour,
              formKey: _formKey,
            ),
            const ResendButton()
          ],
        ),
      ),
    );
  }
}
