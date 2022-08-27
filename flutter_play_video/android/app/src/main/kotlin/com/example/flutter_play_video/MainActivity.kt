package com.example.flutter_play_video

import android.content.Context
import androidx.multidex.MultiDex
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun attachBaseContext(base: Context) {
        super.attachBaseContext(base)

        // https://developer.android.com/studio/build/multidex
        MultiDex.install(this)
    }
}
