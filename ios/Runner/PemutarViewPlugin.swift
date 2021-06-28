//
//  PemutarViewPlugin.swift
//  Runner
//
//  Created by Ari Fajrianda Alfi on 28/06/21.
//

import Foundation

public class PemutarViewPlugin {
    class func register(with registrar: FlutterPluginRegistrar) {
        let viewFactory = PemutarFactory(messenger: registrar.messenger())
        registrar.register(viewFactory, withId: "PemutarPlatformView")
    }
}
