//
//  QuranResponses.swift
//  Quran Online
//
//  Created by Muhammad Utsman on 5/12/19.
//  Copyright © 2019 Muhammad Utsman. All rights reserved.
//

import UIKit


// CHAPTER
struct TranslatedChapter: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}

struct Chapter: Decodable {
    let id: Int
    let nameArabic: String
    let nameSimple: String
    let versesCount: Int
    let translatedName: TranslatedChapter
    
    enum CodingKeys: String, CodingKey {
        case id
        case nameArabic = "name_arabic"
        case nameSimple = "name_simple"
        case versesCount = "verses_count"
        case translatedName = "translated_name"
    }
}

struct Chapters: Decodable {
    let chapters: [Chapter]
    
    enum CodingKeys: String, CodingKey {
        case chapters
    }
}

// VERSES
struct Verse: Decodable {
    let id: Int
    let verseNumber: Int
    let textIndopak: String
    let juzNumber: Int
    let translatedVerses: [TranslatedVerses]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case verseNumber = "verse_number"
        case textIndopak = "text_indopak"
        case juzNumber = "juz_number"
        case translatedVerses = "translations"
    }
}

struct TranslatedVerses: Decodable {
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case text
    }
}

struct Meta: Decodable {
    let nextPage: Int?
    
    enum CodingKeys: String, CodingKey {
        case nextPage = "next_page"
    }
}

struct Verses: Decodable {
    let verses: [Verse]
    let meta: Meta
    
    enum CodingKeys: String, CodingKey {
        case verses
        case meta
    }
}

//"meta": {
//    "current_page": 1,
//    "next_page": 2,
//    "prev_page": null,
//    "total_pages": 29,
//    "total_count": 286
//}
