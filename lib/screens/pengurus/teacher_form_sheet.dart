import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/teacher.dart';
import '../../models/user_profile.dart';
import '../../services/firestore_service.dart';

class TeacherFormSheet extends StatefulWidget {
  const TeacherFormSheet({required this.profile, super.key});
  final UserProfile profile;

  @override
  State<TeacherFormSheet> createState() => _TeacherFormSheetState();
}

class _TeacherFormSheetState extends State<TeacherFormSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _topicController = TextEditingController();
  final _notesController = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _topicController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final firestore = context.read<FirestoreService>();
    final teacher = Teacher(
      id: '',
      name: _nameController.text.trim(),
      topic: _topicController.text.trim().isEmpty ? null : _topicController.text.trim(),
      notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
      createdBy: widget.profile.uid,
    );
    try {
      await firestore.addTeacher(teacher);
      if (!mounted) return;
      Navigator.pop(context);
    } on Exception catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menambah ustadz: ${e.toString()}')),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Tambah Ustadz', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nama'),
              validator: (value) => value == null || value.isEmpty ? 'Wajib diisi' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _topicController,
              decoration: const InputDecoration(labelText: 'Topik khusus (opsional)'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(labelText: 'Catatan'),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _saving ? null : _save,
                child: _saving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Simpan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
