//
//  ViewController.swift
//  recordAndPlayAudio
//
//  Created by Luis Castillo on 5/10/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit

class AVFoundationViewController: UIViewController {

    
    //properties
    @IBOutlet weak var playAudioButton: UIButton!
    @IBOutlet weak var pauseAudioButton: UIButton!
    @IBOutlet weak var stopAudioButton: UIButton!
    @IBOutlet weak var recordAudioButton: UIButton!
    @IBOutlet weak var pauseRecordAudioButton: UIButton!
    
    //models
    var player:AudioPlayer      = AudioPlayer()
    var recorder:AudioRecorder  = AudioRecorder()
    
    //MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   
    
    }//eom

    //MARK: - Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Playing Audio
    @IBAction func playAudio(sender:AnyObject)
    {
        player.playAudio()
    }//eoa
    
    @IBAction func pauseAudio(sender:AnyObject)
    {
        player.pausePlay()
    }//eoa
    
    
    @IBAction func stopAudio(sender:AnyObject)
    {
        player.stopPlay()
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
            recorder .recordAudio()
            
            sender .selected = true
        }
    }//eoa
    
    @IBAction func pauseRecording(sender:UIButton)
    {
        recorder .pauseRecording()
    }//eo-a
    
    
    @IBAction func playSoundEffect(sender: AnyObject)
    {
    
        let soundEffect:String = NSBundle.mainBundle().pathForResource("soundeffect", ofType: ".wav")!
        
        let soundEffectURL:NSURL = NSURL(fileURLWithPath: soundEffect)
        
        player.playAudioFromUrl(soundEffectURL)
    }//eo-a
    
    
}//eoc

