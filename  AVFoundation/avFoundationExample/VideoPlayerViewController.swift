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
    
    var videoURL: URL?        = nil
    var videoPlayer: AVPlayer?  = AVPlayer()
    
    let playerEndSelector:Selector      = #selector(VideoPlayerViewController.playerDidReachEndNotificationHandler(_:))
    let playerFailedSelector:Selector   = #selector(VideoPlayerViewController.playerFailedToPlayNotificationHandler(_:))
    let playerStalledSelector:Selector  = #selector(VideoPlayerViewController.playerStalledNotificationHandler(_:))
    let playerJumpedSelector:Selector   = #selector(VideoPlayerViewController.playerJumpedNotificationHandler(_:))
    
    
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
            videoPlayer = AVPlayer(url: url)
            self.player = videoPlayer
            
            //observers
            NotificationCenter.default.addObserver(self, selector: playerEndSelector, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
            
            NotificationCenter.default.addObserver(self, selector: playerFailedSelector, name: NSNotification.Name.AVPlayerItemFailedToPlayToEndTime, object: nil)
            NotificationCenter.default.addObserver(self, selector: playerStalledSelector, name: NSNotification.Name.AVPlayerItemPlaybackStalled, object: nil)
            NotificationCenter.default.addObserver(self, selector: playerJumpedSelector, name: NSNotification.Name.AVPlayerItemTimeJumped, object: nil)
           
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
        self.dismiss(animated: true, completion: nil)
    }//eom
    
    func failedToLoadVideo()
    {
        print("\nfailedToLoadVideo")
        self.dismissPlayer()
    }//eom
    
    //MARK: - Notifications
    
    func playerStalledNotificationHandler(_ notification: Notification)
    {
        print("\nplayerStalledNotification")
    }//eom
    
    func playerJumpedNotificationHandler(_ notification: Notification)
    {
        print("(Playing Video) playerJumpedNotification...")
    }//eom
    
    func playerFailedToPlayNotificationHandler(_ notification: Notification)
    {
        print("\nplayerFailedToPlayNotification")
    }//eom
    
    func playerDidReachEndNotificationHandler(_ notification: Notification)
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
