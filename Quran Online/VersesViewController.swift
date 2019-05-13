//
//  ChapterViewController.swift
//  Quran Online
//
//  Created by Muhammad Utsman on 5/12/19.
//  Copyright © 2019 Muhammad Utsman. All rights reserved.
//

import UIKit

class VersesViewController: UIViewController {
    @IBOutlet weak var verseTableView: UITableView!
    var idChapter = 0
    var nameChapter = ""
    var verses = [Verse]()
    var page = 1
    
    override func viewDidLoad() {
        print(idChapter)
        
        self.navigationItem.title = nameChapter
        verseTableView.delegate = self
        verseTableView.dataSource = self
        
    
        getData(page: page)
    }
    
    func getData(page: Int) {
        let urlString = "http://staging.quran.com:3000/api/v3/chapters/\(idChapter)/verses?&translations=33&language=id&page=\(page)"
        
        let baseUrl = URL(string: urlString)
        guard let url = baseUrl else { return }
        print(urlString)
        
        URLSession.shared.dataTask(with: url) { (data, urlResponses, error) in
            print("connection success")
            guard let data = data, error == nil, urlResponses != nil else {
                print("error get url")
                return
            }
            
            do {
                let versesResponses = try JSONDecoder().decode(Verses.self, from: data)
                let verses = versesResponses.verses
                //self.verses = verses
                for verse in verses {
                    self.verses.append(verse)
                }
            
                let nextPage = versesResponses.meta.nextPage
                
                guard let nPage = nextPage else { return }
                self.page = nPage
                
                DispatchQueue.main.async {
                    self.verseTableView.reloadData()
                }
                
            } catch {
                print("error after get data" + error.localizedDescription)
            }
            
        }.resume()
        
    }
}

extension VersesViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return verses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let verse = verses[indexPath.row]
        let verseCellController = tableView.dequeueReusableCell(withIdentifier: "verse_cell") as! VersesCellController
        verseCellController.setupVerse(verse: verse)
        return verseCellController
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = verses.count - 1
        if indexPath.row == lastItem {
            getData(page: page)
        }
    }
    
    
}
