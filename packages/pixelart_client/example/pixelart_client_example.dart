import 'dart:convert';
import 'dart:io';
import 'package:pixelart_client/pixelart_client.dart';
import 'package:pixelart_shared/pixelart_shared.dart';
import 'package:uuid/uuid.dart';

void main() async {
  // Encoder for pretty print
  final JsonEncoder encoder = JsonEncoder.withIndent('  ');

  // Initialize a UUID generator
  Uuid uuid = Uuid();

  // Create a new PixelArt object
  PixelArt art = PixelArt(
    id: uuid.v4(),
    name: uuid.v4(),
    description: uuid.v4(),
    width: 64,
    height: 64,
    editors: [],
    pixelMatrix: [[]],
  );

  // Create a new PixelArt object
  PixelArt moreArt = PixelArt(
    id: uuid.v4(),
    name: uuid.v4(),
    description: uuid.v4(),
    width: 64,
    height: 64,
    editors: [],
    pixelMatrix: [[]],
  );

  // Create a new PixelArt object
  PixelArt evenMoreArt = PixelArt(
    id: uuid.v4(),
    name: uuid.v4(),
    description: uuid.v4(),
    width: 64,
    height: 64,
    editors: [],
    pixelMatrix: [[]],
  );

  // Initialize the repository
  final repository = HTTPPixelArtRepository(url: "localhost:8080/pixelart");
  var connected = false;
  for (int i = 0; i < 10; i++) {
    var response = await repository.list();
    if (response.isFailure && response.status == CRUDStatus.NetworkError) {
      print(
          "NetworkError connecting to server. Is the server up and running? Start with 'dart_frog dev'");
      await Future.delayed(Duration(seconds: 2));
    } else {
      connected = true;
      break;
    }
  }

  if (!connected) {
    print(
        "Unable to connect to server. Is the server up and running? Start with 'dart_frog dev'");
    print("Exiting. Try again.");
    exit(255);
  }

  // Create some PixelArt and save it to the repository
  final createResult = await repository.create(art);
  print("");
  print("Created art with id: ${art.id} in repository. Success: ${createResult.isSuccess}");

  // Read it back and print it
  final readResult = await repository.read(art.id);
  print("");
  print("Read art with id: ${art.id} from repository. Success: ${readResult.isSuccess}");
  if(readResult.isSuccess && readResult.value != null) {
    print(encoder.convert(readResult.value!.toJson()));
  }

  // Add some more art so we can list it
  final moreResult1 = await repository.create(moreArt);
  final moreResult2 = await repository.create(evenMoreArt);
  print("");
  print("Add two more pieces of art to repository. Success: ${moreResult1.isSuccess} & ${moreResult2.isSuccess}");

  // List all art in the repository
  final listResult = await repository.list();
  print("");
  print("List the names of all art in repository. Success: ${listResult.isSuccess}");
  if(listResult.isSuccess && listResult.value != null) {
    print(listResult.value!.map((val) => encoder.convert(val.name)));
  }

  // Update some art and read it back
  PixelArt newArt = art.copyWith(name: uuid.v4());
  final updateResult = await repository.update(art.id, newArt);
  print("");
  print("Update the name of some art in repository. Success: ${updateResult.isSuccess}");
  if(updateResult.isSuccess && updateResult.value != null) {
    print("Old name: ${art.name}, New name: ${updateResult.value!.name}");
  }

  // Update the art tree time with a one second delay
  void makeDelayedUpdates() async {
    print("Wait one second before update...");
    await Future.delayed(Duration(seconds: 1));
    await repository.update(art.id, art.copyWith(name: uuid.v4()));
    print("Wait one second before next update...");
    await Future.delayed(Duration(seconds: 1));
    await repository.update(art.id, art.copyWith(name: uuid.v4()));
    print("Wait one second before next update...");
    await Future.delayed(Duration(seconds: 1));
    await repository.update(art.id, art.copyWith(name: uuid.v4()));
  }

  // Stream changes on some art
  print("");
  print("Stream and listen for changes on some art.");
  final stream = await repository.changes(art.id);
  makeDelayedUpdates();

  await for(final value in stream.take(3)) {
    if(value != null) {
      print("Name changed: ${value.name}");
    }
  }

  // Delete the all art from repository
  final deleteResult1 = await repository.delete(art.id);
  final deleteResult2 = await repository.delete(moreArt.id);
  final deleteResult3 = await repository.delete(evenMoreArt.id);
  print("");
  print("Delete all art from repository. Success: ${deleteResult1.isSuccess} & ${deleteResult2.isSuccess} & ${deleteResult3.isSuccess}");

  // Exit the application
  print("");
  print('Exiting application.');
  exit(0);
}
