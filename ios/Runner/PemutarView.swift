//
//  PemutarView.swift
//  Runner
//
//  Created by Ari Fajrianda Alfi on 23/06/21.
//

import Foundation
import Flutter
import BMPlayer

public class PemutarView: NSObject, FlutterPlatformView {
    let frame: CGRect
    let viewId: Int64
    let messenger: FlutterBinaryMessenger
    let channel: FlutterMethodChannel
    
    private var _view: UIView
    private var player: BMPlayer!
    
    private var videoUrl: String = ""
    
    init(_ messenger: FlutterBinaryMessenger, frame: CGRect, viewId: Int64, args: Any?) {
        _view = UIView()
        
        self.frame = frame
        self.viewId = viewId
        self.messenger = messenger
        
        if (args is NSDictionary) {
            let dict = args as! NSDictionary
            self.videoUrl = dict.value(forKey: "video_url") as! String
        }
        
        channel = FlutterMethodChannel(name: "flutter.native/pemutar",
                                       binaryMessenger: messenger)
        
        super.init()
        
        channel.setMethodCallHandler({ (call: FlutterMethodCall, result: FlutterResult) -> Void in
            switch call.method {
            case "receiveFromFlutter":
                guard let args = call.arguments as? [String: Any],
                      let text = args["text"] as? String else {
                    result(FlutterError(code: "-1", message: "Error", details: nil))
                    return
                }
                
                print(text)
                result("receiveFromFlutter success")
            case "play":
                self.doPlay()
                result("Play success")
            case "pause":
                self.doPause()
                result("Pause success")
            case "mute":
                self.doMute()
                result("Mute success")
            default:
                result(FlutterMethodNotImplemented)
            }
        })
        
        createNativeView(view: _view)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        player.prepareToDealloc()
    }
    
    public func view() -> UIView {
        return _view
    }
    
    func createNativeView(view _view: UIView){
        _view.backgroundColor = UIColor.lightGray
        
        preparePlayer()
        setupPlayerResource(with: videoUrl)
    }
    
    // MARK:- Player
    
    private func preparePlayer() {
        var controller: BMPlayerControlView? = nil
        BMPlayerConf.topBarShowInCase = .none
        
        controller = CustomPlayerView()
        
        player = BMPlayer(customControlView: controller)
        _view.addSubview(player)
        
        player.snp.makeConstraints { (make) in
            make.top.equalTo(_view.snp.top)
            make.left.equalTo(_view.snp.left)
            make.right.equalTo(_view.snp.right)
            make.height.equalTo(_view.snp.width).multipliedBy(9.0/16.0).priority(500)
        }
        
        player.delegate = self
        player.backBlock = { (isFullScreen) in
            if isFullScreen {
                return
            }
        }
        
        self._view.layoutIfNeeded()
    }
    
    private func setupPlayerResource(with url: String) {
        let url = URL(string: url)!
        
        let playerResource = BMPlayerResource(name: "",
                                              definitions: [BMPlayerResourceDefinition(url: url, definition: "480p")],
                                              cover: nil,
                                              subtitles: nil)
        
        player.setVideo(resource: playerResource)
    }
    
    private func doPlay() {
        player.play()
    }
    
    private func doPause() {
        player.pause()
    }
    
    private func doMute() {
        player.reduceVolume(step: 50.0)
    }
    
    //MARK:- Send to Flutter
    
    public func sendFromNative(_ text: String) {
        channel.invokeMethod("sendFromNative", arguments: text)
    }
    
}

extension PemutarView: BMPlayerDelegate {
    public func bmPlayer(player: BMPlayer, playerStateDidChange state: BMPlayerState) {
        
    }
    
    public func bmPlayer(player: BMPlayer, loadedTimeDidChange loadedDuration: TimeInterval, totalDuration: TimeInterval) {
        
    }
    
    public func bmPlayer(player: BMPlayer, playTimeDidChange currentTime: TimeInterval, totalTime: TimeInterval) {
        
    }
    
    public func bmPlayer(player: BMPlayer, playerIsPlaying playing: Bool) {
        
    }
    
    public func bmPlayer(player: BMPlayer, playerOrientChanged isFullscreen: Bool) {
        player.snp.remakeConstraints { (make) in
            make.top.equalTo(_view.snp.top)
            make.left.equalTo(_view.snp.left)
            make.right.equalTo(_view.snp.right)
            if isFullscreen {
                make.bottom.equalTo(_view.snp.bottom)
            } else {
                make.height.equalTo(_view.snp.width).multipliedBy(9.0/16.0).priority(500)
            }
        }
    }
    
}
