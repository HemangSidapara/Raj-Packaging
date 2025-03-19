import 'package:package_info_plus/package_info_plus.dart';

class GetPackageInfoService {
  static GetPackageInfoService instance = GetPackageInfoService();

  Future<_PackageInfoData> getInfo() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    return _PackageInfoData(
      appName: info.appName,
      packageName: info.packageName,
      version: info.version,
      buildNumber: info.buildNumber,
      installerStore: info.installerStore,
    );
  }
}

class _PackageInfoData {
  /// Constructs an instance with the given values for testing. [PackageInfoData]
  /// instances constructed this way won't actually reflect any real information
  /// from the platform, just whatever was passed in at construction time.
  _PackageInfoData({
    required this.appName,
    required this.packageName,
    required this.version,
    required this.buildNumber,
    this.installerStore,
  });

  /// The app name. `CFBundleDisplayName` on iOS, `application/label` on Android.
  final String appName;

  /// The package name. `bundleIdentifier` on iOS, `getPackageName` on Android.
  final String packageName;

  /// The package version. `CFBundleShortVersionString` on iOS, `versionName` on Android.
  final String version;

  /// The build number. `CFBundleVersion` on iOS, `versionCode` on Android.
  final String buildNumber;

  /// The installer store. Indicates through which store this application was installed.
  final String? installerStore;
}
