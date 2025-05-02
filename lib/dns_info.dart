
import 'dns_info_platform_interface.dart';

class DnsInfo {
  Future<List<String>?> getDnsServers() {
    return DnsInfoPlatform.instance.getDnsServers();
  }
}
