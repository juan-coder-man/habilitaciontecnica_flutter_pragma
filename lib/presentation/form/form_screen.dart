import 'package:flutter/material.dart';
import 'package:habilitaciontecnica_flutter_pragma/data/repositories/items_repository_impl.dart';
import 'package:habilitaciontecnica_flutter_pragma/domain/entities/item.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key, this.editingItem});

  final Item? editingItem;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final item = widget.editingItem;
    _titleController = TextEditingController(text: item?.title ?? '');
    _descriptionController = TextEditingController(
      text: item?.description ?? '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.editingItem != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar elemento' : 'Nuevo elemento'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Título',
                hintText: 'Ingresa el título',
              ),
              textCapitalization: TextCapitalization.sentences,
              validator: (value) {
                final t = value?.trim() ?? '';
                if (t.isEmpty) return 'El título es obligatorio';
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                hintText: 'Ingresa la descripción',
              ),
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _isSaving ? null : _save,
              icon: _isSaving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(isEditing ? Icons.save : Icons.add),
              label: Text(isEditing ? 'Guardar' : 'Agregar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _isSaving = true);
    final repository = context.read<ItemsRepositoryImpl>();
    final now = DateTime.now();
    final item = widget.editingItem;
    if (item != null) {
      await repository.update(
        item.copyWith(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
        ),
      );
    } else {
      await repository.add(
        Item(
          id: '',
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          createdAt: now,
        ),
      );
    }
    if (!mounted) return;
    setState(() => _isSaving = false);
    Navigator.pop(context);
  }
}
