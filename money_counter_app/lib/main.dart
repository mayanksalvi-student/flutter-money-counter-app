import 'package:flutter/material.dart';

void main() {
  runApp(MoneyCounterApp());
}

class MoneyCounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MoneyCounterScreen(),
    );
  }
}

class MoneyCounterScreen extends StatefulWidget {
  @override
  _MoneyCounterScreenState createState() => _MoneyCounterScreenState();
}

class _MoneyCounterScreenState extends State<MoneyCounterScreen> {
  final List<Map<String, dynamic>> denominations = [
    {"value": 1000, "label": "1K Rupee Notes"},
    {"value": 500, "label": "500 Rupee Notes"},
    {"value": 200, "label": "200 Rupee Notes"},
    {"value": 100, "label": "100 Rupee Notes"},
    {"value": 50, "label": "50 Rupee Notes"},
    {"value": 20, "label": "20 Rupee Notes"},
    {"value": 10, "label": "10 Rupee Notes"},
    {"value": 5, "label": "5 Rupee Notes"},
    {"value": 2, "label": "2 Rupee Coins"},
    {"value": 1, "label": "1 Rupee Coins"}
  ];

  Map<int, TextEditingController> controllers = {};
  int totalAmount = 0;

  @override
  void initState() {
    super.initState();
    // Initialize text editing controllers
    for (var denomination in denominations) {
      controllers[denomination['value']] = TextEditingController();
    }
  }

  @override
  void dispose() {
    // Clean up controllers
    controllers.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }

  void clearInputs() {
    controllers.forEach((key, controller) {
      controller.clear();
    });
    setState(() {
      totalAmount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Money Counter'),
        actions: [
          TextButton(
            onPressed: clearInputs,
            child: const Text(
              'Clear',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: denominations.map((denomination) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('${denomination['label']}:'),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: controllers[denomination['value']],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText:
                                'Enter number of ${(denomination['label'] as String).toLowerCase()}',
                          ),
                          onChanged: (value) {
                            calculateTotal();
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Total Amount:',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              '$totalAmount',
              style:
                  const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void calculateTotal() {
    int sum = 0;
    controllers.forEach((key, controller) {
      int count = int.tryParse(controller.text) ?? 0;
      sum += count * key;
    });
    setState(() {
      totalAmount = sum;
    });
  }
}
