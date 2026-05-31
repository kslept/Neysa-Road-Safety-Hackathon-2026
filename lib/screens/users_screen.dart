import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersScreen extends StatefulWidget {

  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() =>
      _UsersScreenState();
}

class _UsersScreenState
    extends State<UsersScreen> {

  final TextEditingController nameController =
  TextEditingController();

  final TextEditingController phoneController =
  TextEditingController();

  final TextEditingController relationshipController =
  TextEditingController();

  bool isPrimary = false;

  List<String> contacts = [];

  @override
  void initState() {
    super.initState();

    loadContacts();
  }

  Future<void> loadContacts() async {

    final prefs =
    await SharedPreferences.getInstance();

    setState(() {

      contacts =
          prefs.getStringList('contacts') ?? [];
    });
  }

  Future<void> saveContacts() async {

    final prefs =
    await SharedPreferences.getInstance();

    await prefs.setStringList(
      'contacts',
      contacts,
    );
  }

  void addContact() {

    String name =
    nameController.text.trim();

    String phone =
    phoneController.text.trim();

    if (name.isEmpty || phone.isEmpty) {
      return;
    }

    setState(() {

      String relationship =
      relationshipController.text.trim();

      String primaryLabel =
      isPrimary ? 'PRIMARY' : '';

      contacts.add(
        '$name | $relationship | $phone | $primaryLabel',
      );
    });

    saveContacts();

    nameController.clear();
    phoneController.clear();
    relationshipController.clear();

    isPrimary = false;
  }

  void deleteContact(int index) {

    setState(() {

      contacts.removeAt(index);
    });

    saveContacts();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Emergency Contacts',
        ),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(

              controller: nameController,

              decoration: const InputDecoration(
                labelText: 'Contact Name',
                border: OutlineInputBorder(),
              ),
            ),

            SwitchListTile(

              title: const Text(
                'Primary Emergency Contact',
              ),

              value: isPrimary,

              onChanged: (value) {

                setState(() {

                  isPrimary = value;
                });
              },
            ),

            const SizedBox(height: 20),

            TextField(

              controller: relationshipController,

              decoration: const InputDecoration(
                labelText: 'Relationship',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(

              controller: phoneController,

              keyboardType: TextInputType.phone,

              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton(

                onPressed: addContact,

                child: const Text(
                  'ADD CONTACT',
                ),
              ),
            ),

            const SizedBox(height: 30),

            Expanded(

              child: contacts.isEmpty

                  ? const Center(
                child: Text(
                  'No emergency contacts added.',
                ),
              )

                  : ListView.builder(

                itemCount: contacts.length,

                itemBuilder: (context, index) {

                  return Card(

                    child: ListTile(

                      leading: const Icon(
                        Icons.person,
                        color: Colors.red,
                      ),

                      title: Text(
                        contacts[index],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      subtitle: contacts[index].contains('PRIMARY')

                          ? const Text(
                        'Primary Emergency Contact',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      )

                          : null,

                      trailing: IconButton(

                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),

                        onPressed: () {

                          deleteContact(index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}