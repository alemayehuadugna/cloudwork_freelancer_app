import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../router.dart';

class ForgetPasswordDisplay extends StatelessWidget {
  const ForgetPasswordDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: _ForgetPasswordForm(),
    );
  }
}

class _ForgetPasswordForm extends StatefulWidget {
  @override
  State<_ForgetPasswordForm> createState() => __ForgetPasswordFormState();
}

class __ForgetPasswordFormState extends State<_ForgetPasswordForm> {
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 130,
            // width: 145,
            child: ClipRRect(
              child: Image.asset('assets/images/check_email.jpg'),
              borderRadius: BorderRadius.circular(65.0),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
            child: Text(
              'Update Your Password',
              style: TextStyle(fontSize: 20),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 24, 0, 24),
            child: Text(
              'Enter your Phone or email address and select Send Email.',
              textAlign: TextAlign.center,
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Phone or Email",
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFdadce0), width: 0.8),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 30, 50, 15),
            child: ElevatedButton(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  minimumSize:
                      MaterialStateProperty.all(const Size.fromHeight(52)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)))),
              onPressed: () async {},
              child: const Text(
                "Send",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    context.goNamed(loginRouteName);
                  },
                  child: const Text("Remember Your Password?"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
