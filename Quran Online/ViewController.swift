//
//  ViewController.swift
//  Quran Online
//
//  Created by Muhammad Utsman on 5/12/19.
//  Copyright © 2019 Muhammad Utsman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var chapterTableView: UITableView!
    
    final let baseUrl = URL(string: "http://staging.quran.com:3000/api/v3/chapters?language=id")
    var chapters = [Chapter]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData()
        chapterTableView.delegate = self
        chapterTableView.dataSource = self
        
        chapterTableView.rowHeight = UITableView.automaticDimension
        chapterTableView.estimatedRowHeight = 500
        
    }
    
    func getData() {
        guard let url = baseUrl else { return }
        URLSession.shared.dataTask(with: url) { (data, urlResponses, error) in
            
            guard let data = data, error == nil, urlResponses != nil else {
                print("url error")
                return
            }
            
            do {
                let chapterResponses = try JSONDecoder().decode(Chapters.self, from: data)
                let chapters = chapterResponses.chapters
                self.chapters = chapters
                
                DispatchQueue.main.async {
                    self.chapterTableView.reloadData()
                }
                
                print(self.chapters[0].nameSimple)
                
            } catch {
                print("error after get url data " + error.localizedDescription)
            }
            
        }.resume()
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chapters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chapter = chapters[indexPath.row]
        let chapterCell = tableView.dequeueReusableCell(withIdentifier: "chapter_cell") as! ChapterCellController
        chapterCell.setupCell(chapter: chapter)
        return chapterCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let versesController = storyboard?.instantiateViewController(withIdentifier: "verses_view") as! VersesViewController
        versesController.idChapter = self.chapters[indexPath.row].id
        versesController.nameChapter = self.chapters[indexPath.row].nameArabic
        self.navigationController?.pushViewController(versesController, animated: true)
    }
    
}

