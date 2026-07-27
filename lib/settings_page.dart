import 'package:flutter/material.dart';

class SettingsMenuButton extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onSelected;

  const SettingsMenuButton({
    Key? key,
    required this.selectedCategory,
    required this.onSelected,
  }) : super(key: key);

  Widget _menuItem(String title) {
    final selected = selectedCategory == title;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              color: selected ? const Color(0xFF1E88E5) : Colors.black87,
            ),
          ),
          if (selected)
            const Icon(
              Icons.circle,
              size: 12,
              color: Color(0xFF1E88E5),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: 'Pengaturan',
      padding: EdgeInsets.zero,
      offset: const Offset(0, 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      color: Colors.white,
      onSelected: onSelected,
      itemBuilder: (context) => [
        PopupMenuItem(value: 'Satpam', child: _menuItem('Satpam')),
        const PopupMenuDivider(height: 0),
        PopupMenuItem(
          value: 'Housekeeping',
          child: _menuItem('Housekeeping'),
        ),
        const PopupMenuDivider(height: 0),
        PopupMenuItem(value: 'Jaringan', child: _menuItem('Jaringan')),
        const PopupMenuDivider(height: 0),
        PopupMenuItem(value: 'Backbound', child: _menuItem('Backbound')),
      ],
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE3F2FD),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8),
        child: const Icon(
          Icons.settings,
          color: Color(0xFF1E88E5),
        ),
      ),
    );
  }
}

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
                  _buildItem(title: 'Backbound'),
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
