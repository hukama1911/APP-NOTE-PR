import 'package:crud_rumah_sakit/model/dosen.dart';
import 'package:flutter/material.dart';

import '../service/api_service_dosen.dart';

class UpdateDosen extends StatefulWidget {
  final Dosen dosen;
  UpdateDosen({required this.dosen});

  @override
  _UpdateDosenState createState() => _UpdateDosenState();
}

class _UpdateDosenState extends State<UpdateDosen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nipController;
  late TextEditingController _namaController;
  late TextEditingController _noTeleponController;
  late TextEditingController _emailController;
  late TextEditingController _alamatController;

  @override
  void initState() {
    super.initState();
    _nipController = TextEditingController(text: widget.dosen.nip);
    _namaController = TextEditingController(text: widget.dosen.namaLengkap);
    _noTeleponController = TextEditingController(text: widget.dosen.noTelepon);
    _emailController = TextEditingController(text: widget.dosen.email);
    _alamatController = TextEditingController(text: widget.dosen.alamat);
  }

  @override
  void dispose() {
    _nipController.dispose();
    _namaController.dispose();
    _noTeleponController.dispose();
    _emailController.dispose();
    _alamatController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final updatedDosen = Dosen(
        no: widget.dosen.no,
        nip: _nipController.text,
        namaLengkap: _namaController.text,
        noTelepon: _noTeleponController.text,
        email: _emailController.text,
        alamat: _alamatController.text,
      );

      try {
        await ApiServiceDosen().updateDosen(widget.dosen.no, updatedDosen);
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal update'), backgroundColor: Colors.red),
        );
      }
    }
  }

  InputDecoration _decoration(String label) => InputDecoration(
    labelText: label,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
    filled: true,
    fillColor: Colors.teal.shade50,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Dosen'), backgroundColor: Colors.teal),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nipController,
                decoration: _decoration('NIP'),
                validator: (value) => value == null || value.isEmpty ? 'Tidak boleh kosong' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _namaController,
                decoration: _decoration('Nama Lengkap'),
                validator: (value) => value == null || value.isEmpty ? 'Tidak boleh kosong' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _noTeleponController,
                decoration: _decoration('No Telepon'),
                validator: (value) => value == null || value.isEmpty ? 'Tidak boleh kosong' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                decoration: _decoration('Email'),
                validator: (value) => value == null || value.isEmpty ? 'Tidak boleh kosong' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _alamatController,
                decoration: _decoration('Alamat'),
                validator: (value) => value == null || value.isEmpty ? 'Tidak boleh kosong' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                ),
                child: const Text('Simpan Perubahan'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
