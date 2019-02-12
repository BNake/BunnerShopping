//
//  NetworkConnectionManager.swift
//  VIPTemplate
//
//  Created by The Son on 12/6/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit
import Alamofire
import CoreTelephony

enum InternetConnectionType: Int {
    case wifi = 0
    case cellular2G = 1
    case cellular3G = 2
    case cellular4G = 3
}

class NetworkConnectionManager {
    static let shared = NetworkConnectionManager()
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
    
    func startNetworkReachabilityObserver() {
        reachabilityManager?.listener = { status in
            switch status {
            case .notReachable:
                print("The network is not reachable")
            case .unknown :
                print("It is unknown whether the network is reachable")
            case .reachable(.ethernetOrWiFi):
                print("The network is reachable over the WiFi connection")
            case .reachable(.wwan):
                print("The network is reachable over the WWAN connection")
            }
        }
        // start listening
        reachabilityManager?.startListening()
    }
    
    func connectionType() -> InternetConnectionType {
        if self.reachabilityManager?.isReachableOnWWAN == true {
            let networkInfo = CTTelephonyNetworkInfo()
            switch networkInfo.currentRadioAccessTechnology {
            case CTRadioAccessTechnologyGPRS?:
                return .cellular2G
            case CTRadioAccessTechnologyEdge?:
                return .cellular2G
            case CTRadioAccessTechnologyWCDMA?:
                return .cellular2G
            case CTRadioAccessTechnologyLTE?:
                return .cellular4G
            default:
                return .cellular3G
            }
        } else {
            return .wifi
        }
    }
}
