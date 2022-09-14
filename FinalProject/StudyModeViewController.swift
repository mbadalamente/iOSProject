//
//  StudyModeViewController.swift
//  FinalProject
//
//  Created by Madison Badalamente on 4/27/22.
//

import UIKit
import AVFoundation
import MessageUI

class StudyModeViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    var audioPlayer: AVAudioPlayer = AVAudioPlayer ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, error in }
        let notifyUser = UNMutableNotificationContent()
        notifyUser.title = "Hey there!"
        notifyUser.body = "Still studying?"
        notifyUser.sound = .defaultCritical
        let timeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let uniqueID = UNNotificationRequest(identifier: UUID().uuidString, content: notifyUser, trigger: timeTrigger)
        UNUserNotificationCenter.current().add(uniqueID, withCompletionHandler: nil)
    }
    
    //MARK: email function
    @IBAction func emailHelp(_ sender: Any) {
       showMailComposer()
    }
    
    func showMailComposer(){
        print("trying to email")
        guard MFMailComposeViewController.canSendMail()
        else{
            print("cannot send mail")
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        present(composer, animated: true)
        
    }
    
    // MARK: gesture
    @IBAction func doubleTapGesture(_ sender: Any) {
        if audioPlayer.isPlaying{
            audioPlayer.pause()
        }
        else {
            audioPlayer.play()
        }
    }
    
    // MARK: audio
    @IBAction func playMusic(_ sender: Any) {
        do {
            let audioPath = Bundle.main.path(forResource: "studyMusic", ofType: "mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.play()
        } catch {
            print("Error occurred when playing audio")
        }
    }
    
    @IBAction func pauseMusic(_ sender: Any) {
        audioPlayer.pause()
    }
    

}

//MARK: email extension
extension ViewController: MFMailComposeViewControllerDelegate{
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
