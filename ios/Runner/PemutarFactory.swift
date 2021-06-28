//
//  PemutarFactory.swift
//  Runner
//
//  Created by Ari Fajrianda Alfi on 23/06/21.
//

import Flutter

public class PemutarFactory: NSObject, FlutterPlatformViewFactory {
    var messenger: FlutterBinaryMessenger
    
    init(messenger: FlutterBinaryMessenger) {
       self.messenger = messenger
     }
    
    public func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return PemutarView(messenger, frame: frame, viewId: viewId, args: args)
    }
    
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
    
}
