package com.homeonix

import io.flutter.embedding.android.FlutterFragmentActivity
import android.os.Bundle

class MainActivity: FlutterFragmentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // এখানে কোনো অতিরিক্ত কোড প্রয়োজন নেই যদি শুধু Flutter ব্যবহার করেন
        // Firebase Auth, Google Sign-In, Camera, File Picker এগুলো FlutterFragmentActivity তেই কাজ করবে
    }
}