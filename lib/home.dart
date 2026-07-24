import 'package:flutter/material.dart';
import 'sto_detail_page.dart';


class StoItem {
  final String id;
  final String name;
  final String address;
  final String description;

  StoItem({
    required this.id,
    required this.name,
    required this.address,
    this.description = 'Layanan operasional Telkom STO terdekat untuk fasilitas Security & Safety.',
  });
}

void main() {
  runApp(const StoLayananApp());
}

/// Widget Utama Aplikasi
class StoLayananApp extends StatelessWidget {
  const StoLayananApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'STO Layanan Banyuwangi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF9FAFB),
        useMaterial3: true,
      ),
      home: const StoLayananHomePage(),
    );
  }
}

class StoLayananHomePage extends StatefulWidget {
  const StoLayananHomePage({Key? key}) : super(key: key);

  @override
  State<StoLayananHomePage> createState() => _StoLayananHomePageState();
}

class _StoLayananHomePageState extends State<StoLayananHomePage> {
  // Controller untuk input pencarian
  final TextEditingController _searchController = TextEditingController();

  // Master Data STO berdasarkan gambar
  final List<StoItem> _allStoList = [
    StoItem(id: '1', name: 'Plasa Telda Banyuwangi', address: 'Jln. Blambangan'),
    StoItem(id: '2', name: 'STO Telda Banyuwangi', address: 'Jln. Blambangan'),
    StoItem(id: '3', name: 'STO Ketapang', address: 'Jln. Ketapang'),
    StoItem(id: '4', name: 'STO Wongsorejo', address: 'Jln. Wongsorejo'),
    StoItem(id: '5', name: 'STO Rogojampi', address: 'Jln. Rogojampi'),
    StoItem(id: '6', name: 'STO Muncar', address: 'Jln. Muncar'),
    StoItem(id: '7', name: 'STO Benculuk', address: 'Jln. Benculuk'),
    StoItem(id: '8', name: 'STO Trambelang', address: 'Jln. Trambelang'),
    StoItem(id: '9', name: 'Plasa Telda Banyuwangi', address: 'Jln. Blambangan'),
    StoItem(id: '10', name: 'STO Pesanggaran', address: 'Jln. Pesanggaran'),
    StoItem(id: '11', name: 'STO Genteng', address: 'Jln. Genteng'),
    StoItem(id: '12', name: 'STO Glenmore', address: 'Jln. Glenmore'),
    StoItem(id: '13', name: 'STO Kalibaru', address: 'Jln. Kalibaru'),
  ];

  // List terfilter yang akan ditampilkan di UI
  List<StoItem> _filteredStoList = [];

  @override
  void initState() {
    super.initState();
    _filteredStoList = _allStoList;
    _searchController.addListener(_filterList);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Fungsi penyaringan query pencarian
  void _filterList() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredStoList = _allStoList.where((sto) {
        return sto.name.toLowerCase().contains(query) ||
            sto.address.toLowerCase().contains(query);
      }).toList();
    });
  }

  Widget _buildHeaderBanner() {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF2B5876), Color(0xFF4E4376)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Gambar Latar / Ilustrasi Gedung Telda
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Opacity(
              opacity: 0.35,
              child: Image.network(
                'https://images.unsplash.com/photo-1541888946425-d0fbb186a5b7?auto=format&fit=crop&w=800&q=80',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(color: Colors.blueGrey);
                },
              ),
            ),
          ),
          // Overlay Teks
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'SELAMAT DATANG!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.8,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Security And Safety\n(SAS)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Telda Banyuwangi',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE2E4E8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(fontSize: 14),
        decoration: const InputDecoration(
          hintText: 'Cari Nama STO atau Wilayah...',
          hintStyle: TextStyle(
            color: Color(0xFF757575),
            fontSize: 13,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xFF616161),
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),
    );
  }

  Widget _buildStoCard(StoItem sto) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFE0E0E0), // Abu-abu terang sesuai UI sampel
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Baris Atas: Nama STO & Tombol Pilih
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  sto.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Tombol Pilih
              SizedBox(
                height: 32,
                child: ElevatedButton(
                  onPressed: () {
                    _navigateToStoDetail(sto);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E88E5), // Biru Terang
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Pilih',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          // Alamat
          Text(
            sto.address,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black54,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 12),
          // Tombol Lihat Selengkapnya
          SizedBox(
            height: 32,
            child: ElevatedButton(
              onPressed: () {
                _showDetailDialog(sto);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D47A1), // Biru Tua
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Lihat Selengkapnya',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToStoDetail(StoItem sto) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StoDetailPage(
          name: sto.name,
          address: sto.address,
          description: sto.description,
        ),
      ),
    );
  }

  void _showDetailDialog(StoItem sto) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(sto.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Alamat:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              Text(sto.address),
              const SizedBox(height: 10),
              Text(
                'Deskripsi:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              Text(sto.description),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Tutup'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToStoDetail(sto);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E88E5),
                foregroundColor: Colors.white,
              ),
              child: const Text('Pilih STO Ini'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Konten Header & Pencarian
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Column(
                children: [
                  _buildHeaderBanner(),
                  const SizedBox(height: 20),
                  const Text(
                    'Pilih STO Layanan',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 14),
                  _buildSearchBar(),
                  const SizedBox(height: 14),
                ],
              ),
            ),
            // Daftar STO Card
            Expanded(
              child: _filteredStoList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.search_off,
                            size: 48,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'STO Layanan tidak ditemukan',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _filteredStoList.length,
                      itemBuilder: (context, index) {
                        return _buildStoCard(_filteredStoList[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
