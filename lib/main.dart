import 'package:flutter/material.dart';
import 'package:projeto_extensao/pages/Login/Login.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:projeto_extensao/Horarios.dart'; // Importa a página de Horários
import 'package:projeto_extensao/sobre.dart';
import 'package:projeto_extensao/oracoes.dart';
import 'package:projeto_extensao/pages/Calendarios/CalendarioLitur.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);
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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePageContent(),
    HorariosScreen(),
    OracoesPage(),
    LoginScreen(), // Substitua pelas outras páginas
    SobrePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.access_time), label: 'Horários'),
          BottomNavigationBarItem(icon: Icon(Icons.self_improvement), label: 'Orações'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'info'),
          BottomNavigationBarItem(icon: Icon(Icons.church), label: 'Sobre'),
        ],
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/fundo.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', height: 100),
            Text(
              'PARÓQUIA SANTA MONICA',
              style: TextStyle(
                  fontFamily: 'Castellar',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC29A51)),
            ),
            SizedBox(height: 20),
            _buildCard(
              title: 'Calendário Litúrgico',
              description: 'Acompanhe o calendário litúrgico e suas celebrações.',
              icon: Icons.calendar_today,
              onTap: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarioPage()),
                 );
              },
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildIconButton(Icons.access_time, 'Horários', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HorariosScreen()),
                  );
                  // Navegação removida, pois o BottomNavigationBar gerencia as páginas
                }),
                _buildIconButton(Icons.self_improvement, 'Orações', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OracoesPage()),
                  );                  
                }),
                 _buildIconButton(Icons.church, 'Sobre', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SobrePage()),
                  );
                }),
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
          title: Text(title,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
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
          IconButton(
              icon: Icon(icon, size: 40, color: Colors.brown),
              onPressed: onTap),
          Text(label, style: TextStyle(color: Colors.brown)),
        ],
      ),
    );
  }
}
