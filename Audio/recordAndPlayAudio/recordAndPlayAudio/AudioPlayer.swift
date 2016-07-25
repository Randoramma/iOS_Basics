//
//  AudioPlayer.swift
//  recordAndPlayAudio
//
//  Created by Luis Castillo on 5/10/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit
import AVFoundation

class AudioPlayer: NSObject, AVAudioPlayerDelegate
{
    private var _audioPlayer:AVAudioPlayer?
    
    private var _constants = AudioConstants .instance
    
    //MARK: - Play Audio
    func playAudio()
    {
        do
        {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            
             let url:NSURL = _constants .audioRecordPathNSURL
            
            if NSFileManager.defaultManager().fileExistsAtPath(url.path!)
            {
                _audioPlayer = try AVAudioPlayer(contentsOfURL: url)
            
                _audioPlayer?.numberOfLoops     = 0
                _audioPlayer?.meteringEnabled   = true
                _audioPlayer?.delegate          = self
                
                _audioPlayer?.play()
            }
        }
        catch
        {
            print(error)
        }
    }//eom
    
    func playAudioFromUrl(url:NSURL)
    {
        do
        {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            
            if NSFileManager.defaultManager().fileExistsAtPath(url.path!)
            {
                _audioPlayer = try AVAudioPlayer(contentsOfURL: url)
                
                _audioPlayer?.numberOfLoops     = 0
                _audioPlayer?.meteringEnabled   = true
                _audioPlayer?.delegate          = self
                
                _audioPlayer?.play()
            }
        }
        catch
        {
            print(error)
        }
    }//eom
    
    
    
    func pausePlay()
    {
        _audioPlayer?.pause()
    }//eom
    
    
    func stopPlay()
    {
        _audioPlayer?.stop()
    }//eom
    
    
    //MARK: - Delegates
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer, error: NSError?) {
        print(error?.localizedDescription)
    }//eom
    
    func audioPlayerBeginInterruption(player: AVAudioPlayer) {
        
    }//eom
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        
        _audioPlayer?.delegate = nil
        _audioPlayer = nil
        
        if flag
        {
            print("successfully played audio!")
        }
    }//eom
    
}//eoc
