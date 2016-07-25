//
//  VideoPlayerViewController.swift
//  avFoundationExample
//
//  Created by Luis Castillo on 2/10/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideoPlayerViewController: AVPlayerViewController
{
    
    var videoURL: NSURL?        = nil
    var videoPlayer: AVPlayer?  = AVPlayer()
    
    let playerEndSelector:Selector      = Selector.init("playerDidReachEndNotificationHandler:")
    let playerFailedSelector:Selector   = Selector.init("playerFailedToPlayNotificationHandler:")
    let playerStalledSelector:Selector  = Selector.init("playerStalledNotificationHandler:")
    let playerJumpedSelector:Selector   = Selector.init("playerJumpedNotificationHandler:")
    
    
    //MARK: View Loading
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.loadVideo()
    }//eom
    
    //MARK: Load Video
    func loadVideo()
    {
        //loading url
        if let url = videoURL
        {
            videoPlayer = AVPlayer(URL: url)
            self.player = videoPlayer
            
            //observers
            NSNotificationCenter.defaultCenter().addObserver(self, selector: playerEndSelector, name: AVPlayerItemDidPlayToEndTimeNotification, object: nil)
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: playerFailedSelector, name: AVPlayerItemFailedToPlayToEndTimeNotification, object: nil)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: playerStalledSelector, name: AVPlayerItemPlaybackStalledNotification, object: nil)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: playerJumpedSelector, name: AVPlayerItemTimeJumpedNotification, object: nil)
           
            //start video
            self.player?.play()
        }
        else
        {
            self.failedToLoadVideo()
        }
    }//eom
    
    func dismissPlayer()
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }//eom
    
    func failedToLoadVideo()
    {
        print("\nfailedToLoadVideo")
        self.dismissPlayer()
    }//eom
    
    //MARK: - Notifications
    
    func playerStalledNotificationHandler(notification: NSNotification)
    {
        print("\nplayerStalledNotification")
    }//eom
    
    func playerJumpedNotificationHandler(notification: NSNotification)
    {
        print("(Playing Video) playerJumpedNotification...")
    }//eom
    
    func playerFailedToPlayNotificationHandler(notification: NSNotification)
    {
        print("\nplayerFailedToPlayNotification")
    }//eom
    
    func playerDidReachEndNotificationHandler(notification: NSNotification)
    {
        print("\nplayerDidReachEndNotification")
    }//eom
    
    
    //MARK: Memory
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }//eom

}
