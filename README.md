# DNS info

A Flutter plugin allowing to get DNS servers IP from the system (Android only)

### ⚠️ WIP This plugin is under development

## Usage
    
```dart
import 'package:dns_info/dns_info.dart';

final _dnsInfoPlugin = DnsInfo();
List<String>? dnsServers = await _dnsInfoPlugin.getDnsServers();
```

## License
This project is licensed under the MIT License
