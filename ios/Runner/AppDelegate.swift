import UIKit
import Flutter
import flutter_config
//import Secrets

import GoogleMaps

//var secrets = Secrets()

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    //print(FlutterConfigPlugin.env(for: "GOOGLE_API_KEY"))
    //GMSServices.provideAPIKey(FlutterConfigPlugin.env(for: "GOOGLE_API_KEY"))  // Add this line!
    GMSServices.provideAPIKey("GOOGLE_API_KEY")
    //GMSServices.provideAPIKey(secrets.GOOGLE_API_KEY)
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

