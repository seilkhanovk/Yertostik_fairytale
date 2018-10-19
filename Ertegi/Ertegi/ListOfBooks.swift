//
//  ListOfBooks.swift
//  Ertegi
//
//  Created by Kuanysh on 25.07.17.
//  Copyright © 2017 KuanyshTeam. All rights reserved.
//

import UIKit
import FolioReaderKit

class ListOfBooks: UITableViewController, UISearchBarDelegate {
    
    let books = ertegiler.loadData()
    var searchBar: UISearchBar!
    var totalPages: Int = 0
    var filterText = ""
    let cellSpacingHeight: CGFloat = 10
    
    var filteredArray: [ertegiler] {
        let nameFiltered = filterText.characters.count == 0 ? books : books.filter {
            if !$0.title.lowercased().contains(filterText.lowercased()) {
                return $0.author.lowercased().contains(filterText.lowercased())
            } else {
                return true
            }
        }
        return nameFiltered
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
    
        self.tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.4153206348, green: 0.798602283, blue: 0.3129432201, alpha: 1)
        
        searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBarStyle.prominent
        searchBar.placeholder = "Кітап немесе автор"
        searchBar.barTintColor = #colorLiteral(red: 0.9593952298, green: 0.9594177604, blue: 0.959405601, alpha: 1)
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        
        tableView.tableHeaderView = searchBar
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = #colorLiteral(red: 0.9593952298, green: 0.9594177604, blue: 0.959405601, alpha: 1)
    }
    
    // MARK: UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterText = searchText
        tableView.reloadData()
    }
    
    // MARK: UITableViewDelegate, UITableViewDataSource
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    //    return filteredArray.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return filteredArray.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid1", for: indexPath) as! Cellid1
        
       /* cell.textLabel?.text = filteredArray[indexPath.row].title
        cell.detailTextLabel?.text = filteredArray[indexPath.row].author
       cell.imageView?.image = filteredArray[indexPath.row].cover
        */
        
      cell.imageViewOfCellid1.image = filteredArray[indexPath.section].cover
      cell.nameOfBook.text = filteredArray[indexPath.section].title
      cell.author.text = filteredArray[indexPath.section].author

        
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.clear.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let config = configurations()
        let folioReader = FolioReader()
           let bookPath = Bundle.main.path(forResource: filteredArray[indexPath.section].path, ofType: "epub")
            
            folioReader.presentReader(parentViewController: self, withEpubPath: bookPath!, andConfig: config)
   }
    
    // MARK: Downloading Epub from URL
    func downloadURL(url: String, title: String) ->  URL{
        // Create destination URL
        let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL!
        let titleOfBook = title + ".epub"
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
    
    
    // MARK: Configurations of FolioReaderKit
    func configurations () -> FolioReaderConfig {
        let config = FolioReaderConfig()
        
        config.quoteCustomBackgrounds = []
        if let image = UIImage(named: "demo-bg") {
            let customImageQuote = QuoteImage(withImage: image, alpha: 0.6, backgroundColor: UIColor.black)
            config.quoteCustomBackgrounds.append(customImageQuote)
        }
        
        let textColor = UIColor(red:0.86, green:0.73, blue:0.70, alpha:1.0)
        let customColor = UIColor(red:0.30, green:0.26, blue:0.20, alpha:1.0)
        let customQuote = QuoteImage(withColor: customColor, alpha: 1.0, textColor: textColor)
        config.quoteCustomBackgrounds.append(customQuote)

      return config
    }
    
    // MARK: Animation
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
        if UserPreferences.isAnimationOn {
            animateTable()
        }
    }
    
    func animateTable() {
        let cells = tableView.visibleCells
        
        let tableViewHeight = tableView.bounds.size.height
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        
        var delayCounter: Double = 0
        for cell in cells {
            UIView.animate(withDuration: 1.75, delay: delayCounter * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
  
    }
}
