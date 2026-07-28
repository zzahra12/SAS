import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'housekeeping_page.dart';
import 'jaringan_page.dart';
import 'backbound_page.dart';

class StoDetailPage extends StatefulWidget {
  final String name; 
  final String? docId; 
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
  bool _showPersonelDetailMode = false;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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

  String get targetDocId {
    if (widget.docId != null && widget.docId!.isNotEmpty) {
      return widget.docId!;
    }
    return widget.name
        .replaceAll('Telda ', '')
        .trim();
  }
  List<String> _getTugasUtama(String nama, String tagArea) {
    if (tagArea == 'POS UTAMA') {
      return [
        'Supervisi komando area, kontrol tamu & monitoring CCTV',
        'Penanganan awal & koordinasi tanggap darurat',
      ];
    } else if (tagArea == 'GRAPARI') {
      return [
        'Pengawasan area pelayanan umum & antrean pengunjung',
        'Penerapan standar K3 keselamatan seluruh pelanggan',
      ];
    } else {
      return [
        'Patroli berkala area publik & booth display IndiBiz',
        'Proteksi fisik jaringan & pencegahan risiko aset',
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            _showPersonelDetailMode ? 'Personel Security' : widget.name),
        centerTitle: true,
        backgroundColor: const Color(0xFF1E88E5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (_showPersonelDetailMode) {
              setState(() {
                _showPersonelDetailMode = false;
              });
            } else {
              Navigator.pop(context);
            }
          },
        ),
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
                  Text(
                    _showPersonelDetailMode
                        ? 'Detail Personel Security'
                        : 'Detail STO',
                    style: const TextStyle(
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
                            builder: (context) => HousekeepingPage(
                              stoName: widget.name, 
                              docId: targetDocId,  
                            ),
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

              if (!_showPersonelDetailMode) ...[
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
                const Text(
                  'Tim Security',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 14),
              ],

              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('sto')
                    .doc(targetDocId)
                    .collection('team')
                    .where('role', isEqualTo: 'Security')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

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

                  if (!_showPersonelDetailMode) {
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
                                          errorBuilder: (context, error,
                                                  stackTrace) =>
                                              const Icon(Icons.person,
                                                  color: Color(0xFF1E88E5),
                                                  size: 32),
                                        )
                                      : const Icon(Icons.person,
                                          color: Color(0xFF1E88E5), size: 32),
                                ),
                              ),
                              const SizedBox(height: 10),

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

                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _showPersonelDetailMode = true;
                                  });
                                },
                                child: Container(
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
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }

                  final filteredDocs = docs.where((doc) {
                    var data = doc.data() as Map<String, dynamic>;
                    String nama = (data['name'] ?? '').toString().toLowerCase();
                    return nama.contains(_searchQuery.toLowerCase());
                  }).toList();

                  return Column(
                    children: [

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E2A38),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.name,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0F172A),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '${docs.length} Anggota',
                                    style: const TextStyle(
                                        color: Colors.greenAccent,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextField(
                                controller: _searchController,
                                onChanged: (val) {
                                  setState(() {
                                    _searchQuery = val;
                                  });
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Cari nama atau area tugas...',
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 13),
                                  prefixIcon:
                                      Icon(Icons.search, color: Colors.grey),
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: filteredDocs.length,
                        itemBuilder: (context, index) {
                          var data =
                              filteredDocs[index].data() as Map<String, dynamic>;
                          String nama = data['name'] ?? 'Tanpa Nama';
                          String photoUrl = data['photoUrl'] ?? '';

                          String tagArea = index == 0
                              ? 'POS UTAMA'
                              : (index == 1 ? 'GRAPARI' : 'INDIBIZ');
                          Color tagBg = index == 0
                              ? const Color(0xFFE3F2FD)
                              : (index == 1
                                  ? const Color(0xFFE8F5E9)
                                  : const Color(0xFFFFF3E0));
                          Color tagText = index == 0
                              ? const Color(0xFF1565C0)
                              : (index == 1
                                  ? const Color(0xFF2E7D32)
                                  : const Color(0xFFE65100));

                          List<String> tasks = _getTugasUtama(nama, tagArea);

                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ClipOval(
                                      child: photoUrl.isNotEmpty
                                          ? Image.network(
                                              photoUrl,
                                              width: 48,
                                              height: 48,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  const Icon(Icons.person,
                                                      size: 32),
                                            )
                                          : const Icon(Icons.person, size: 32),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'SECURITY',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blueAccent,
                                            ),
                                          ),
                                          Text(
                                            nama,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: tagBg,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        tagArea,
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: tagText,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 12),
                                const Divider(height: 1, color: Colors.black12),
                                const SizedBox(height: 10),
                                const Text(
                                  'Tugas Utama:',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                ...tasks.map<Widget>((taskItem) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 2),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('• ',
                                            style: TextStyle(fontSize: 12)),
                                        Expanded(
                                          child: Text(
                                            taskItem,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
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