//
//  VideoListItemViewModel.swift
//  videoDownloadingApp
//
//  Created by Michael Bielodied on 2/4/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import Foundation

struct VideoListItemViewModel {
    let title: String
    let thumbnailUrl: String
    let subtitle: String
    
    init(_ storyItem: Story) {
        title = storyItem.title
        thumbnailUrl = storyItem.thumbnails.small
        subtitle = storyItem.createdAt?.asString(withFormat: "MM-YYYY") ?? ""
    }
}
