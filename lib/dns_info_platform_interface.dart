import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'dns_info_method_channel.dart';

abstract class DnsInfoPlatform extends PlatformInterface {
  /// Constructs a DnsInfoPlatform.
  DnsInfoPlatform() : super(token: _token);

  static final Object _token = Object();

  static DnsInfoPlatform _instance = MethodChannelDnsInfo();

  /// The default instance of [DnsInfoPlatform] to use.
  ///
  /// Defaults to [MethodChannelDnsInfo].
  static DnsInfoPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DnsInfoPlatform] when
  /// they register themselves.
  static set instance(DnsInfoPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<List<String>?> getDnsServers() {
    throw UnimplementedError('getDnsServers() has not been implemented.');
  }
}
