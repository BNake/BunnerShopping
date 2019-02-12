//
//  NotificationHandler.swift
//  VIPTemplate
//
//  Created by The Son on 11/21/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit
import AVFoundation

class NotificationHandler {
    
    var player: AVAudioPlayer?
    
    static let shared: NotificationHandler = {
        let instance = NotificationHandler()
        return instance
    }()
    
    func playSound() {
        if let path = Bundle.main.path(forResource: "push-received.caf", ofType: nil) {
            let url = URL(fileURLWithPath: path)
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
            } catch {
                // couldn't load file
            }
        }
    }
    
    open func handle(pushContent: [String: Any], fromBackground: Bool) {
        
    }
    
    func showPushForMessage(conversationID: String, title: String, message: String) {
        
    }

}
