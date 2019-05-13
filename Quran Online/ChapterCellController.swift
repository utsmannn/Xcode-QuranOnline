//
//  ChapterCellController.swift
//  Quran Online
//
//  Created by Muhammad Utsman on 5/12/19.
//  Copyright © 2019 Muhammad Utsman. All rights reserved.
//

import UIKit

class ChapterCellController: UITableViewCell {
    @IBOutlet weak var txChapter: UILabel!
    
    
    func setupCell(chapter: Chapter) {
        txChapter.text = chapter.nameArabic
    }
}
