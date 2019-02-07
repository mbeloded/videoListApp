//
//  Recent.swift
//  videoDownloadingApp
//
//  Created by Michael Bielodied on 2/3/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import Foundation

struct Recent: Decodable {
    let status: String
    let status_text: String
    let body: BodyRecent
}
