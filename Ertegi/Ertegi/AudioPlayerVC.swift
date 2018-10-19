//
//  AudioPlayerVC.swift
//  
//
//  Created by Kuanysh on 18.08.17.
//
//

import UIKit
import AVFoundation
import FirebaseStorage

class AudioPlayerVC: UIViewController {

    var audioPlayer = AVAudioPlayer()
    var state: Bool = true
    var totalLengthOfAudio = ""
    var audioLength = 0.0
    var imageCover1: UIImage?
    var titleLabel1 = ""
    var urlOfErtegi = ""
    
    
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var durationTime: UILabel!
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderVolume: UISlider!
    @IBOutlet weak var imageCover: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        audioPlayer.stop()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCover.image = imageCover1
        titleLabel.text = titleLabel1
        
        prepare()
        settings()
      /*  var backButtonImage = UIImage(named: "back")
        backButtonImage = backButtonImage?.stretchableImage(withLeftCapWidth: 15, topCapHeight: 30)
        UIBarButtonItem.appearance().setBackButtonBackgroundImage(backButtonImage, for: .normal, barMetrics: .default)
*/
        
    }
    
    func settings() {
        slider.setMinimumTrackImage(UIImage(named: "Rectangle"), for: UIControlState.normal)
        slider.setMaximumTrackImage(UIImage(named: "rectangle1"), for: UIControlState.normal)
        
        sliderVolume.setMinimumTrackImage(UIImage(named: "kara"), for: UIControlState.normal)
        sliderVolume.setMaximumTrackImage(UIImage(named: "rectangle1"), for: UIControlState.normal)
        
    }

    func prepare () {
        do {
            
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: urlOfErtegi, ofType: "mp3")!))
          audioPlayer.prepareToPlay()
        } catch {
            print(error)
        }
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayback )
        } catch {
            print(error)
        }
        
        audioLength = audioPlayer.duration
        showTotalLength()
        slider.maximumValue = Float(audioPlayer.duration)
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: Selector("updateSlider"), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateSlider () {
        slider.value = Float(audioPlayer.currentTime)
        
         let time = calculateTimeFromNSTimeInterval(audioPlayer.currentTime)
        currentTime.text  = "\(time.minute):\(time.second)"
        
    }
    
   //MARK: Calculates total length of audio
    func showTotalLength() {
        let time = calculateTimeFromNSTimeInterval(TimeInterval(audioLength))
        totalLengthOfAudio = "\(time.minute):\(time.second)"
        durationTime.text = totalLengthOfAudio
    }
    
    func calculateTimeFromNSTimeInterval(_ duration:TimeInterval) ->(minute:String, second:String){
        // let hour_   = abs(Int(duration)/3600)
        let minute_ = abs(Int((duration/60).truncatingRemainder(dividingBy: 60)))
        let second_ = abs(Int(duration.truncatingRemainder(dividingBy: 60)))
        
        // var hour = hour_ > 9 ? "\(hour_)" : "0\(hour_)"
        let minute = minute_ > 9 ? "\(minute_)" : "0\(minute_)"
        let second = second_ > 9 ? "\(second_)" : "0\(second_)"
        return (minute,second)
    }

    
    @IBAction func play(_ sender: UIButton) {
    
        if state {
            audioPlayer.play()
            playPauseButton.setImage(#imageLiteral(resourceName: "pause.png"), for: UIControlState.normal)
            state = false
        } else {
            audioPlayer.pause()
            playPauseButton.setImage(#imageLiteral(resourceName: "play"), for: UIControlState.normal)
            state = true
        }
        
        
    }
    
    
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func sliderVolumeAction(_ sender: UISlider) {
        audioPlayer.volume = sliderVolume.value
    }
    

    @IBAction func stop(_ sender: UIButton) {
        
        if audioPlayer.isPlaying {
                playPauseButton.setImage(#imageLiteral(resourceName: "play"), for: UIControlState.normal)
                state = true
        }
        
        audioPlayer.stop()
        audioPlayer.currentTime = 0
    }
    
    @IBAction func changeAudioTime(_ sender: UISlider) {
        audioPlayer.stop()
        audioPlayer.currentTime = TimeInterval(slider.value)
        audioPlayer.prepareToPlay()
        
        audioPlayer.play()
        playPauseButton.setImage(#imageLiteral(resourceName: "pause.png"), for: UIControlState.normal)
        state = false
    }
    
    @IBAction func forward(_ sender: UIButton) {
        audioPlayer.currentTime = audioPlayer.currentTime + TimeInterval(15)
    }
    
    @IBAction func ownward(_ sender: UIButton) {
        audioPlayer.currentTime = audioPlayer.currentTime - TimeInterval(15)
        
    }
    
}
