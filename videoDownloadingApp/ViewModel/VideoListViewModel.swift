//
//  VideoListViewModel.swift
//  videoDownloadingApp
//
//  Created by Michael Bielodied on 2/4/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import UIKit

final class VideoListViewModel {
    
    weak var dataSource : GenericDataSource<Story>?
    weak var service: VideoServiceProtocol?
    
    private var currentPage = 1
    private var total = 0
    private var isFetchInProgress = false
    
    init(service: VideoServiceProtocol = VideoService.shared, dataSource : GenericDataSource<Story>?) {
        self.dataSource = dataSource
        self.service = service
    }
    
    func fetchVideos(_ completion: ((Result<Bool, ErrorResult>) -> Void)? = nil) {
        
        guard let service = service else {
            completion?(Result.failure(ErrorResult.custom(string: "Missing service")))
            return
        }
        
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        
        service.fetchVideos( currentPage, completion: { result in
            
            switch result {
            case .success(let response) :
                
                DispatchQueue.main.async {
                    
                    // 1
                    self.isFetchInProgress = false
                    self.total = response.body.total
                    
                    // 2
                    // reload data
                    self.dataSource?.data.value.append(contentsOf: response.body.stories)
                    
                    if self.currentPage > 1 {
                        completion?(Result.success(true))//send collection of index pathes to reload
                    } else {
                        completion?(Result.success(true))
                    }
                    self.currentPage += 1
                }
                break
            case .failure(let error) :
                
                DispatchQueue.main.async {
                    print("Parser error \(error)")
                    
                    self.isFetchInProgress = false
                    completion?(Result.failure(error))
                }
                break
            }
            
        })
    }
}
