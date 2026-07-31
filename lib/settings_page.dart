import 'package:flutter/material.dart';

class SettingsMenuButton extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onSelected;

  const SettingsMenuButton({
    Key? key,
    required this.selectedCategory,
    required this.onSelected,
  }) : super(key: key);

  Widget _buildMenuItem(String title) {
    final bool isSelected = title == selectedCategory;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.5,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? const Color(0xFF1E88E5) : Colors.black87,
            ),
          ),
          if (isSelected)
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

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      padding: EdgeInsets.zero,
      offset: const Offset(0, 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      color: Colors.white,
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'Satpam',
          child: _buildMenuItem('Satpam'),
        ),
        const PopupMenuDivider(height: 0),
        PopupMenuItem(
          value: 'Housekeeping',
          child: _buildMenuItem('Housekeeping'),
        ),
        const PopupMenuDivider(height: 0),
        PopupMenuItem(
          value: 'Jaringan',
          child: _buildMenuItem('Jaringan'),
        ),
      ],
      onSelected: onSelected,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE3F2FD), // Warna Biru Muda
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.settings,
            color: Color(0xFF1E88E5), // Warna Biru Ikon
          ),
        ),
      ),
    );
  }
}