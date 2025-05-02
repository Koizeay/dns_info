import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'dns_info_platform_interface.dart';

/// An implementation of [DnsInfoPlatform] that uses method channels.
class MethodChannelDnsInfo extends DnsInfoPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('dns_info');

  @override
  Future<List<String>?> getDnsServers() async {
    final dnsServers = await methodChannel.invokeMethod<List<Object?>>('getDnsServers');
    if (dnsServers == null) {
      return null;
    }
    final List<String> dnsServersList = [];
    for (final dnsServer in dnsServers) {
      if (dnsServer is String) {
        dnsServersList.add(dnsServer);
      }
    }
    return dnsServersList;
  }
}
