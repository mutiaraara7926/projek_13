import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrasiSiswa extends StatefulWidget {
  const RegistrasiSiswa({super.key});

  @override
  State<RegistrasiSiswa> createState() => _RegistrasiSiswaState();
}

class _RegistrasiSiswaState extends State<RegistrasiSiswa> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> _saveUserData(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("email", email);
    await prefs.setString("password", password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(245, 41, 89, 121),
      ),
      body: Container(
        color: const Color.fromARGB(245, 41, 89, 121),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Buat akun",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.amberAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // EMAIL
                    TextFormField(
                      controller: emailController,
                      style: TextStyle(color: Color(0xFFFFFFFF)),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.email, color: Colors.white),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email Tidak boleh kosong";
                        }
                        if (!value.contains("@")) {
                          return "Email tidak valid";
                        }
                        if (!(value.endsWith("@gmail.com") ||
                            value.endsWith("@yahoo.com"))) {
                          return "Email harus @gmail.com atau @yahoo.com";
                        }
                        if (RegExp('[A-Z]').hasMatch(value)) {
                          return "Email harus huruf kecil";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    // PASSWORD
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      style: TextStyle(color: Color(0xFFFFFFFF)),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.lock, color: Colors.white),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password wajib diisi";
                        }
                        if (value.length < 6) {
                          return "Password minimal 6 karakter";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    // KONFIRMASI PASSWORD
                    TextFormField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      style: TextStyle(color: Color(0xFFFFFFFF)),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Konfirmasi Password",
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.lock, color: Colors.white),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Konfirmasi password wajib diisi";
                        }
                        if (value != passwordController.text) {
                          return "Password tidak sama";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    SizedBox(
                      width: 327,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amberAccent,
                          // foregroundColor: Colors.amber,
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await _saveUserData(
                              emailController.text,
                              passwordController.text,
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Registrasi Berhasil!"),
                                backgroundColor: Colors.amber,
                              ),
                            );

                            Navigator.pop(context); // kembali ke login page
                          }
                        },
                        child: Text(
                          "Daftar",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(245, 41, 89, 121),
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
