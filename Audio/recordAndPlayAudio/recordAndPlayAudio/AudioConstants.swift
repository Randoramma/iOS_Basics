//
//  AudioConstants.swift
//  recordAndPlayAudio
//
//  Created by Luis Castillo on 5/10/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit

class AudioConstants: NSObject {

    static let instance = AudioConstants()
    
    var audioRecordPath:String
    {
        let directoryPaths:NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        
        if directoryPaths .count > 0
        {
            if let docsDirectory = directoryPaths .objectAtIndex(0) as? NSString
            {
                let filePath:String = docsDirectory.stringByAppendingPathComponent("audioRecordedFTW.caf")
                
                return filePath
            }//eo-docs
        }//eo-valid directories
        
        return String()
    }//eo-var
    
    var audioRecordPathNSURL:NSURL
    {
        let filePath:String =  self.audioRecordPath
        if filePath .characters .count > 0
        {
            let url:NSURL = NSURL(fileURLWithPath: filePath)
            
            return url
        }
        
        return NSURL()
    }//eo-var
}
