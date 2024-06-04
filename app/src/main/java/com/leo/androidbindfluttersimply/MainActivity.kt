package com.leo.androidbindfluttersimply

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.idlefish.flutterboost.FlutterBoost
import com.idlefish.flutterboost.FlutterBoostRouteOptions
import java.util.*
import kotlin.collections.HashMap


class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val options = FlutterBoostRouteOptions.Builder()
            .pageName("mainPage")
            .arguments(HashMap())
            .requestCode(1111)
            .uniqueId(UUID.randomUUID().toString())
            .build()
        FlutterBoost.instance().open(options)


    }
}