//
//  VideoListDataSource.swift
//  videoDownloadingApp
//
//  Created by Michael Bielodied on 2/4/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import UIKit

class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}

class VideoListDataSource : GenericDataSource<Story>, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.identifierCell, for: indexPath) as! VideoTableViewCell
        
        let storyItem = data.value[indexPath.row]
        cell.videoItemListViewModel = VideoListItemViewModel(storyItem)
        
        return cell
    }
}
