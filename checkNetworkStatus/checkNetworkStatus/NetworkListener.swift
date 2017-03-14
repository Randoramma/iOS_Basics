//
//  NetworkListener.swift
//  checkNetworkStatus
//
//  Created by lu on 3/14/17.
//  Copyright © 2017 lu. All rights reserved.
//

import Foundation

protocol NetworkListenerProtocol {
    func networkStatusChanged(status:NetworkStatus)
}

@objc class NetworkListener:NSObject {
    static let shared:NetworkListener = NetworkListener()
    
    var delegate:NetworkListenerProtocol?
    
    //MARK: - Properties
    private let internetReachability:Reachability
    
    //MARK: - Lifecycle
    private override init() {
        internetReachability = Reachability.forInternetConnection()
        
        super.init()
        
        internetReachability.startNotifier()
        setObserver()
    }
    
    deinit {
        internetReachability.stopNotifier()
    }
    
    //MARK: - Current Status
    func getCurrentStatus()->NetworkStatus {
        let status:NetworkStatus = internetReachability.currentReachabilityStatus()
        return status
    }
    
    
    //MARK: Status Changed
    private func setObserver(){
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(NetworkListener.reachabilityChanged),
                                               name: NSNotification.Name.reachabilityChanged,
                                               object: nil)
    }
    
    internal func reachabilityChanged(notification:NSNotification) {
        if let currReach:Reachability = notification.object as? Reachability {
            let status:NetworkStatus = currReach.currentReachabilityStatus()
            delegate?.networkStatusChanged(status: status)
        }
    }
    
}
