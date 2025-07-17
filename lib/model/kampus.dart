class Kampus {
  final int id;
  final String nama;
  final String alamat;
  final String telepon;
  final String kategori;
  final String latitude;
  final String longitude;
  final String jurusan;

  Kampus({
    required this.id,
    required this.nama,
    required this.alamat,
    required this.telepon,
    required this.kategori,
    required this.latitude,
    required this.longitude,
    required this.jurusan,
  });

  factory Kampus.fromJson(Map<String, dynamic> json) => Kampus(
    id: json['id'],
    nama: json['nama_kampus'] ?? '',
    alamat: json['alamat'] ?? '',
    telepon: json['no_telepon'] ?? '',
    kategori: json['kategori'] ?? '',
    latitude: json['latitude']?.toString() ?? '0.0',
    longitude: json['longitude']?.toString() ?? '0.0',
    jurusan: json['jurusan'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'nama_kampus': nama,
    'alamat': alamat,
    'no_telepon': telepon,
    'kategori': kategori,
    'latitude': latitude,
    'longitude': longitude,
    'jurusan': jurusan,
  };
}
