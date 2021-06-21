package com.example.flutter_app

import androidx.annotation.NonNull
import com.stripe.android.ApiResultCallback
import com.stripe.android.PaymentConfiguration
import com.stripe.android.PaymentIntentResult
import com.stripe.android.Stripe
import com.stripe.android.model.ConfirmPaymentIntentParams
import com.stripe.android.model.PaymentIntent
import com.stripe.android.model.PaymentMethodCreateParams
import com.stripe.android.model.StripeIntent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity: FlutterActivity() {
    private val CHANNEL = "nain.flutter.dev/battery"

    var result: MethodChannel.Result? = null
    var stripe: Stripe? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "init" -> {
                    val pk: String? = call.argument("pk")
                    PaymentConfiguration.init(
                            getApplicationContext(),pk!!
                    )
                    result.success(null)
                }
                "pay" -> {
                    this.makePay(call, result)
                }
                else -> {
                    result.notImplemented();
                }
            }
        }

        val registry = ShimPluginRegistry(flutterEngine)
        val registrar: PluginRegistry.Registrar = registry.registrarFor(CHANNEL)
        registrar.addActivityResultListener { requestCode, resultCode, data ->
            if (stripe != null) {
                stripe?.onPaymentResult(requestCode, data, object : ApiResultCallback<PaymentIntentResult> {

                    override fun onSuccess(result: PaymentIntentResult) {
                        var intent: PaymentIntent = result.intent
                        val status = intent.status
                        when (status) {
                            StripeIntent.Status.Succeeded -> sendResult("succeeded")
                            StripeIntent.Status.Canceled -> sendResult("canceled")
                            else -> sendResult("failed")
                        }
                    }

                    override fun onError(e: Exception) {
                        sendResult("error")
                    }
                })
            }
            true
        }
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }

    private fun makePay(call: MethodCall, result: MethodChannel.Result) {
        if (this.result != null) {
            result.error("PENDING_TASK", "You have a pending task", null)
            return
        }
        this.result = result
        val clientSecret = call.argument<String>("clientSecret")
        val cardNumber = call.argument<String>("cardNumber")
        val cvv = call.argument<String>("cvv")
        val year = call.argument<Int>("year")!!
        val month = call.argument<Int>("month")!!
        val card = PaymentMethodCreateParams.Card.Builder()
                .setCvc(cvv).setExpiryMonth(month).setExpiryYear(year).setNumber(cardNumber).build()
        val params = PaymentMethodCreateParams.create(card)
        val confirmPaymentIntentParams = ConfirmPaymentIntentParams.createWithPaymentMethodCreateParams(params, clientSecret!!)
        stripe = Stripe(this, PaymentConfiguration.getInstance(this).publishableKey)
        stripe!!.confirmPayment(this, confirmPaymentIntentParams)
    }

    private fun sendResult(status: String) {
        val response: HashMap<String, String> = HashMap()
        response["status"] = status
        result?.success(response)
        result = null
    }
}
