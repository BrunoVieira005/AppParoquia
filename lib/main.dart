import 'package:flutter/material.dart';
import 'package:projeto_extensao/pages/Horarios.dart'; // Importa a página de Horários

void main() {
  runApp(MyApp()); // Inicia o aplicativo chamando a classe MyApp
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove o banner de debug da tela
      home: HomePage(), // Define HomePage como a tela inicial do aplicativo
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState(); // Cria o estado da HomePage
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Índice da página ativa, inicia na primeira página (índice 0)

  // Função que altera a página exibida ao clicar no BottomNavigationBar
  void _navigateToPage(int index) {
    setState(() {
      _selectedIndex = index; // Atualiza o índice da página ativa
    });

    // Se o índice for 1 (Horários), navega para a página HorariosPage
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HorariosScreen()), // Navega para a página Horários
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Deixa o AppBar transparente
        elevation: 0, // Remove a sombra do AppBar
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.brown), // Ícone de menu
          onPressed: () {}, // Função chamada quando o ícone de menu é pressionado
        ),
      ),
      body: Container(
        width: double.infinity, // Ocupa toda a largura da tela
        height: double.infinity, // Ocupa toda a altura da tela
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fundo.png'), // Fundo com imagem
            fit: BoxFit.cover, // A imagem se ajusta ao tamanho da tela
          ),
        ),
        child: SingleChildScrollView( // Permite rolar a tela
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Centraliza os elementos
            children: [
              Image.asset('assets/images/logo.png', height: 100), // Logo da Paróquia
              Text(
                'PARÓQUIA SANTA MONICA',
                style: TextStyle(
                    fontFamily: 'Castellar',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFC29A51)), // Estilo do título
              ),
              SizedBox(height: 20), // Espaço entre os elementos
              _buildCard(
                title: 'Calendário Litúrgico',
                description:
                    'Acompanhe o calendário litúrgico e suas celebrações.',
                icon: Icons.calendar_today,
                onTap: () {}, // Função de onTap para o card
              ),
              SizedBox(height: 10), // Espaço entre os elementos
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Centraliza os ícones
                children: [
                  _buildIconButton(Icons.access_time, 'Horários', () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HorariosScreen()), // Navega para a página de Horários
                    );
                  }),
                  _buildIconButton(Icons.self_improvement, 'Orações', () {}),
                  _buildIconButton(Icons.church, 'Sobre', () {}),
                ],
              ),
              SizedBox(height: 10), // Espaço entre os elementos
              _buildCard(
                title: 'Eventos da Paróquia',
                description:
                    'Fique informado sobre as celebrações e atividades.',
                icon: Icons.event,
                onTap: () {}, // Função de onTap para o card
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Índice da página selecionada
        onTap: _navigateToPage, // Função chamada ao clicar no BottomNavigationBar
        selectedItemColor: Colors.brown, // Cor do item selecionado
        unselectedItemColor: Colors.grey, // Cor dos itens não selecionados
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'), // Item "Início"
          BottomNavigationBarItem(
              icon: Icon(Icons.access_time), label: 'Horários'), // Item "Horários"
          BottomNavigationBarItem(
              icon: Icon(Icons.self_improvement), label: 'Orações'), // Item "Orações"
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'), // Item "Chat"
          BottomNavigationBarItem(icon: Icon(Icons.church), label: 'Sobre'), // Item "Sobre"
        ],
      ),
    );
  }

  // Função para criar o card
  Widget _buildCard({
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        color: Color(0xFFC29A51), // Cor do card
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), // Bordas arredondadas
        child: ListTile(
          leading: Icon(icon, color: Color(0xFF7B5101), size: 40), // Ícone no card
          title: Text(title,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)), // Título do card
          subtitle: Text(description, style: TextStyle(color: Colors.white70)), // Descrição do card
          onTap: onTap, // Função chamada quando o card é pressionado
        ),
      ),
    );
  }

  // Função para criar os botões com ícones
  Widget _buildIconButton(IconData icon, String label, VoidCallback onTap) {
    return Expanded(
      child: Column(
        children: [
          IconButton(
              icon: Icon(icon, size: 40, color: Colors.brown), // Ícone do botão
              onPressed: onTap), // Função chamada ao pressionar o botão
          Text(label, style: TextStyle(color: Colors.brown)), // Texto do botão
        ],
      ),
    );  
  }
}
