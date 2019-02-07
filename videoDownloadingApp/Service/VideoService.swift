//
//  VideoService.swift
//  videoDownloadingApp
//
//  Created by Michael Bielodied on 2/5/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import Foundation

protocol VideoServiceProtocol : class {
    func fetchVideos(_ completion: @escaping ((Result<Recent, ErrorResult>) -> Void))
}

final class VideoService : RequestHandler, VideoServiceProtocol {

    static let shared = VideoService()
    
    func fetchVideos(_ completion: @escaping ((Result<Recent, ErrorResult>) -> Void)) {
       
        let url = String(format: Common.getRecentHighlightsByPage, 5, 1)
        APIService.init().get(urlString: url,
                              completion: self.networkResult(completion: completion))
    }
}
