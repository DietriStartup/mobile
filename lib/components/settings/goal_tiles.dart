// import 'package:dietri/constants/colors.dart';
// import 'package:dietri/constants/fonts.dart';
// import 'package:dietri/enum/language.dart';
// import 'package:dietri/helper/sizer.dart';
// import 'package:dietri/screens/landinpage.dart';
// import 'package:flutter/material.dart';

// class GoalTiles extends StatefulWidget {
//   final String text;
//   final Language lang;

//   GoalTiles({
//     Key? key,
//     required this.text,
//     required this.lang,
//   }) : super(key: key);

//   @override
//   State<GoalTiles> createState() => _GoalTilesState();
// }

// class _GoalTilesState extends State<GoalTiles> {
//   String default_goal = 'Gain Weight';
//   int default_index = 0;
//   Language _lang = Language.English;
//   int value = 0;
//   List<MyGoals> Goals = [
//     MyGoals(index: 0, goals: 'Gain Weight'),
//     MyGoals(index: 1, goals: 'Loose Weight'),
//     MyGoals(index: 2, goals: 'Maintain Weight'),
//     MyGoals(index: 3, goals: 'others'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ListView(
//           shrinkWrap: true,
//           children: [
//             ...Goals.map((item) => Column(
//               children: [
//             Container(
//               alignment: Alignment.center,
//               height: 50,
//               decoration: BoxDecoration(
//                   color: kListGrey,
//                   borderRadius: BorderRadius.circular(6.0),
//                   border: Border.all(width: 1, color: kLightGrey)),
//               child: ListTile(
//                 leading: Text(
//                   item.goals,
//                   style: Fonts.montserratFont(
//                       color: Colors.black,
//                       size: sizer(true, 15.0, context),
//                       fontWeight: FontWeight.w400),
//                 ),
//                 trailing: Radio<MyGoals>(
//                   // toggleable: true,
//                   // activeColor: kPrimaryColor,
//                   fillColor: MaterialStateColor.resolveWith(
//                     (states) => kPrimaryColor,
//                   ),
//                   focusColor: MaterialStateColor.resolveWith(
//                       (states) => Colors.green),
//                   value: item.index,
//                   groupValue: item.index,
//                   onChanged: (val) {
//                     setState(() {
//                       default_goal = item.goals;
//                       default_index = item.index;
//                     });
//                     // print(_lang);
//                   },
//                 ),
//               ),
//             )]
             
//             )).toList()

//           ]
         

//           ),
//       ],
//     );
    

  
//   }
// }

// class MyGoals {
//   final index;
//   final String goals;
//   MyGoals({required this.index, required this.goals});
// }
