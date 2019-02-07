//
//  Story.swift
//  videoDownloadingApp
//
//  Created by Michael Bielodied on 2/3/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import Foundation

struct Story: Decodable {
    let title: String
    let thumbnails: Thumbnails
    let createdAt: Date?
    let videoFiles: VideoFile
    
    enum CodingKeys: String, CodingKey { //mapping the keys here
        case title, createdAt = "created_at", thumbnails = "cover_photos", videoFiles = "video_files"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try container.decode(String.self, forKey: .title)
        self.thumbnails = try container.decode(Thumbnails.self, forKey: .thumbnails)
     
        let createdAtAsString = try container.decode(String.self, forKey: .createdAt)
        self.createdAt = DateFormatter.iso8601Full.date(from: createdAtAsString)
        
        self.videoFiles = try container.decode(VideoFile.self, forKey: .videoFiles)
        
    }
}
