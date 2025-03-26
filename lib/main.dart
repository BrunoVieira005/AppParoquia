import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.brown),
          onPressed: () {},
        ),
      ),
      body: Container(
        width: double.infinity, // Ocupa toda a largura
        height: double.infinity, // Ocupa toda a altura
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fundo.png'),
            fit: BoxFit.cover, // Faz a imagem cobrir toda a área
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', height: 100),
              Text(
                'PARÓQUIA SANTA MONICA',
                style: TextStyle(fontFamily: 'Castellar', fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFC29A51)
                ),
              ),
              SizedBox(height: 20),
              _buildCard(
                title: 'Calendário Litúrgico',
                description: 'Acompanhe o calendário litúrgico e suas celebrações.',
                icon: Icons.calendar_today,
                onTap: () {},
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIconButton(Icons.access_time, 'Horários', () {}),
                  _buildIconButton(Icons.self_improvement, 'Orações', () {}),
                  _buildIconButton(Icons.church, 'Sobre', () {}),
                ],
              ),
              SizedBox(height: 10),
              _buildCard(
                title: 'Eventos da Paróquia',
                description: 'Fique informado sobre as celebrações e atividades.',
                icon: Icons.event,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.access_time), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.self_improvement), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.church), label: ''),
        ],
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        color: Color(0xFFC29A51),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          leading: Icon(icon, color: Color(0xFF7B5101), size: 40),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          subtitle: Text(description, style: TextStyle(color: Colors.white70)),
          onTap: onTap,
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String label, VoidCallback onTap) {
    return Expanded(
      child: Column(
        children: [
          IconButton(icon: Icon(icon, size: 40, color: Colors.brown), onPressed: onTap),
          Text(label, style: TextStyle(color: Colors.brown)),
        ],
      ),
    );
  }
}
