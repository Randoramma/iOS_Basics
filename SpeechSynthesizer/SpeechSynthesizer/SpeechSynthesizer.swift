//
//  SpeechSynthesizer.swift
//  SpeechSynthesizer
//
//  Created by Luis Castillo on 5/31/16.
//  Copyright © 2016 LC. All rights reserved.
//

import Foundation
import AVFoundation

@objc protocol speechSynthesizerDelegate
{
    func playingStatusChanged(status:Bool)
}

@objc enum ISO0681Languages:Int {
    case ar_SA
    case cs_CZ
    case da_DK
    case de_DE
    case el_GR
    case en_US
    case es_ES
    case fi_FI
    case fr_FR
    case hi_IN
    case hu_HU
    case id_ID
    case it_IT
    case ja_JP
    case ko_KR
    case nl_NL
    case no_No
    case pl_PL
    case pt_BR
    case ro_RO
    case ru_RU
    case sk_SK
    case sv_SE
    case th_TH
    case tr_TR
    case zh_CN
    
    func toString() -> String {
        switch self {
        case .ar_SA:
            return "ar_SA"
        case .cs_CZ:
            return "cs_CZ"
        case .da_DK:
            return "da_DK"
        case .de_DE:
            return "de_DE"
        case .el_GR:
            return "el_GR"
        case .en_US:
            return "en_US"
        case .es_ES:
            return "es_ES"
        case .fi_FI:
            return "fi_FI"
        case .fr_FR:
            return "fr_FR"
        case .hi_IN:
            return "hi_IN"
        case .hu_HU:
            return "hu_HU"
        case .id_ID:
            return "id_ID"
        case .it_IT:
            return "it_IT"
        case .ja_JP:
            return "ja_JP"
        case .ko_KR:
            return "ko_KR"
        case .nl_NL:
            return "nl_NL"
        case .no_No:
            return "no_No"
        case .pl_PL:
            return "pl_PL"
        case .pt_BR:
            return "pt_BR"
        case .ro_RO:
            return "ro_RO"
        case .ru_RU:
            return "ru_RU"
        case .sk_SK:
            return "sk_SK"
        case .sv_SE:
            return "sv_SE"
        case .th_TH:
            return "th_TH"
        case .tr_TR:
            return "tr_TR"
        case .zh_CN:
            return "zh_CN"
        }
    }//eom
}//eo-

@objc class SpeechSynthesizer:NSObject, AVSpeechSynthesizerDelegate {
    static let sharedInstance = SpeechSynthesizer()
    
    private var speechSynth:AVSpeechSynthesizer = AVSpeechSynthesizer()
    
    
    var language:String = ISO0681Languages.en_US.toString()
    var rate:Float      = 0.5
    var delay:Double    = 0.2
    
    var speechDelegate:speechSynthesizerDelegate?
    
    
     override init()
     {
        
    }
    
    func speakText(textToSpeak:String)
    {
        //setting speach synthesizer
        speechSynth.delegate = self
        
        //settings setup
        let voice = AVSpeechSynthesisVoice(language: language)
        let utterance = AVSpeechUtterance(string: textToSpeak)
        
        utterance.rate = rate
        utterance.preUtteranceDelay = delay
        utterance.voice = voice
        
        //speaking text
        speechSynth.speakUtterance(utterance)
    }//eom
    
    //MARK: Delegates
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer, didPauseSpeechUtterance utterance: AVSpeechUtterance) {
        
    }//eom
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer, didStartSpeechUtterance utterance: AVSpeechUtterance) {
        
    }//eom
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer, didCancelSpeechUtterance utterance: AVSpeechUtterance) {
        
    }//eom
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer, didFinishSpeechUtterance utterance: AVSpeechUtterance) {
        
    }//eom
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer, didContinueSpeechUtterance utterance: AVSpeechUtterance) {
        
    }//eom
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        
    }//eom
}//eoc