import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class EmergencyContactsScreen extends StatefulWidget {
  const EmergencyContactsScreen({super.key});

  @override
  State<EmergencyContactsScreen> createState() =>
      _EmergencyContactsScreenState();
}

class _EmergencyContactsScreenState
    extends State<EmergencyContactsScreen> {

  final List<Map<String, String>> contacts = [];

  void addContactDialog() {

    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final relationshipController = TextEditingController();

    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text("Add Emergency Contact"),

          content: SingleChildScrollView(
            child: Column(
              children: [

                TextField(

                  controller: nameController,

                  decoration: const InputDecoration(
                    labelText: "Contact Name",
                  ),
                ),

                const SizedBox(height: 10),

                TextField(

                  controller: phoneController,

                  keyboardType: TextInputType.number,

                  inputFormatters: [

                    FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9]'),
                    ),

                    LengthLimitingTextInputFormatter(10),
                  ],

                  decoration: const InputDecoration(
                    labelText: "Phone Number",
                  ),
                ),

                const SizedBox(height: 10),

                TextField(

                  controller: relationshipController,

                  decoration: const InputDecoration(
                    labelText: "Relationship",
                  ),
                ),
              ],
            ),
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),

              onPressed: () {

                if (contacts.length >= 3) {

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Maximum 3 emergency contacts allowed",
                      ),
                    ),
                  );

                  return;
                }

                if (phoneController.text.length != 10) {

                  ScaffoldMessenger.of(context).showSnackBar(

                    const SnackBar(

                      content: Text(
                        'Phone number must contain 10 digits',
                      ),
                    ),
                  );

                  return;
                }

                setState(() {

                  contacts.add({

                    "name": nameController.text,
                    "phone": phoneController.text,
                    "relationship":
                    relationshipController.text,
                  });
                });

                Navigator.pop(context);
              },

              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void deleteContact(int index) {

    setState(() {
      contacts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Emergency Contacts"),
        backgroundColor: Colors.red,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,

        onPressed: addContactDialog,

        child: const Icon(Icons.add),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(20),
              ),

              child: const Column(

                children: [

                  Icon(
                    Icons.shield,
                    color: Colors.red,
                    size: 50,
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Emergency Protection",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Your emergency contacts will be alerted automatically during accidents.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Expanded(

              child: contacts.isEmpty

                  ? const Center(
                child: Text(
                  "No emergency contacts added",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              )

                  : ListView.builder(

                itemCount: contacts.length,

                itemBuilder: (context, index) {

                  final contact = contacts[index];

                  return Card(

                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 15),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: ListTile(

                      leading: CircleAvatar(
                        backgroundColor: Colors.red.shade100,
                        child: const Icon(
                          Icons.person,
                          color: Colors.red,
                        ),
                      ),

                      title: Text(
                        contact["name"] ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      subtitle: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          const SizedBox(height: 5),

                          Text(
                            "📞 ${contact["phone"]}",
                          ),

                          Text(
                            "Relationship: ${contact["relationship"]}",
                          ),
                        ],
                      ),

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