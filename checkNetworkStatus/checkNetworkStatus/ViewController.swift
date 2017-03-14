//
//  ViewController.swift
//  checkNetworkStatus
//
//  Created by lu on 3/14/17.
//  Copyright © 2017 lu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Properties
    var networkModel:NetworkListener = NetworkListener.shared
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setNetworkDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateWithCurrentStatus()
    }
    
    //MARK: - Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - Network
extension ViewController:NetworkListenerProtocol {
    func setNetworkDelegate(){
        networkModel.delegate = self
    }
    
    func updateWithCurrentStatus(){
        let status:NetworkStatus = networkModel.getCurrentStatus()
        
        DispatchQueue.main.async {
            self.updateUIWithNetworkStatus(status: status)
        }
    }
    
    func networkStatusChanged(status: NetworkStatus) {
        DispatchQueue.main.async {
            self.updateUIWithNetworkStatus(status: status)
        }
    }
    
    func updateUIWithNetworkStatus(status:NetworkStatus){
        switch status {
        case NotReachable:
            self.view.backgroundColor = UIColor.red
            break
        case ReachableViaWiFi:
            self.view.backgroundColor = UIColor.green
            break
        case ReachableViaWWAN:
            self.view.backgroundColor = UIColor.blue
            break
        default:
            break
        }
    }
}

