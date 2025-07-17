import 'package:flutter/material.dart';
import '../model/kampus.dart';
import '../service/api_service_kampus.dart';

class FormKampus extends StatefulWidget {
  final Kampus? kampus;
  const FormKampus({this.kampus});

  @override
  _FormKampusState createState() => _FormKampusState();
}

class _FormKampusState extends State<FormKampus> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nama, alamat, telepon, kategori, lat, long, jurusan;

  @override
  void initState() {
    super.initState();
    nama = TextEditingController(text: widget.kampus?.nama ?? '');
    alamat = TextEditingController(text: widget.kampus?.alamat ?? '');
    telepon = TextEditingController(text: widget.kampus?.telepon ?? '');
    kategori = TextEditingController(text: widget.kampus?.kategori ?? '');
    lat = TextEditingController(text: widget.kampus?.latitude ?? '');
    long = TextEditingController(text: widget.kampus?.longitude ?? '');
    jurusan = TextEditingController(text: widget.kampus?.jurusan ?? '');
  }

  void simpan() async {
    final kampus = Kampus(
      id: widget.kampus?.id ?? 0,
      nama: nama.text,
      alamat: alamat.text,
      telepon: telepon.text,
      kategori: kategori.text,
      latitude: lat.text,
      longitude: long.text,
      jurusan: jurusan.text,
    );

    bool success = widget.kampus == null
        ? await ApiServiceKampus.tambahKampus(kampus)
        : await ApiServiceKampus.updateKampus(kampus.id, kampus);

    if (success) {
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan data')),
      );
    }
  }

  Widget field(TextEditingController ctrl, String label, IconData icon) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextFormField(
      controller: ctrl,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.orange),
        filled: true,
        fillColor: Colors.orange.shade50,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (val) => val == null || val.isEmpty ? 'Wajib diisi' : null,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.kampus == null ? 'Tambah Kampus' : 'Edit Kampus'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              field(nama, "Nama Kampus", Icons.school),
              field(alamat, "Alamat", Icons.location_on),
              field(telepon, "No. Telepon", Icons.phone),
              field(kategori, "Kategori", Icons.category),
              field(lat, "Latitude", Icons.map),
              field(long, "Longitude", Icons.map_outlined),
              field(jurusan, "Jurusan", Icons.book),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) simpan();
                },
                icon: Icon(Icons.save),
                label: Text(widget.kampus == null ? 'Simpan' : 'Update'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nama.dispose();
    alamat.dispose();
    telepon.dispose();
    kategori.dispose();
    lat.dispose();
    long.dispose();
    jurusan.dispose();
    super.dispose();
  }
}
