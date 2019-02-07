//
//  VideoListViewModel.swift
//  videoDownloadingApp
//
//  Created by Michael Bielodied on 2/4/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import UIKit

struct VideoListViewModel {
    weak var dataSource : GenericDataSource<Story>?
    weak var service: VideoServiceProtocol?
    
    init(service: VideoServiceProtocol = VideoService.shared, dataSource : GenericDataSource<Story>?) {
        self.dataSource = dataSource
        self.service = service
    }
    
    func fetchVideos(_ completion: ((Result<Bool, ErrorResult>) -> Void)? = nil) {
        
        guard let service = service else {
            completion?(Result.failure(ErrorResult.custom(string: "Missing service")))
            return
        }
        
        service.fetchVideos { result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let recent) :
                    // reload data
                    self.dataSource?.data.value = recent.body.stories
                    completion?(Result.success(true))
                    
                    break
                case .failure(let error) :
                    print("Parser error \(error)")
                    completion?(Result.failure(error))
                    
                    break
                }
            }
        }
    }
}
