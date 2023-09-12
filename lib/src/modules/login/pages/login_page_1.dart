import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/src/modules/login/pages/login_page_2.dart';

import '../../feed/pages/feed_page.dart';

class LoginPage1 extends StatelessWidget {
  const LoginPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
         Column(
           children: [
             const SizedBox(height:150),
             const Center(
               child: Text(
                 "Finstagram",
                 style: TextStyle(
                   fontFamily: "bill",
                   fontSize: 67,
                   color: Colors.black,
                 ),
               ),
             ),
             const SizedBox(height: 24,),
             const Center(
               child:Text(
                   "Sign up to see photos videos and reels from your friends.",
                 style: TextStyle(
                   fontSize: 10,
                   fontWeight: FontWeight.w500,
                   color: Color(0xFF3A3A3A),
                 ),
               ),
             ),
             const SizedBox(height: 100,),
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
                           "Continue as shalini ",
                         style: TextStyle(color: Colors.white),
                       )
                     ],
                   ),
                 ),
               ),
             ),
             const SizedBox(height: 46,),
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
             const SizedBox(height: 46,),
             InkWell(
               onTap: (){
                 Navigator.push(context,MaterialPageRoute(builder: (context) => const LoginPage2()),
                 );
               },
               child: const Text(
                   "Sign Up With Phone or Email",
               style: TextStyle(
                 fontSize: 14,
                 fontWeight: FontWeight.w600
               ),
               ),
             ),
             const SizedBox(height: 50,)


           ],
         )
      );
  }
}
