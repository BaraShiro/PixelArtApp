import 'package:flutter/material.dart';
import 'package:pixelart_shared/pixelart_shared.dart';
import 'package:pixelart/art_listing/art_listing.dart';

class AddArtModal extends StatefulWidget {
  final Participant user;
  const AddArtModal({super.key, required this.user});

  @override
  State<StatefulWidget> createState() => _AddArtModalState();
}

class _AddArtModalState extends State<AddArtModal> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  int _width = 32;
  int _height = 32;

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Create new empty pixel art",
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
              children: [
                const SizedBox(
                  width: 48,
                  child: Text("Width"),
                ),
                Expanded(
                  child: Slider(
                    min: 16,
                    max: 48,
                    divisions: 4,
                    label: _width.toString(),
                    value: _width.toDouble(),
                    onChanged: (double value) {
                      setState(() {
                        _width = value.round();
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 48,
                  child: Text("Height"),
                ),
                Expanded(
                  child: Slider(
                    min: 16,
                    max: 48,
                    divisions: 4,
                    label: _height.toString(),
                    value: _height.toDouble(),
                    onChanged: (double value) {
                      setState(() {
                        _height = value.round();
                      });
                    },
                  ),
                ),
              ],
            ),
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
                      PixelArt newArt = constructNewPixelArt(
                          creator: widget.user,
                          name: nameController.text,
                          description: descriptionController.text,
                          width: _width.round(),
                          height: _height);
                      Navigator.pop(context, newArt);
                    }
                  },
                  child: const Text("Create new"),
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }

}