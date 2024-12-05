import 'package:flutter/material.dart';
import 'package:tp_synchronisation/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(Object context) {
    final fakeDatabase = FakeDatabase();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Synchronisation TP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Utilisateur :',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            FutureBuilder<Map<String, String>>(
                future: fakeDatabase.fetchUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Erreur : ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final userData = snapshot.data!;
                    return Text(
                      'Nom : ${userData['name']}\nEmail : ${userData['email']}',
                      style: const TextStyle(fontSize: 16),
                    );
                  } else {
                    return const Text('Aucune donnée disponible.');
                  }
                }),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Notifications :',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: StreamBuilder<String>(
                stream: fakeDatabase.fetchNotifications(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('En attente de notifications...');
                  } else if (snapshot.hasError) {
                    return Text('Erreur : ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return ListTile(
                      title: Text(snapshot.data!),
                      leading: const Icon(Icons.notification_important),
                    );
                  } else {
                    return const Text('Aucune Notification');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
