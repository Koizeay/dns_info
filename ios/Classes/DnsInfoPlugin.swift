import Flutter
import UIKit
import Foundation

public class DnsInfoPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "dns_info", binaryMessenger: registrar.messenger())
    let instance = DnsInfoPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getDnsServers":
      result(getDnsServers())
    default:
      result(FlutterMethodNotImplemented)
    }
  }

    private func getDnsServers() -> [String] {
      var addresses = [String]()
      var res = __res_9_state()
      if res_9_ninit(&res) == 0 {
        for i in 0..<Int(res.nscount) {
          let addr = res.nsaddr_list.0.sin_addr
          var ip = [CChar](repeating: 0, count: Int(INET_ADDRSTRLEN))
          var addrCopy = addr
          inet_ntop(AF_INET, &addrCopy, &ip, socklen_t(INET_ADDRSTRLEN))
          if let dns = String(validatingUTF8: ip) {
            addresses.append(dns)
          }
        }
        res_9_nclose(&res)
      }
      return addresses
    }
}