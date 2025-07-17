import 'package:crud_rumah_sakit/model/dosen.dart';
import 'package:crud_rumah_sakit/screen/add_dosen.dart';
import 'package:crud_rumah_sakit/screen/update_dosen.dart';
import 'package:flutter/material.dart';

import '../service/api_service_dosen.dart';

class ListDosen extends StatefulWidget {
  @override
  _ListDosenState createState() => _ListDosenState();
}

class _ListDosenState extends State<ListDosen> {
  late Future<List<Dosen>> futureDosens;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    setState(() {
      futureDosens = ApiServiceDosen().getDosens();
    });
  }

  void _deleteDosen(int no) async {
    try {
      await ApiServiceDosen().deleteDosen(no);
      fetchData();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal menghapus data'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Daftar Dosen'),
        backgroundColor: Colors.teal,
        elevation: 2,
      ),
      body: FutureBuilder<List<Dosen>>(
        future: futureDosens,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Terjadi error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final dosens = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: dosens.length,
              itemBuilder: (context, index) {
                final dosen = dosens[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: ListTile(
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: const CircleAvatar(
                      backgroundColor: Colors.teal,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text(
                      dosen.namaLengkap,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(dosen.email),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateDosen(dosen: dosen),
                              ),
                            );
                            if (result == true) fetchData();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteDosen(dosen.no),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Tidak ada data dosen.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDosen()),
          );
          if (result == true) fetchData();
        },
      ),
    );
  }
}
