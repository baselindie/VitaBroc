package com.example.vitabroc

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.ComponentName
import android.content.pm.PackageManager

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.vitabroc/icono"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "cambiarIcono") {
                val alias = call.argument<String>("alias")
                if (alias != null) {
                    cambiarIcono(alias)
                    result.success(null)
                } else {
                    result.error("ERROR", "Alias nulo", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun cambiarIcono(aliasActivo: String) {
        val aliases = listOf(
            "com.example.vitabroc.MainActivityFeliz",
            "com.example.vitabroc.MainActivityNormal",
            "com.example.vitabroc.MainActivityTriste"
        )
        aliases.forEach { alias ->
            val estado = if (alias == aliasActivo)
                PackageManager.COMPONENT_ENABLED_STATE_ENABLED
            else
                PackageManager.COMPONENT_ENABLED_STATE_DISABLED
            packageManager.setComponentEnabledSetting(
                ComponentName(this, alias),
                estado,
                PackageManager.DONT_KILL_APP
            )
        }
    }
}