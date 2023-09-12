import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../feed/pages/feed_page.dart';

class LoginPage2 extends StatefulWidget {
  const LoginPage2({super.key});

  @override
  State<LoginPage2> createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {

  bool showPassword = false;

  changePasswordVisibility(){
    setState(() {
      showPassword = !showPassword;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:
      Column(
          children: [
          const SizedBox(height:150),
      const Center(
        child: Text(
          "Finstagram",
          style: TextStyle(
            fontFamily: "bill",
            fontSize: 50,
            color: Colors.black,
          ),
        ),
      ),
            const SizedBox(height: 24,),
            Container(
              width: 325,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black12,
                border: Border.all(
                  color: const Color(0xFFC5C5C5),
                )
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Phone number, email or username",
                  hintStyle: const TextStyle(
                    color: Color(0xFF848484),
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                  ),
                  contentPadding: const EdgeInsets.all(12),
                  isDense: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)
                  ),
                  disabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(
                      color: Color(0xFFEBF0FF),
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(
                      color: Color(0xFFEBF0FF),
                    ),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(
                      color: Color(0xFFEBF0FF),
                    ),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(
                      color: Color(0xFFEBF0FF),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14,),
            Container(
              width: 325,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black12,
                border: Border.all(
                  color: const Color(0xFFC5C5C5),
                )
              ),
              child: TextField(
                obscureText: !showPassword,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: changePasswordVisibility,
                    child: const Icon(Icons.remove_red_eye),
                  ),
                  hintText: "Password",
                  hintStyle: const TextStyle(
                    color: Color(0xFF848484),
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                  ),
                  contentPadding: const EdgeInsets.all(12),
                  isDense: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)
                  ),
                  disabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(
                      color: Color(0xFFEBF0FF),
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(
                      color: Color(0xFFEBF0FF),
                    ),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(
                      color: Color(0xFFEBF0FF),
                    ),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(
                      color: Color(0xFFEBF0FF),
                    ),
                  ),
                ),
              ),
            ),
             const SizedBox(height: 14,),
             Center(
              child: Container(
                height: 40,
                width: 320,
                decoration: BoxDecoration(
                    color: const Color(0xFF1877F2),
                    borderRadius: BorderRadius.circular(5),
                ),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => const FeedPage()),
                    );
                  },
                  child: const Center(
                    child: Text(
                      "sign up",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              )
             ),
             const SizedBox(height: 12,),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                      "Already have an account?",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6D6D6D)
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context) => const FeedPage()),
                      );
                    },
                    child: const Text(
                      "Sign in",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Color(0xFF23244F)
                      ),
                    ),
                  )
                ],
              ),
            const SizedBox(height: 32,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(
                    indent: 20.0,
                    endIndent: 10.0,
                    thickness: 1,
                  ),
                ),
                Text(
                  "OR",
                  style: TextStyle(color: Colors.blueGrey),
                ),
                Expanded(
                  child: Divider(
                    indent: 10.0,
                    endIndent: 20.0,
                    thickness: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32,),
            InkWell(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context) => const FeedPage()),
                );
              },
              child: Center(
                child: Container(
                  height: 42,
                  width: 315,
                  decoration: BoxDecoration(
                      color: const Color(0xFF1877F2),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 68,),
                      SvgPicture.asset(
                          "icons/login/facebook.svg"
                      ),
                      const SizedBox(width: 8,),
                      const Text(
                        "Sign Up With Facebook",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),

          ]
                ),

    );
  }
}
