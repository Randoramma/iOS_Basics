//
//  VoiceRecording.swift
//  recordAndPlayAudio
//
//  Created by Luis Castillo on 6/3/16.
//  Copyright © 2016 LC. All rights reserved.
//

import Foundation
import AVFoundation
import AudioToolbox

class VoiceRecording: NSObject, AVAudioRecorderDelegate
{
    
    var recordSetting:[String:AnyObject] = [:]
    var editedObject:NSMutableDictionary = NSMutableDictionary()
    var recorder:AVAudioRecorder?
    
    var soundID:SystemSoundID = SystemSoundID()
    
    var recorderFilePath:String {
        return "\(NSTemporaryDirectory())MySound.caf"
    }
    
    
    override init() {
        super.init()
        
    }//eom
    
    
    
    //MARK: Recording
    func startRecording()
    {
        do
        {
            let audioSession = AVAudioSession .sharedInstance()
            try audioSession .setCategory(AVAudioSessionCategoryPlayAndRecord)
            try audioSession .setActive(true)
            
            let url:NSURL = NSURL(string:recorderFilePath)!
            if let urlPath:String = url.path
            {
                //removing file just incase
                do
                {
                    let audioData:NSData? = try NSData(contentsOfFile: urlPath, options: NSDataReadingOptions(rawValue: 0) )
                    if audioData != nil
                    {
                        let fm = NSFileManager .defaultManager()
                        try fm .removeItemAtPath(urlPath)
                    }
                }
                catch
                {
                    print("no audio existing file deleted")
                    //print(error)
                    print("\n\n")
                }
            }
            
            self.recordSetting = [
                // We can use kAudioFormatAppleIMA4 (4:1 compression) or kAudioFormatLinearPCM for nocompression
                AVFormatIDKey: NSNumber(unsignedInt: kAudioFormatAppleIMA4),
                //                AVFormatIDKey: NSNumber(unsignedInt: kAudioFormatLinearPCM),
                
                // We can use 44100, 32000, 24000, 16000 or 12000 depending on sound quality
                AVSampleRateKey: NSNumber(double: 16000.0),
                
                // We can use 2(if using additional h/w) or 1 (iPhone only has one microphone)
                AVNumberOfChannelsKey:NSNumber(int:1),
                
                // These settings are used if we are using kAudioFormatLinearPCM format
                //                AVLinearPCMBitDepthKey:NSNumber(int:16),
                //                AVLinearPCMIsBigEndianKey:NSNumber(bool:false),
                //                AVLinearPCMIsFloatKey:NSNumber(bool:false)
            ]
            
            //setting recorder settings
            self.recorder = try AVAudioRecorder(URL: url, settings: recordSetting)
            
    
            recorder?.delegate = self
            recorder?.meteringEnabled = true
            
            if recorder?.prepareToRecord() == true
            {
                //start recording
                recorder?.record()
            }
            else
            {
                print("not ready to record")
            }
        }
        catch
        {
            print(error)
        }
    }//eom
    
    
    func stopRecording()
    {
        recorder?.stop()
    }//eom
    
    
    //MARK: Playing
    func playSound()
    {
        AudioServicesDisposeSystemSoundID(soundID)
        
        //Get a URL for the sound file
        let filePath:NSURL = NSURL(fileURLWithPath: recorderFilePath, isDirectory: false)
        
        //Use audio sevices to create the sound
        AudioServicesCreateSystemSoundID(filePath, &soundID)
        
        //Use audio services to play the sound
        AudioServicesPlaySystemSound(soundID)
    }//eom
   
    //MARK: Delegates
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag
        {
            print("finish audio recording: successfully")
        }
        else
        {
            print("finish audio recording: unsuccessfully")
        }
        
    }//eom
}//eoc