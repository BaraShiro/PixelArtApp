import 'package:flutter/material.dart';
import 'package:pixelart_shared/pixelart_shared.dart';

class EditInfoModal extends StatefulWidget {
  final PixelArt art;
  final Participant user;
  const EditInfoModal({super.key, required this.art, required this.user});

  @override
  State<StatefulWidget> createState() => _EditInfoModalState();
}

class _EditInfoModalState extends State<EditInfoModal> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    nameController.text = widget.art.name;
    descriptionController.text = widget.art.description;

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Edit pixel art info",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(width: 10, height: 10,),
            TextFormField(
              controller: nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "You can't have an empty name, please enter a name";
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
                labelText: 'Name',
                hintText: "Mandatory, can't be empty",
              ),
            ),
            const SizedBox(width: 10, height: 10,),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
                labelText: "Description",
                hintText: "Optional, can be left empty",
              ),
            ),
            const SizedBox(width: 10, height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, null),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // TODO: check if user is in editors and add if not
                      PixelArt newArt = widget.art.copyWith(
                        name: nameController.text,
                        description: descriptionController.text,
                      );
                      Navigator.pop(context, newArt);
                    }
                  },
                  child: const Text("Update"),
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }

}