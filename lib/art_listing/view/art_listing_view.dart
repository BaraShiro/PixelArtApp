import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pixelart/art_listing/art_listing.dart';
import 'package:pixelart_shared/pixelart_shared.dart';

class ArtListingView extends StatelessWidget {
  final List<PixelArt> pixelArtList;
  final Participant user;
  final TextEditingController textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  ArtListingView({super.key, required this.pixelArtList, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            const SizedBox(height: 32),
            header(context),
            switch (pixelArtList.isEmpty) {
              true => const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('No art found!'),
                      Text('Add a new artwork and start creating!')
                    ],
                  )),
              false => ListView.builder(
                shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: 200, top: 10),
                  itemCount: pixelArtList.length,
                  itemBuilder: (
                      BuildContext context,
                      int index,
                      ) {
                    return ArtListingCardWidget(pixelArt: pixelArtList[index]);
                  }),
            },
          ],
        ),
      ),
    );
  }

  Widget header(BuildContext context) {
    textEditingController.text = user.name;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(),
        Text("${user.name} ${user.id}"),
        changeNameForm(context),
        const Spacer(),
        SizedBox(
          height: 48,
          child: addButton(context),
        ),
        const Spacer(),
      ],
    );
  }

  Widget addButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => context.read<ArtListingBloc>().add(
          AddArtEvent(
              newArt: constructNewPixelArt(
                  creator: user,
                  name: "Test",
                  description: "Some test art",
                  width: 32,
                  height: 32
              ),
              user: user)
      ),
      icon: const Icon(Symbols.add),
      label: const Text("Add new empty art"),
    );
  }

  Widget changeNameForm(BuildContext context) {
    return Form(
    key: _formKey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 300,
            child: changeNameTextField(context),
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: 48,
            child: changeNameButton(context),
          ),
        ],
      )
    );
  }

  Widget changeNameTextField(BuildContext context) {
    return TextFormField(
      maxLength: 20,
      buildCounter: (BuildContext context, { int? currentLength, int? maxLength, bool? isFocused }) => null,
      validator: (value) {
        if(value == null || value.isEmpty) {
          return "Enter a valid username";
        }
        if(value == user.name) {
          return "Enter a new username";
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: textEditingController,
      decoration: const InputDecoration(
        isDense: true,
        border: OutlineInputBorder(),
        labelText: "Username",
        hintText: "Add a username",
      ),
    );
  }

  Widget changeNameButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Row(
              children: [
                Icon(Symbols.check, color: Colors.green),
                Text('Name updated'),
              ],
            )),
          );
          print(user.name);
          if(textEditingController.text == anon.name) {
            print("Anonymous");
            context.read<ArtListingBloc>().add(UpdateUserEvent(artList: pixelArtList, user: anon));
          }
          else {
            Participant newUser = constructNewUser(userName: textEditingController.text);
            print(newUser.name);
            context.read<ArtListingBloc>().add(UpdateUserEvent(artList: pixelArtList, user: newUser));
          }
        }
      },
      icon: const Icon(Symbols.signature),
      label: const Text("Update name"),
    );
  }
}