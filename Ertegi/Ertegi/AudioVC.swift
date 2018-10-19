//
//  AudioVC.swift
//  Ertegi
//
//  Created by Kuanysh on 14.08.17.
//  Copyright © 2017 KuanyshTeam. All rights reserved.
//

import UIKit
import FirebaseStorage
import Firebase
import SVProgressHUD

class AudioVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tabelView: UITableView!
    var main: URL? {
        didSet {
            SVProgressHUD.dismiss()
        }
    }
    
    var music: [(String, UIImage)] = [("Үш ұры", #imageLiteral(resourceName: "Үш ұры")), ("Алдардың бір байды алдауы", #imageLiteral(resourceName: "Bitmap")), ("Аш қасқырдың арманы", #imageLiteral(resourceName: "Аш қасқырдың арманы")), ("Еріншек", #imageLiteral(resourceName: "Еріншек")), ("Мақта қыз бен мысық", #imageLiteral(resourceName: "Мақта қыз бен мысық-1")), ("Түйе іздеген адам", #imageLiteral(resourceName: "Түйе іздеген адам")), ("Қазығұрт тауы", #imageLiteral(resourceName: "Қазығұрт тауы")), ("Қорқыт туралы аңыз ертегілер", #imageLiteral(resourceName: "Қорқыт туралы аңыз"))]
   
    var tempIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelView.dataSource = self
        tabelView.delegate = self
        tabelView.backgroundColor = #colorLiteral(red: 0.9593952298, green: 0.9594177604, blue: 0.959405601, alpha: 1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return music.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabelView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AudioBookCell
        cell.titleOfBook.text = music[indexPath.row].0
        cell.coverImage.image = music[indexPath.row].1
        cell.artistOfBook.text = "Қазақ халық ертегілері"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
//        getURL(music[indexPath.row].0)
//        if main != nil{
//            main = nil
//        } else{
//            SVProgressHUD.show()
//        }
        
        tempIndex = indexPath
        performSegue(withIdentifier: "segueToAudioPlayerVC", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueToAudioPlayerVC" {
            let myVC = segue.destination as! AudioPlayerVC
            if let ind = tempIndex {
                myVC.imageCover1 = music[ind.row].1
                myVC.titleLabel1 = music[ind.row].0
                myVC.urlOfErtegi = music[ind.row].0
                
               //  let remoteURL = String(describing: getURL(music[ind.row]))
                //                let localURL = downloadURL(url: remoteURL, title: music[ind.row])
                //                print("Kuanysh")
                //                print(localURL)
            }
        }
    }
    
    func getURL(_ name: String) {
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let realName = name + ".mp3"
        let audioRef = storageRef.child("audio/\(realName)")
        var urlOfAudio = ""
        
        audioRef.downloadURL { (url, error) in
            if let error = error {
                print(error)
            } else {
                urlOfAudio = String(describing: url!)
                self.main = self.downloadURL(url: urlOfAudio, title: "ury")
                print(self.main!)
            }
        }
    }
    
    func downloadURL(url: String, title: String) ->  URL{
        // Create destination URL
        let documentsUrl: URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL!
        let titleOfBook = title + ".mp3"
        let destinationFileUrl = documentsUrl.appendingPathComponent(titleOfBook)
        
        //Create URL to the source file you want to download
        let fileURL = URL(string: url)
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        let request = URLRequest(url: fileURL!)
        
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                } catch (let writeError) {
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                }
            } else {
                print("Error took place while downloading a file. Error description: %@", error?.localizedDescription ?? "");
            }
        }
        task.resume()
        
        return destinationFileUrl
    }
}
