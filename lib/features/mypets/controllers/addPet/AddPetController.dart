import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawrentingreborn/data/repositories/PetRepo.dart';
import 'package:pawrentingreborn/features/mypets/models/petModel.dart';
import 'package:pawrentingreborn/utils/constants/images_strings.dart';

class PetController extends GetxController {
  final PetRepo petRepo = PetRepo.instance;
  RxList<PetModel> petsList = <PetModel>[].obs;

  String type = 'none';
  String name = '';

  final nameController = TextEditingController();
  final speciesController = TextEditingController();
  final genderController = TextEditingController();
  final breedController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchPets();
  //   ever(petsList, (_) {
  //     for (var pet in petsList) {
  //       print(pet.name);
  //     }
  //   });
  // }

  // Future<void> fetchPets() async {
  //   final pets = await petRepo.getPetsForUser(_);
  //   petsList.assignAll(pets);
  // }

  // void addPet(PetModel pet) async {
  //   await petRepo.createPet(pet);
  //   petsList.add(pet);
  // }

  // void testAdd() async {
  //   PetModel pet = PetModel(
  //     id: 'P02',
  //     name: 'Test Pet',
  //     species: 'Cat',
  //     gender: 'Male',
  //     breeds: 'European Shorthair',
  //     dateOfBirth: DateTime(20, 1, 1),
  //     height: 50.0,
  //     weight: 20.0,
  //     image: TImages.whiskey,
  //   );
  //   await petRepo.addPet(pet);
  //   petsList.add(pet);
  // }
}
