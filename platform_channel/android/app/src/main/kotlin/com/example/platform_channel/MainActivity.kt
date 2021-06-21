package com.example.platform_channel

import android.os.Build
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {
    private var geolocation: Geolocation? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val messenger = flutterEngine.dartExecutor.binaryMessenger
        val methodChannel = MethodChannel(messenger, "app.nain/my_first_platform_channel")
        geolocation = Geolocation(this, flutterEngine)
        methodChannel.setMethodCallHandler { call: MethodCall?, result: MethodChannel.Result? ->
            if (call?.method.equals("version")) {
                // val number = call!!.arguments as Int
                // Log.i("FLUTTER:::", "" + number)
                // val numbers = call.arguments as ArrayList<Int>
                // for (item in numbers) {
                //    Log.i("FLUTTER::: item", "" + item)
                // }
                val name: String? = call!!.argument("name")
                val lastname: String? = call.argument("lastname")
                val age: Int? = call.argument("age")
                Log.i("FLUTTER::: name", name!!)
                Log.i("FLUTTER::: lastname", lastname!!)
                Log.i("FLUTTER::: age", age.toString())

                val version = getAndroidVersion()
                result!!.success(version)
            } else {
                result?.notImplemented();
            }
        }
    }

    fun getAndroidVersion(): String? {
        val sdkVersion = Build.VERSION.SDK_INT
        val release = Build.VERSION.RELEASE
        return "Android version: $sdkVersion ($release)"
    }

    override fun onDestroy() {
        geolocation!!.stop()
        super.onDestroy()
    }
}
