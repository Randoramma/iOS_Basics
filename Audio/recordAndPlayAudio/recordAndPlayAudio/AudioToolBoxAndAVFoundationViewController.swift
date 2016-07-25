//
//  AudioToolBoxAndAVFoundationViewController.swift
//  recordAndPlayAudio
//
//  Created by Luis Castillo on 6/3/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit

class AudioToolBoxAndAVFoundationViewController: UIViewController {

    
    @IBOutlet weak var recordingButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    
    //models
    let recorder = VoiceRecording()
    
    //MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        recordingButton.setTitle("Record audio", forState: UIControlState.Normal)
        
        
        recordingButton.setTitle("Recording", forState: UIControlState.Selected)
        
    }//eom
    
    //MARK: - Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }//eom
    
    //MARK: - Playing Audio
    @IBAction func playAudio(sender:UIButton)
    {
        recorder .playSound()
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
    
}//eoc
