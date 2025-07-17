class Hospital {
  final int id;
  final String nama;
  final String alamat;
  final String telepon;
  final String tipe;
  final String latitude;
  final String longitude;

  Hospital({
    required this.id,
    required this.nama,
    required this.alamat,
    required this.telepon,
    required this.tipe,
    required this.latitude,
    required this.longitude,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) => Hospital(
    id: json['id'],
    nama: json['nama'] ?? '',
    alamat: json['alamat'] ?? '',
    telepon: json['telepon'] ?? '',
    tipe: json['tipe'] ?? '',
    latitude: json['latitude']?.toString() ?? '0.0',
    longitude: json['longitude']?.toString() ?? '0.0',
  );

  Map<String, dynamic> toJson() {
    final map = {
      'nama': nama,
      'alamat': alamat,
      'telepon': telepon,
      'tipe': tipe,
      'latitude': latitude,
      'longitude': longitude,
    };
    print('Sending data: $map');
    return map;
  }
}
