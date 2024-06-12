import 'package:flutter/material.dart';

class AdmSrceen extends StatelessWidget {
  const AdmSrceen({super.key});

  void _runScript() {
    print("Script rodado!");
  }

  void _viewLogs(BuildContext context) {
    print("Log baixado!");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página do Script'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _runScript,
              child: Text('Rodar script'),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () => _viewLogs(context),
              child: Text(
                'Ver logs',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
