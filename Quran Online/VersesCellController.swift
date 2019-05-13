//
//  VersesCellController.swift
//  Quran Online
//
//  Created by Muhammad Utsman on 5/12/19.
//  Copyright © 2019 Muhammad Utsman. All rights reserved.
//

import UIKit

class VersesCellController: UITableViewCell {
    @IBOutlet weak var txVerse: UILabel!
    
    func setupVerse(verse: Verse) {
        txVerse.text = verse.textIndopak
    }
    
}
