//
//  ViewController.swift
//  Ưngdung_music
//
//  Created by Admin on 9/14/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,AVAudioPlayerDelegate {
    

    @IBOutlet weak var Btn_Play: UIButton!
    @IBOutlet weak var Sld_Vol: UISlider!
    
    @IBOutlet weak var lbl_TimeLeft: UILabel!
    @IBOutlet weak var lbl_TimeTotal: UILabel!
    
    @IBOutlet weak var sld_Duration: UISlider!
    
    var audio = AVAudioPlayer()
    var bat_tat = true
    override func viewDidLoad() {
        audio = try! AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("music", ofType: ".mp3")!))
        audio.prepareToPlay()
        audio.delegate = self
        addThumbImgForSlider()
//
        let timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(updateTimerLeft), userInfo: nil, repeats: true)
//
       
    }
    
    func updateTimerLeft(){
        self.lbl_TimeLeft.text = String(format: "%2.2f", audio.currentTime/60)
        self.sld_Duration.value = Float(audio.currentTime/audio.duration)
        self.lbl_TimeTotal.text = String(format: "%2.2f", (audio.duration - audio.currentTime)/60)
        
        print(audio.currentTime)
        print("tong thoi gian: ",audio.duration)
        print("nut ",self.sld_Duration.value)
        
    }
    
    func addThumbImgForSlider(){
        Sld_Vol.setThumbImage(UIImage(named:"thumb.png"), forState: .Normal)
        Sld_Vol.setThumbImage(UIImage(named:"thumbHightLight.png"), forState: .Highlighted)
    }


   
    @IBAction func action_Play(sender: UIButton) {
        if(bat_tat){
            audio.play()
            bat_tat = false
            Btn_Play.setImage(UIImage(named:"pause.png"), forState: .Normal)
        }else{
            audio.pause()
            bat_tat = true
            Btn_Play.setImage(UIImage(named:"play.png"), forState: .Normal)
        }
        
    }
    
    @IBAction func sld_Volume(sender:UISlider) {
        print(sender.value)
        audio.volume = sender.value
    }

    @IBAction func action_duration(sender: AnyObject) {
        audio.currentTime = Double(self.sld_Duration.value * Float(audio.duration))
    }
    
    @IBAction func action_Repeat(sender: AnyObject) {
        if(sender.on!){
            audio.numberOfLoops = -1;
        }else{
            audio.numberOfLoops = 0;
        }
    }
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        Btn_Play.setImage(UIImage(named:"play.png"),forState: .Normal)
        
    }
}

