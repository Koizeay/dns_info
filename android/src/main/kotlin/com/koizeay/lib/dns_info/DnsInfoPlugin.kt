package com.koizeay.lib.dns_info

import android.net.ConnectivityManager
import android.net.LinkProperties
import android.net.Network
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.net.InetAddress

/** DnsInfoPlugin */
class DnsInfoPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel
  private lateinit var connectivityManager: ConnectivityManager

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "dns_info")
    channel.setMethodCallHandler(this)
    connectivityManager = flutterPluginBinding.applicationContext.getSystemService(ConnectivityManager::class.java)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getDnsServers") {
      result.success(getDnsServers())
    } else {
      result.notImplemented()
    }
  }

  private fun getDnsServers(): List<String> {
    val activeNetwork: Network = connectivityManager.activeNetwork ?: return listOf()
    val props: LinkProperties = connectivityManager.getLinkProperties(activeNetwork) ?: return listOf()
    val dnsServers: MutableList<String> = ArrayList()
    for (address: InetAddress in props.dnsServers) {
      dnsServers.add(address.hostAddress)
    }
    return dnsServers.toList()
    return listOf()
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
