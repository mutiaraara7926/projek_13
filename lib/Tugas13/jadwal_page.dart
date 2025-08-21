import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  List<Map<String, String>> dataJadwal = [
    {
      "tanggal": DateFormat('EEEE, dd MMMM yyyy').format(DateTime(2019, 1, 31)),
      "keterangan": "",
    },
  ];

  //  Fungsi tambah jadwal
  Future<void> _tambahJadwal() async {
    DateTime? pilihTanggal = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1999),
      lastDate: DateTime(2050),
    );

    if (pilihTanggal != null) {
      TextEditingController ketController = TextEditingController();

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Tambah Jadwal"),
            content: TextField(
              controller: ketController,
              decoration: const InputDecoration(labelText: "Keterangan"),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Batal"),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    dataJadwal.add({
                      "tanggal": DateFormat(
                        'EEEE, dd MMMM yyyy',
                      ).format(pilihTanggal),
                      "keterangan": ketController.text,
                    });
                  });
                  Navigator.pop(context);
                },
                child: const Text("Simpan"),
              ),
            ],
          );
        },
      );
    }
  }

  //  Fungsi edit jadwal
  Future<void> _editJadwal(int index) async {
    final jadwal = dataJadwal[index];
    DateTime initialDate = DateTime.now();
    // buat nangkep eror biar ga langsung crash
    try {
      initialDate = DateFormat('EEEE, dd MMMM yyyy').parse(jadwal["tanggal"]!);
    } catch (_) {}

    DateTime? pilihTanggal = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1999),
      lastDate: DateTime(2050),
    );

    if (pilihTanggal != null) {
      TextEditingController ketController = TextEditingController(
        text: jadwal["keterangan"],
      );

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Edit Jadwal"),
            content: TextField(
              controller: ketController,
              decoration: const InputDecoration(labelText: "Keterangan"),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Batal"),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    dataJadwal[index] = {
                      "tanggal": DateFormat(
                        'EEEE, dd MMMM yyyy',
                      ).format(pilihTanggal),
                      "keterangan": ketController.text,
                    };
                  });
                  Navigator.pop(context);
                },
                child: const Text("Simpan"),
              ),
            ],
          );
        },
      );
    }
  }

  // Fungsi hapus jadwal
  void _hapusJadwal(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Hapus Jadwal"),
          content: const Text("Apakah yakin ingin menghapus jadwal ini?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  dataJadwal.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: const Text("Hapus"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Jadwal",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 233, 214, 175),
          ),
        ),
        backgroundColor: Color.fromARGB(245, 41, 89, 121),

        centerTitle: true,
      ),
      body: Container(
        color: const Color.fromARGB(255, 233, 214, 175),
        child: ListView.builder(
          itemCount: dataJadwal.length,
          itemBuilder: (context, index) {
            final item = dataJadwal[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: const Icon(
                  Icons.calendar_today,
                  color: Colors.amberAccent,
                ),
                title: Text(item["tanggal"] ?? ""),
                subtitle: Text(item["keterangan"] ?? ""),
                onTap: () => _editJadwal(index), // buat edit
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.amberAccent),
                  onPressed: () => _hapusJadwal(index), // buat hapus jadwal
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _tambahJadwal,
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add),
      ),
    );
  }
}
