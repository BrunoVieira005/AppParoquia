import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HorariosScreen(),
    );
  }
}

class HorariosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown.shade200,
        title: Text('Paróquia Santa Monica'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSectionTitle('Horários'),
            _buildCard('Atendimento Padre',
                ['Terça-Feira\n8H às 12H', 'Sábado\n8H às 12H']),
            _buildCard('Atendimento Secretaria', [
              'Terça-Feira\n8H às 12H',
              'Quarta a Sexta-Feira\n12H às 17H45H',
              'Sábado\n8H às 12H'
            ]),
            _buildCard('Missa', ['Sábado\n19H30', 'Domingo\n8H']),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.church), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: ''),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold, color: Colors.brown),
      ),
    );
  }

  Widget _buildCard(String title, List<String> details) {
    return Card(
      color: Colors.brown.shade100,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown.shade800),
            ),
            SizedBox(height: 8.0),
            for (var detail in details)
              Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Text(
                  detail,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
