import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  Widget _buildItem({required String title, bool active = false}) {
    return Container(
      decoration: BoxDecoration(
        color: active ? const Color(0xFFE3F2FD) : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: active ? const Color(0xFF1E88E5) : Colors.black87,
          ),
        ),
        trailing: active
            ? const CircleAvatar(
                radius: 6,
                backgroundColor: Color(0xFF1E88E5),
              )
            : null,
        onTap: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        backgroundColor: const Color(0xFF1E88E5),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 420),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 18),
                  _buildItem(title: 'Satpam', active: true),
                  const Divider(height: 0),
                  _buildItem(title: 'Housekeeping'),
                  const Divider(height: 0),
                  _buildItem(title: 'Jaringan'),
                  const Divider(height: 0),
                  _buildItem(title: 'Backboud'),
                  const SizedBox(height: 18),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
