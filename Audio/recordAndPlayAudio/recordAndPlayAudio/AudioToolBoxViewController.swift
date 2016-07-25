//
//  AudioToolBoxViewController.swift
//  recordAndPlayAudio
//
//  Created by Luis Castillo on 6/1/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit

class AudioToolBoxViewController: UIViewController {

    //outlets
    @IBOutlet weak var recordingButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    
    //models
    let recorder:PCMrecorder = PCMrecorder()
    let player = AudioPlayer()
    
    //properties
    var recordedFilePath:String = ""
    
    
    //MARK: - View
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        recordingButton.setTitle("Record audio", forState: UIControlState.Normal)
        
        
        recordingButton.setTitle("Recording", forState: UIControlState.Selected)
        
        recordedFilePath = self.createTempFileName()
        
        //setup
        recorder .setupRecording(recordedFilePath)
        
    }//eom
    
    //MARK: - Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }//eom
    
    //MARK: - Playing Audio
    @IBAction func playAudio(sender:UIButton)
    {
        if let recordFileNSURL:NSURL = NSURL(fileURLWithPath: recordedFilePath)
        {
            
            player.playAudioFromUrl(recordFileNSURL)
        }
        else
        {
            print("un-able to play")
        }
    }//eoa
    
    //MARK: - Recording Audio
    @IBAction func startOrStopRecordingAudio(sender:UIButton)
    {
        //recording, need to stop
        if sender .selected
        {
            recorder .stopRecording()
            
            sender .selected = false
        }
            // start recording
        else
        {
            recorder .startRecording()
            
            sender .selected = true
        }
    }//eoa
    
    //MARK:
    private func createTempFileName()->String
    {
        return "\(NSTemporaryDirectory())recordedSample.wav"
    }//eom

}//eoc
