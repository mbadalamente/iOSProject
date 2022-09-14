//
//  NotesViewController.swift
//  FinalProject
//
//  Created by Madison Badalamente on 5/8/22.
//

import UIKit
import AVFoundation

class NotesViewController: UIViewController {
    var audioPlayer: AVAudioPlayer = AVAudioPlayer ()
    let synthesizer = AVSpeechSynthesizer()
    let textToSpeak = "Hello"
    
    @IBOutlet weak var noteTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: Speach synthesizing 
    @IBAction func speakNote(_ sender: Any) {
        let utterance = AVSpeechUtterance(string: noteTextView.text!)
        synthesizer.speak(utterance)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
