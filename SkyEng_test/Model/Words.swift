//
//  Words.swift
//  SkyEng_test
//
//  Created by Dima Loria on 10.10.2021.
//

import Foundation

struct Word: Decodable {
    let text: String
    let meanings: [Meaning]
}

struct Meaning: Decodable {
    let id: Int
    let partOfSpeechCode: String
    let translation: Translation
    let previewURL: String
    let imageURL: String
    let transcription: String
    let soundURL: String

    private enum CodingKeys: String, CodingKey {
        case id,
             partOfSpeechCode,
             translation
        case previewURL = "previewUrl"
        case imageURL = "imageUrl"
        case transcription
        case soundURL = "soundUrl"
    }
}

struct Translation: Decodable {
    let text: String
    var note: String?
}
