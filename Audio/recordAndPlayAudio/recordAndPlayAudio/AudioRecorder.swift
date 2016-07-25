//
//  AudioRecorder.swift
//  recordAndPlayAudio
//
//  Created by Luis Castillo on 5/10/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit
import AVFoundation

@objc class AudioRecorder: NSObject, AVAudioRecorderDelegate {

    //properties
    private var _recorder:AVAudioRecorder?
    private var _constants = AudioConstants .instance
    
    
    //getters
    var isRecording:Bool
    {
        if _recorder != nil
        {
            return _recorder!.recording
        }
        
        return false
    }//eo-var
    
    var audioFileNSURL:NSURL
    {
        if _recorder != nil
        {
            return _recorder!.url
        }
        
        return NSURL()
    }//eo-var
    
//    var audioRecordPath:String
//    {
//        let directoryPaths:NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
//        
//        if directoryPaths .count > 0
//        {
//            if let docsDirectory = directoryPaths .objectAtIndex(0) as? NSString
//            {
//                let filePath:String = docsDirectory.stringByAppendingPathComponent("audioRecordedFTW.caf")
//                
//                return filePath
//            }//eo-docs
//        }//eo-valid directories
//        
//        return String()
//    }//eo-var
    
//    private var _audioRecordPath:NSURL
//    {
//        let filePath:String =  self.audioRecordPath
//        if filePath .characters .count > 0
//        {
//            let url:NSURL = NSURL(fileURLWithPath: filePath)
//            
//            return url
//        }
//        
//        return NSURL()
//    }//eo-var
    
    //MARK: - Record Audio
    func recordAudio()
    {
        let settings:[String:AnyObject] =
            [
                AVFormatIDKey : Int(kAudioFormatLinearPCM),
                AVSampleRateKey : 44100.0,
                AVNumberOfChannelsKey : 2,
                AVLinearPCMBitDepthKey : 16,
                AVLinearPCMIsFloatKey : false,
                AVLinearPCMIsBigEndianKey : false
            ]
        
        do
        {
            try AVAudioSession.sharedInstance() .setCategory(AVAudioSessionCategoryRecord)
            let url:NSURL = _constants .audioRecordPathNSURL
            self._recorder = try AVAudioRecorder(URL: url, settings: settings)
            
            _recorder?.delegate = self
            _recorder?.meteringEnabled = true
            
            if _recorder?.prepareToRecord() == true {
                _recorder?.record()
            }
        }
        catch
        {
            print(error)
        }
    }//eom
    
    func pauseRecording()
    {
        _recorder?.pause()
    }//eom
    
    
    func stopRecording()
    {
        _recorder?.stop()
    }//eom
    
    //MARK: - Delegates
    func audioRecorderBeginInterruption(recorder: AVAudioRecorder) {
        
    }//eom
    
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
       
        _recorder?.delegate = nil
        _recorder = nil
        
        if flag
        {
            print("successfully recorded!")
        }
    }//eom
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder, error: NSError?) {
        print(error?.localizedDescription)
    }//eom
    
}//eoc
