// Widget _backButton() {
//   return InkWell(
//     onTap: () {
//       Navigator.pop(context);
//     },
//     child: Container(
//       padding: EdgeInsets.symmetric(horizontal: 10),
//       child: Row(
//         children: <Widget>[
//           Container(
//             padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
//             child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
//           ),
//           Text('Back',
//               style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
//         ],
//       ),
//     ),
//   );
// }
//
// Widget _submitButton() {
//   return InkWell(
//     onTap: () {
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => LoginPage()));
//     },
//     child: Container(
//       width: MediaQuery.of(context).size.width,
//       padding: EdgeInsets.symmetric(vertical: 13),
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(5)),
//           boxShadow: <BoxShadow>[
//             BoxShadow(
//                 color: Colors.blue.withAlpha(100),
//                 offset: Offset(2, 4),
//                 blurRadius: 8,
//                 spreadRadius: 2)
//           ],
//           color: Colors.white),
//       child: Text(
//         'Login',
//         style: TextStyle(fontSize: 20, color: Colors.black),
//       ),
//     ),
//   );
// }
//
// Widget _signUpButton() {
//   return InkWell(
//     onTap: () {
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => SignUpPage()));
//     },
//     child: Container(
//       width: MediaQuery.of(context).size.width,
//       padding: EdgeInsets.symmetric(vertical: 13),
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(5)),
//         border: Border.all(color: Colors.white, width: 2),
//       ),
//       child: Text(
//         'Register now',
//         style: TextStyle(fontSize: 20, color: Colors.white),
//       ),
//     ),
//   );
// }
//
// Widget _facebookButton() {
//   return InkWell(
//       onTap: () {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => PostsPage()));
//       },
//       child: Container(
//         height: 50,
//         margin: EdgeInsets.symmetric(vertical: 20),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(10)),
//         ),
//         child: Row(
//           children: <Widget>[
//             Expanded(
//               flex: 1,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                   borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(5),
//                       topLeft: Radius.circular(5)),
//                 ),
//                 alignment: Alignment.center,
//                 child: Icon(
//                   Icons.article,
//                   color: Colors.white,
//                   size: 25,
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 5,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Color(0xff2872ba),
//                   borderRadius: BorderRadius.only(
//                       bottomRight: Radius.circular(5),
//                       topRight: Radius.circular(5)),
//                 ),
//                 alignment: Alignment.center,
//                 child: Text('Go To Blog',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w400)),
//               ),
//             ),
//           ],
//         ),
//       ));
// }
//
// Widget _sendAlarm() {
//   return InkWell(
//     onTap: () {
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => SendAlarmPage()));
//     },
//     child: Container(
//         width: double.infinity,
//         padding: EdgeInsets.symmetric(vertical: 8),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(width: 2, style: BorderStyle.solid),
//           color: Colors.green,
//         ),
//         child: Text(
//           'Send Alarm',
//           style: TextStyle(
//             fontSize: 30,
//           ),
//         )),
//   );
// }
//
// Widget _title() {
//   return RichText(
//     textAlign: TextAlign.center,
//     text: TextSpan(
//         text: 'A',
//         style: TextStyle(
//           fontSize: 30,
//           fontWeight: FontWeight.w700,
//           color: Colors.white,
//         ),
//         children: [
//           TextSpan(
//             text: 'la',
//             style: TextStyle(color: Colors.black, fontSize: 30),
//           ),
//           TextSpan(
//             text: 'rm',
//             style: TextStyle(color: Colors.white, fontSize: 30),
//           ),
//         ]),
//   );
// }