//
//  audioPlayMainViewController.swift
//  avFoundationExample
//
//  Created by Luis Castillo on 2/10/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit
import AVFoundation

class audioPlayMainViewController: UIViewController, AVAudioPlayerDelegate
{
    //UI 
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet var audioChoiceButtons: [UIButton]!
    @IBOutlet weak var timeRemainingLabel: UILabel!
    
    //
    var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    var playAudioRepeatedly: Bool   = false
    var audioSelected:Int = 0
    
    let stopAudio           = "Stop Audio"
    let playAudio:String    = "Play Audio"
    
    let audioChoices: [String]  = ["beatsMono", "chime_bell_ding", "guitarStereo", "music_marimba_chord", "pop_drip", "tap"]
    let audioFormats:[String]   = [ "caf", "wav", "caf", "wav", "wav", "aif" ]
    
    let playerTimeSelector:Selector = #selector(audioPlayMainViewController.updatePlayerTime)
    
    var timer:Timer?
    
    //MARK: - View Loading
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.startStopButton.setTitle(playAudio, for: UIControlState.normal)
        
        
        self.initPlayerSetup()
        
    }//eom
    
    override func viewDidAppear(_ animated: Bool)
    {
        self.startStopButton.updateConstraints()
        
    }//eom
    
    override func viewDidDisappear(_ animated: Bool)
    {
        
    }//eom

    
    
    // MARK: - Player
    func initPlayerSetup()
    {
        let selectedAudio       = audioChoices[audioSelected]
        let selectedAudioFormat = audioFormats[audioSelected]
        
        guard let audioPath = Bundle.main.path(forResource: selectedAudio, ofType: selectedAudioFormat) else { return }
        let audioURL = URL(fileURLWithPath: audioPath)
        
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
            audioPlayer.delegate = self
            
            audioPlayer.prepareToPlay()
        }
        catch
        {
        
        }
    }//eom
    
    @IBAction func startStopPlayer(_ sender: UIButton)
    {
        if audioPlayer.isPlaying
        {
            print("stopping audio")
            audioPlayer.stop()
            self.timeRemainingLabel.text = ""
            self.startStopButton.setTitle(playAudio, for: UIControlState.normal)
        }
        else
        {
            print("starting audio")
            self.startStopButton.setTitle(stopAudio, for: UIControlState.normal)
            self.playSelectedAudio()
        }
    }//eo-a
    
    func playSelectedAudio()
    {
        let selectedAudio       = audioChoices[audioSelected]
        let selectedAudioFormat = audioFormats[audioSelected]
        
        guard let audioPath = Bundle.main.path(forResource: selectedAudio, ofType: selectedAudioFormat) else { return }
        let audioURL = URL(fileURLWithPath: audioPath)
        
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
            audioPlayer.delegate = self
            
            if audioPlayer.prepareToPlay()
            {
                let timeLeft:Int = (Int)(audioPlayer.duration - audioPlayer.currentTime)
                self.timeRemainingLabel.text = "\(timeLeft)"
                
                audioPlayer.play()
                
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: playerTimeSelector, userInfo: nil, repeats: true)
            }
        }
        catch
        {
            print("un-able to play selected audio")
            
        }
    }//eom
    
    func updatePlayerTime()
    {
        let timeLeft:Int = (Int)(audioPlayer.duration - audioPlayer.currentTime)
        
        self.timeRemainingLabel.text = "\(timeLeft)"
        
        if timeLeft < 1
        {
            timer?.invalidate()
        }
    
    }//eom
    
    
    // MARK: Player Delegates
    func audioPlayerDidFinishPlaying(_ successfully: Bool)
    {
        if(playAudioRepeatedly)
        {
            audioPlayer.play()
        }
        else
        {
            startStopButton.titleLabel?.text = playAudio
        }
    }//eom
    
    //MARK: Audio Choice Selected
    @IBAction func audioChoiceSelected(_ sender: UIButton)
    {
        let index:Int = sender.tag
        if index >= 0 && index < audioChoices.count
        {
            audioSelected = index
        }
    }//eo-a
    
    //MARK: - Memory
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }//eom
    
}//eoc
