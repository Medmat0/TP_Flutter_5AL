import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PostCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onEdit;

  const PostCard({
    Key? key,
    required this.title,
    required this.description,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Coins arrondis
      ),
      color: Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        trailing: Tooltip(
          message: 'Edit Post',
          child: IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () {
              HapticFeedback.lightImpact();
              onEdit();
            },
          ),
        ),
      ),
    );
  }
}
