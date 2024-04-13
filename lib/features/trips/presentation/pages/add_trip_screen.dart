import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entitites/trip.dart';
import '../providers/trip_provider.dart';

// ignore: must_be_immutable
class AddTripScreen extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController(text: "");
  final _descController = TextEditingController(text: "");
  final _locationController = TextEditingController(text: "");
  final _pictureController = TextEditingController(text: '');
  List<String> pictures = [];

  AddTripScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),

          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter your trip title',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter your trip description',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  hintText: 'Enter your trip location',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _pictureController,
                decoration: const InputDecoration(
                  labelText: 'Link URL Photo',
                  hintText: 'Enter your trip photo',
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  pictures.add(_pictureController.text);
                  if (_formKey.currentState!.validate()) {
                    final newTrip = Trip(
                      title: _titleController.text,
                      description: _descController.text,
                      date: DateTime.now(),
                      location: _locationController.text,
                      photos: pictures,
                    );
                    ref.read(tripListNotifierProvider.notifier).addNewTrip(newTrip);
                    ref.read(tripListNotifierProvider.notifier).loadTrips();
                    // Navigator.pop(context);
                  }
                },
                child: const Text('Add Trip'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
