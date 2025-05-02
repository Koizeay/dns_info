import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:dns_info/dns_info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> _dnsServers = [];
  final _dnsInfoPlugin = DnsInfo();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    List<String>? dnsServers;
    try {
      dnsServers = await _dnsInfoPlugin.getDnsServers() ?? [];
    } on PlatformException {
      dnsServers = [];
    }

    if (!mounted) return;

    setState(() {
      _dnsServers = dnsServers ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('DNS info example app'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'DNS servers',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                if (_dnsServers.isEmpty)
                  const Text(
                    'No DNS servers found',
                    style: TextStyle(fontSize: 18),
                  ),
                for (var server in _dnsServers)
                  Text(
                    server,
                    style: const TextStyle(fontSize: 18),
                  ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
