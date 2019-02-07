//
//  VideoService.swift
//  videoDownloadingApp
//
//  Created by Michael Bielodied on 2/5/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import Foundation

protocol VideoServiceProtocol : class {
    func fetchVideos(_ page: Int, completion: @escaping ((Result<Recent, ErrorResult>) -> Void))
}

final class VideoService : RequestHandler, VideoServiceProtocol {

    static let shared = VideoService()
    private let limit = 5
    
    func fetchVideos(_ page: Int, completion: @escaping ((Result<Recent, ErrorResult>) -> Void)) {
       
        let url = String(format: Common.getRecentHighlightsByPage, limit, page)
        
        APIService.init().get(urlString: url,
                              completion: self.networkResult(completion: completion))
    }
}
