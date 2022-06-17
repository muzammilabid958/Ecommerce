import UIKit
import Flutter
import Firebase
import GoogleMaps
import FirebaseCore


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure();
     GMSServices.provideAPIKey("AIzaSyBAgOEteCv3TMp2Y09u-R-uHypaDaq16MY")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
