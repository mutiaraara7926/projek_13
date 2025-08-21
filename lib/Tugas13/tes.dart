// import 'package:flutter/material.dart';

// import 'dbHelper.dart';
// import 'model.dart';
// import 'textForm.dart';

// class Tes extends StatefulWidget {
//   const Tes({super.key});

//   @override
//   State<Tes> createState() => _TesState();
// }

// class _TesState extends State<Tes> {
//   final TextEditingController namaController = TextEditingController();
//   final TextEditingController kelasController = TextEditingController();
//   final TextEditingController umurController = TextEditingController();

//   List<Anggota> anggota = [];
//   Anggota? selectedAnggota; // buat deteksi update

//   @override
//   void initState() {
//     super.initState();
//     getAnggota();
//   }

//   Future<void> getAnggota() async {
//     final data = await DbHelper.getAllAnggota();
//     setState(() {
//       anggota = data;
//     });
//   }

//   // hitung jumlah siswa per kelas
//   Map<String, int> hitungJumlah() {
//     int x = 0, xi = 0, xii = 0;
//     for (var a in anggota) {
//       if (a.kelas.toUpperCase() == "X") x++;
//       if (a.kelas.toUpperCase() == "XI") xi++;
//       if (a.kelas.toUpperCase() == "XII") xii++;
//     }
//     return {"X": x, "XI": xi, "XII": xii};
//   }

//   // simpan data (tambah atau update)
//   Future<void> simpanData() async {
//     if (namaController.text.isEmpty || kelasController.text.isEmpty) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("Nama dan kelas wajib diisi")));
//       return;
//     }

//     if (selectedAnggota == null) {
//       // Tambah baru
//       final siswa = Anggota(
//         nama: namaController.text,
//         kelas: kelasController.text.toUpperCase(),
//         umur: umurController.text,
//       );
//       await DbHelper.registerAnggota(siswa);
//     } else {
//       // Update data
//       final siswa = Anggota(
//         id: selectedAnggota!.id,
//         nama: namaController.text,
//         kelas: kelasController.text.toUpperCase(),
//         umur: umurController.text,
//       );
//       await DbHelper.updateAnggota(siswa);
//       selectedAnggota = null;
//     }

//     namaController.clear();
//     kelasController.clear();
//     umurController.clear();
//     getAnggota();
//   }

//   // hapus data
//   Future<void> hapusData(int id) async {
//     await DbHelper.deleteUser(id);
//     getAnggota();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final jumlah = hitungJumlah();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Data Siswa & Jumlah Per Kelas"),
//         centerTitle: true,
//         backgroundColor: Color.fromARGB(245, 41, 89, 121),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // Form tambah/update siswa
//             TextFormConst(hintText: "Nama", controller: namaController),
//             SizedBox(height: 10),
//             TextFormConst(
//               hintText: "Kelas (X/XI/XII)",
//               controller: kelasController,
//             ),
//             SizedBox(height: 10),
//             TextFormConst(hintText: "Umur", controller: umurController),
//             SizedBox(height: 15),
//             ElevatedButton(
//               onPressed: simpanData,
//               child: Text(
//                 selectedAnggota == null ? "Tambah Siswa" : "Update Siswa",
//               ),
//             ),

//             SizedBox(height: 20),
//             Divider(),

//             // Daftar siswa (read, edit, delete)
//             Expanded(
//               child: ListView.builder(
//                 itemCount: anggota.length,
//                 itemBuilder: (context, index) {
//                   final a = anggota[index];
//                   return Card(
//                     child: ListTile(
//                       title: Text("${a.nama} (Kelas: ${a.kelas})"),
//                       subtitle: Text("Umur: ${a.umur}"),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             icon: Icon(Icons.edit, color: Colors.orange),
//                             onPressed: () {
//                               setState(() {
//                                 selectedAnggota = a;
//                                 namaController.text = a.nama;
//                                 kelasController.text = a.kelas;
//                                 umurController.text = a.umur ?? "";
//                               });
//                             },
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.delete, color: Colors.red),
//                             onPressed: () {
//                               hapusData(a.id!);
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),

//             Divider(),
//             // Tampilkan jumlah per kelas
//             Card(
//               child: ListTile(
//                 title: Text("Kelas X"),
//                 trailing: Text("${jumlah["X"]} siswa"),
//               ),
//             ),
//             Card(
//               child: ListTile(
//                 title: Text("Kelas XI"),
//                 trailing: Text("${jumlah["XI"]} siswa"),
//               ),
//             ),
//             Card(
//               child: ListTile(
//                 title: Text("Kelas XII"),
//                 trailing: Text("${jumlah["XII"]} siswa"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
