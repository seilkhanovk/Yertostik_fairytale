//
//  ThirdVC.swift
//  Ertegi
//
//  Created by Kuanysh on 18.07.17.
//  Copyright © 2017 KuanyshTeam. All rights reserved.
//

import UIKit
import MessageUI

struct UserPreferences {
    static var isAnimationOn = true
}

class ThirdVC: UITableViewController, MFMailComposeViewControllerDelegate {


    @IBOutlet weak var switcher: UISwitch!
    
    var myIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellid")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        switch myIndex {
        case 0: openMessage()
        case 1: appStoreRate()
        default: break
    }
}
   
    //MARK: Goes to AppStore
    func appStoreRate() {
        guard let url = URL(string : "https://itunes.apple.com/us/app/1265774670?ls=1&mt=8&action=write-review") else { return }
        guard #available(iOS 10, *) else {
            UIApplication.shared.openURL(url)
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    //MARK: UISwitch
    
    @IBAction func mySwitch(_ sender: UISwitch) {
        if switcher.isOn{
            UserPreferences.isAnimationOn = true
        } else {
            UserPreferences.isAnimationOn = false
        }
    }
    
    // MARK: MessageUI
    
    func openMessage () {
        let actionSheet = UIAlertController(title: nil, message: "Хабарласу", preferredStyle: .actionSheet)
   
        let mailAction = UIAlertAction(title: "seil.kuka@gmail.com", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            let mailCompose = self.mail()
            if MFMailComposeViewController.canSendMail(){
                self.present(mailCompose, animated: true, completion: nil)
            }
        })
        
        let cancelAction = UIAlertAction(title: "Болдырмау", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        actionSheet.addAction(mailAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func mail() -> MFMailComposeViewController{
        let  mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["seil.kuka@gmail.com"])
        mailComposerVC.setSubject("App Feedback")
        mailComposerVC.setMessageBody("Hi Kuanysh!\n\n I would like to share the following feedback...\n", isHTML: false)
        return mailComposerVC
    }

}



















