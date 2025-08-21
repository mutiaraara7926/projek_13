// import 'package:flutter/material.dart';

// // import 'package:projek_mini/Tugas13/list_Siswa.dart';
// import 'list_Siswa.dart';

// class DrawerProjek extends StatefulWidget {
//   const DrawerProjek({super.key});

//   @override
//   State<DrawerProjek> createState() => _DrawerProjekState();
// }

// class _DrawerProjekState extends State<DrawerProjek> {
//   int _selectedIndexDrawer = 0;
//   static const List<String> _titles = ["List Siswa"];
//   static const List<Widget> _widgetOptions = <Widget>[DataSiswa()];

//   void onItemTap(int index) {
//     setState(() {
//       _selectedIndexDrawer = index;
//     });
//     // context.pop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           DrawerHeader(
//             decoration: BoxDecoration(color: Color.fromARGB(245, 41, 89, 121)),
//             child: Text(
//               "Menu",
//               style: TextStyle(
//                 color: Colors.amberAccent,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           // ListTile(
//           //   leading: const Icon(Icons.person),
//           //   title: Text("Profile"),
//           //   onTap: () => onItemTap(0),
//           // ),
//           // ListTile(
//           //   // leading: const Icon(Icons.person),
//           //   title: Text("List Siswa"),
//           //   onTap: () => onItemTap(1),
//           // ),
//         ],
//       ),
//     );
//   }
// }
