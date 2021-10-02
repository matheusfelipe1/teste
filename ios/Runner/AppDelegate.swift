import UIKit
import Flutter
import Firebase
import GoogleMaps

@UIApplicationMain
	@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyBoRIqJtzmId_EH8FcxNOIPlx4iJq3iW_I")
    
    let firebaseAuth = Auth.auth()
    let channelName = "mobilus.joinder/logout"
    let rootViewController : FlutterViewController = window?.rootViewController as! FlutterViewController
    
    let methodChannel = FlutterMethodChannel(name: channelName, binaryMessenger: rootViewController.binaryMessenger)
    
    methodChannel.setMethodCallHandler {(call: FlutterMethodCall, result: FlutterResult) -> Void in
        if (call.method == "logout") {
          do {
            try firebaseAuth.signOut()
          } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
          }  
        }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
