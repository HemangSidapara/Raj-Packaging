package com.stock.rajpackaging

import android.content.Intent
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.os.Build
import android.util.Log
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.io.File

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
            if ((call.method == "getPackageInfo")) {
                try {
                    val packageInfo: PackageInfo =
                        this.packageManager
                            .getPackageInfo(this.packageName, 0)

                    val installerPackage: String?
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                        installerPackage = this.packageManager
                            .getInstallSourceInfo(this.packageName)
                            .initiatingPackageName
                    } else {
                        installerPackage = this.packageManager
                            .getInstallerPackageName(this.packageName)
                    }
                    val infoMap: HashMap<String, String?> =
                        HashMap()
                    infoMap["appName"] = packageInfo.applicationInfo?.loadLabel(this.packageManager)
                        .toString()
                    infoMap["packageName"] = packageInfo.packageName
                    infoMap["version"] = packageInfo.versionName
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                        infoMap["buildNumber"] = packageInfo.longVersionCode.toString()
                    } else {
                        infoMap["buildNumber"] = packageInfo.versionCode.toString()
                    }
                    infoMap["installerStore"] = installerPackage
                    result.success(infoMap)
                } catch (e: PackageManager.NameNotFoundException) {
                    result.success(null)
                    throw RuntimeException(e)
                }
            } else if ((call.method == "installApk")) {
                installApk(result)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun installApk(result: MethodChannel.Result) {
        val fileName = "app-release.apk"

        val apkFile = File(this.getExternalFilesDir(null), fileName)
        Log.d("APK Installer", "installApk: $apkFile")
        if (apkFile.exists()) {
            val uri = FileProvider.getUriForFile(
                this,
                this.packageName + ".provider", apkFile
            )
            val intent = Intent(Intent.ACTION_INSTALL_PACKAGE)
            intent.setDataAndType(uri, "application/vnd.android.package-archive")
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION or Intent.FLAG_ACTIVITY_NEW_TASK)
            startActivity(intent)
            result.success(true)
        } else {
            Log.e("APK Installer", "APK file not found: " + apkFile.absolutePath)
        }
    }

    companion object {
        private const val CHANNEL = "AndroidMethodChannel"
    }
}