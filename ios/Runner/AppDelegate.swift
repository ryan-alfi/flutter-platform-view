import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        PemutarViewPlugin.register(with: registrar(forPlugin: "pemutar")!)
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
