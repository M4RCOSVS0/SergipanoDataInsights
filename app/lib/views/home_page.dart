// lib/views/home_page.dart
import 'package:flutter/material.dart';
import '../models/time.dart';
import '../services/time_service.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TimeService _timeService = TimeService();
  List<Time> _times = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadTimes();
  }

  Future<void> _loadTimes() async {
    try {
      final times = await _timeService.getTimes(minTitulos: 0);
      setState(() {
        _times = times;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campeonato Sergipano'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(child: Text('Erro: $_error'));
    }

    if (_times.isEmpty) {
      return const Center(child: Text('Nenhum time encontrado'));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.1,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _times.length,
      itemBuilder: (context, index) {
        final time = _times[index];
        return _buildTimeCard(time);
      },
    );
  }

  Widget _buildTimeCard(Time time) {
    DateTime fundacao = DateTime.parse(time.fundacao);
    String dataFormatada = DateFormat('dd/MM/yyyy').format(fundacao);

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              time.escudo,
              height: 80,
              width: 80,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.sports_soccer,
                size: 80,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              time.nome,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            _infoItem('Títulos', '${time.titulos}'),
            _infoItem('Participações', '${time.participacoes}'),
            _infoItem('Fundação', dataFormatada),
            _infoItem('Sede', time.sede),
          ],
        ),
      ),
    );
  }

  Widget _infoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}