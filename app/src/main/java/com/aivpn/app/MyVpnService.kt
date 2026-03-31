package com.aivpn.app

import android.content.Intent
import android.net.VpnService
import android.os.ParcelFileDescriptor

class MyVpnService : VpnService() {

    private var vpnInterface: ParcelFileDescriptor? = null

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        // VPN Tünelini Oluşturma Ayarları
        val builder = Builder()

        try {
            // Örnek VPN Ayarları (Gerçek bir sunucu adresi gerekir)
            vpnInterface = builder.setSession("AI VPN")
                .addAddress("10.0.0.2", 24)
                .addDnsServer("8.8.8.8")
                .addRoute("0.0.0.0", 0)
                .establish()
        } catch (e: Exception) {
            e.printStackTrace()
        }

        return START_STICKY
    }

    override fun onDestroy() {
        super.onDestroy()
        try {
            vpnInterface?.close()
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }
}
