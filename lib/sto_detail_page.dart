import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Import file-file halaman tujuan
import 'housekeeping_page.dart';
import 'jaringan_page.dart';
import 'backbound_page.dart';

class StoDetailPage extends StatefulWidget {
  final String name;      // Nama judul tampilan (misal: 'Plasa Telda Banyuwangi')
  final String? docId;    // ID Dokumen Firestore (misal: 'Banyuwangi')
  final String address;
  final String description;

  const StoDetailPage({
    Key? key,
    required this.name,
    this.docId,
    required this.address,
    required this.description,
  }) : super(key: key);

  @override
  State<StoDetailPage> createState() => _StoDetailPageState();
}

class _StoDetailPageState extends State<StoDetailPage> {
  Widget _buildSettingsMenuItem(String title) {
    final selected = title == 'Satpam';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.5,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              color: selected ? const Color(0xFF1E88E5) : Colors.black87,
            ),
          ),
          if (selected)
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: Color(0xFF1E88E5),
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }

  // Fungsi penolong untuk mengambil ID dokumen Firestore yang tepat
  String get targetDocId {
    if (widget.docId != null && widget.docId!.isNotEmpty) {
      return widget.docId!;
    }
    // Jika docId tidak dikirim, bersihkan teks 'Plasa Telda ' atau 'STO ' dari name
    return widget.name
        .replaceAll('Plasa Telda ', '')
        .replaceAll('STO Telda ', '')
        .replaceAll('STO ', '')
        .trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
        backgroundColor: const Color(0xFF1E88E5),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER & POPUP MENU
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Detail STO',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  PopupMenuButton<String>(
                    padding: EdgeInsets.zero,
                    offset: const Offset(0, 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    color: Colors.white,
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'Satpam',
                        child: _buildSettingsMenuItem('Satpam'),
                      ),
                      const PopupMenuDivider(height: 0),
                      PopupMenuItem(
                        value: 'Housekeeping',
                        child: _buildSettingsMenuItem('Housekeeping'),
                      ),
                      const PopupMenuDivider(height: 0),
                      PopupMenuItem(
                        value: 'Jaringan',
                        child: _buildSettingsMenuItem('Jaringan'),
                      ),
                      const PopupMenuDivider(height: 0),
                      PopupMenuItem(
                        value: 'Backbound',
                        child: _buildSettingsMenuItem('Backbound'),
                      ),
                    ],
                    onSelected: (String value) {
                      if (value == 'Housekeeping') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HousekeepingPage(),
                          ),
                        );
                      } else if (value == 'Jaringan') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const JaringanPage(),
                          ),
                        );
                      } else if (value == 'Backbound') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BackboundPage(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.settings,
                          color: Color(0xFF1E88E5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // CARD STO
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.address,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.description,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E88E5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Pilih STO Ini',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // SECTION TIM SECURITY
              const Text(
                'Tim Security',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),

              // FIRESTORE STREAMBUILDER
              StreamBuilder<QuerySnapshot>(
                // PERBAIKAN DI SINI: Menggunakan targetDocId
                stream: FirebaseFirestore.instance
                    .collection('sto')
                    .doc(targetDocId)
                    .collection('team')
                    .where('role', isEqualTo: 'Security')
                    .snapshots(),
                builder: (context, snapshot) {
                  // Indikator Loading
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  // Jika Error atau Data Kosong
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          'Belum ada data security untuk ${widget.name}',
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ),
                    );
                  }

                  final docs = snapshot.data!.docs;

                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    primary: false,
                    padding: const EdgeInsets.only(bottom: 40),
                    itemCount: docs.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.68,
                    ),
                    itemBuilder: (context, index) {
                      var data = docs[index].data() as Map<String, dynamic>;
                      String nama = data['name'] ?? 'Tanpa Nama';
                      String photoUrl = data['photoUrl'] ?? '';

                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // FOTO ANGGOTA
                            Container(
                              width: 56,
                              height: 56,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFDCEFFF),
                              ),
                              child: ClipOval(
                                child: photoUrl.isNotEmpty
                                    ? Image.network(
                                        photoUrl,
                                        width: 56,
                                        height: 56,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Icon(
                                            Icons.person,
                                            color: Color(0xFF1E88E5),
                                            size: 32,
                                          );
                                        },
                                      )
                                    : const Icon(
                                        Icons.person,
                                        color: Color(0xFF1E88E5),
                                        size: 32,
                                      ),
                              ),
                            ),
                            const SizedBox(height: 10),

                            // NAMA ANGGOTA
                            Text(
                              nama,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 6),

                            // BADGE SECURITY
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE3F2FD),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'SECURITY',
                                style: TextStyle(
                                  color: Color(0xFF1E88E5),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}