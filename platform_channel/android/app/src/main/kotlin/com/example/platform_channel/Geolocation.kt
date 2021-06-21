package com.example.platform_channel

import android.Manifest
import android.annotation.SuppressLint
import android.app.Activity
import android.content.pm.PackageManager
import android.location.Location
import android.os.Build
import android.os.Looper
import android.util.Log
import androidx.core.content.ContextCompat
import com.google.android.gms.location.*
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.PluginRegistry


class Geolocation(private var activity: Activity?, flutterEngine: FlutterEngine?) : MethodCallHandler, EventChannel.StreamHandler {

    private var flutterResult: MethodChannel.Result? = null
    val REQUEST_CODE = 1204

    private var fusedLocationClient: FusedLocationProviderClient? = null
    private var events: EventSink? = null

    init {
        this.fusedLocationClient = LocationServices.getFusedLocationProviderClient(activity!!)
        val messenger = flutterEngine!!.dartExecutor.binaryMessenger
        val channel = MethodChannel(messenger, "app.nain/geolocation")
        val eventChannel = EventChannel(messenger, "app.nain/geolocation-listener")
        eventChannel.setStreamHandler(this)
        channel.setMethodCallHandler(this)

        val registry = ShimPluginRegistry(flutterEngine)
        val registrar: PluginRegistry.Registrar = registry.registrarFor("app.meedu/geolocation")

        registrar.addRequestPermissionsResultListener { requestCode, permissions, grantResults ->
            if (requestCode === REQUEST_CODE) {
                if (grantResults.size > 0 && grantResults[0] === PackageManager.PERMISSION_GRANTED) {
                    flutterResult!!.success("granted")
                } else {
                    flutterResult!!.success("denied")
                }
                flutterResult = null
            }
            false
        }
    }

    private val locationCallback: LocationCallback = object : LocationCallback() {
        override fun onLocationResult(locationResult: LocationResult) {
            if (locationResult != null) {
                val location: Location = locationResult.lastLocation
                if (events != null) {
                    val data: HashMap<String, Double> = HashMap()
                    data["lat"] = location.latitude
                    data["lng"] = location.longitude
                    events!!.success(data)
                    Log.i("LALA", location.latitude.toString())
                }
            }
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "check" -> this.check(result)
            "request" -> this.request(result)
            "start" -> {
                this.start()
                result.success(null)
            }
            "stop" -> {
                this.stop()
                result.success(null)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    private fun check(result: MethodChannel.Result) {
        val status = ContextCompat.checkSelfPermission(this.activity!!, Manifest.permission.ACCESS_FINE_LOCATION)
        if (status == PackageManager.PERMISSION_GRANTED) {
            result.success("granted")
        } else {
            result.success("denied")
        }
    }

    private fun request(result: MethodChannel.Result) {
        if (flutterResult != null) {
            result.error("PENDING_TASK", "You have a pending task", null)
            return
        }
        flutterResult = result
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            activity!!.requestPermissions(arrayOf(
                    Manifest.permission.ACCESS_FINE_LOCATION
            ), REQUEST_CODE)
        } else {
            flutterResult?.success("granted")
            flutterResult = null
        }
    }

    @SuppressLint("MissingPermission")
    private fun start() {
        val locationRequest = LocationRequest.create()
        locationRequest.interval = 10000
        locationRequest.fastestInterval = 1000
        locationRequest.priority = LocationRequest.PRIORITY_HIGH_ACCURACY
        fusedLocationClient!!.requestLocationUpdates(locationRequest,
                locationCallback,
                Looper.getMainLooper())
    }

    fun stop() {
        fusedLocationClient?.removeLocationUpdates(locationCallback)
    }

    override fun onListen(arguments: Any?, events: EventSink?) {
        this.events = events
    }

    override fun onCancel(arguments: Any?) {
        TODO("Not yet implemented")
    }
}