//
//  LoadingIndicatorManager.swift
//  VIPTemplate
//
//  Created by Savvycom on 11/30/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import Foundation

class LoadingActivityData {
    
    let message: String?
    let minimumVisibleTime: TimeInterval
    let displayTimeThreshold: TimeInterval
    
    init(message: String?, minimumVisibleTime: TimeInterval, displayTimeThreshold: TimeInterval) {
        self.message = message
        self.minimumVisibleTime = minimumVisibleTime
        self.displayTimeThreshold = displayTimeThreshold
    }
    
}

class PresenterViewController: UIViewController { }

class LoadingIndicatorManager {
    
    static let sharedInstance = LoadingIndicatorManager()
    
    private let presenter = PresenterViewController()
    private var showActivityTimer: Timer?
    private var hideActivityTimer: Timer?
    private var userWantsToStopActivity = false
    
    private init() { }
    
    func show(minimumVisibleTime: TimeInterval, displayTimeThreshold: TimeInterval, message: String? = nil) {
        let data = LoadingActivityData(message: message, minimumVisibleTime: minimumVisibleTime, displayTimeThreshold: displayTimeThreshold)
        guard showActivityTimer == nil else {
            return
        }
        userWantsToStopActivity = false
        showActivityTimer = scheduleTimer(data.displayTimeThreshold, selector: #selector(LoadingIndicatorManager.showActivityTimerFired(_:)), data: data)
    }
    
    func hide() {
        userWantsToStopActivity = true
        guard hideActivityTimer == nil else {
            return
        }
        hideActivity()
    }
    
    // MARK: - Timer events
    @objc func hideActivityTimerFired(_ timer: Timer) {
        hideActivityTimer?.invalidate()
        hideActivityTimer = nil
        if userWantsToStopActivity {
            hideActivity()
        }
    }
    
    @objc func showActivityTimerFired(_ timer: Timer) {
        guard let activityData = timer.userInfo as? LoadingActivityData else {
            return
        }
        showActivity(activityData)
    }
    
    // MARK: - Helpers
    private func showActivity(_ data: LoadingActivityData) {
//        presenter.startAnimating(LoadingIndicator.size, message: data.message, type: LoadingIndicator.type, color: LoadingIndicator.color)
        hideActivityTimer = scheduleTimer(data.minimumVisibleTime, selector: #selector(LoadingIndicatorManager.hideActivityTimerFired(_:)), data: nil)
    }
    
    private func hideActivity() {
//        presenter.stopAnimating()
        showActivityTimer?.invalidate()
        showActivityTimer = nil
    }
    
    private func scheduleTimer(_ timeInterval: TimeInterval, selector: Selector, data: LoadingActivityData?) -> Timer {
        return Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: selector, userInfo: data, repeats: false)
    }
    
}
