import 'package:flutter/material.dart';

import 'db_Helper.dart';
import 'model.dart';
import 'textForm.dart';

class DataSiswa extends StatefulWidget {
  const DataSiswa({super.key});

  @override
  _DataSiswaState createState() => _DataSiswaState();
}

class _DataSiswaState extends State<DataSiswa> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController kelasController = TextEditingController();
  final TextEditingController umurController = TextEditingController();

  List<Anggota> anggota = [];

  @override
  void initState() {
    super.initState();
    getAnggota();
  }

  Future<void> getAnggota() async {
    final dataAnggota = await DbHelper.getAllAnggota();
    setState(() {
      anggota = dataAnggota;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(245, 41, 89, 121),
        title: Text(
          "LIST SISWA",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 233, 214, 175),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        // biar container bisa diisi warna
        width: double.infinity,
        height: double.infinity,
        color: const Color.fromARGB(255, 233, 214, 175),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                TextFormConst(hintText: "Nama", controller: namaController),
                SizedBox(height: 20),

                TextFormConst(hintText: "Kelas", controller: kelasController),

                SizedBox(height: 20),
                TextFormConst(hintText: "Umur", controller: umurController),

                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () async {
                    final nama = namaController.text.trim();
                    final kelas = kelasController.text.trim();
                    final umur = umurController.text.trim();

                    if (nama.isEmpty || kelas.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Nama dan Kelas tidak boleh kosong"),
                        ),
                      );
                      return;
                    }

                    final anggota = Anggota(
                      nama: nama,
                      kelas: kelas,
                      umur: umur,
                    );
                    await DbHelper.registerAnggota(anggota);
                    Future.delayed(const Duration(seconds: 1)).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text(" Berhasil")),
                      );
                    });
                    getAnggota();
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(245, 41, 89, 121),
                    foregroundColor: Colors.amber,
                  ),

                  child: Text("Tambahkan Siswa"),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: anggota.isEmpty ? 0 : anggota.length,
                  itemBuilder: (BuildContext context, int index) {
                    final dataUserLogin = anggota[index];

                    return ListTile(
                      title: Text(dataUserLogin.nama),
                      subtitle: Text(dataUserLogin.kelas),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Edit data'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormConst(
                                        controller: namaController
                                          ..text = dataUserLogin.nama,
                                        hintText: 'nama',
                                      ),
                                      SizedBox(height: 12),
                                      TextFormConst(
                                        controller: kelasController
                                          ..text = dataUserLogin.kelas,
                                        hintText: 'kelas',
                                      ),
                                      SizedBox(height: 12),
                                      TextFormConst(
                                        controller: umurController
                                          ..text = dataUserLogin.kelas,
                                        hintText: 'umur',
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        final DataSiswa = Anggota(
                                          id: dataUserLogin.id!,
                                          nama: namaController.text,
                                          kelas: kelasController.text,
                                          umur: umurController.text,
                                        );
                                        DbHelper.updateAnggota(DataSiswa);
                                        getAnggota();
                                        Navigator.pop(context);
                                      },
                                      child: Text('Simpan'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('Batal'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              DbHelper.deleteUser(dataUserLogin.id!);
                              getAnggota();
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
