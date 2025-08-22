import 'package:flutter/material.dart';
import 'package:projek_mini/Tugas13/Login.dart';
import 'package:projek_mini/Tugas13/shared_Preference.dart';
import 'package:projek_mini/extension/navigator.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(
          245,
          41,
          89,
          121,
        ), // 🔴 warna latar tombol
        // foregroundColor: Colors.white
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // biar agak rounded
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      ),
      onPressed: () {
        PreferenceHandler.removeLogin();
        context.pushReplacementNamed(Login.id);
      },

      child: Text(
        "Keluar",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.amberAccent,
          fontSize: 16,
        ),
      ),
    );
  }
}
