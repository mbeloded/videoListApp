//
//  ViewController.swift
//  videoDownloadingApp
//
//  Created by Michael Bielodied on 2/3/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    //MARK : variables
    let refreshTVControl = UIRefreshControl()
    private let tableInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    private let dataSource = VideoListDataSource()
    lazy var viewModel : VideoListViewModel = {
        let viewModel = VideoListViewModel(dataSource: dataSource)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "Stories list"
        
        setupTableView()
        
        dataSource.data.addAndNotify(observer: self) { [weak self] in
            guard let self = self else {
                return
            }
            
            self.refreshTVControl.endRefreshing()
            
            self.tableView.reloadData()
        }
        
        viewModel.fetchVideos()
    }
    
    @objc private func refreshVideosData(_ sender: Any) {
        // Fetch Videos Data
        viewModel.fetchVideos()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    public func setupTableView() {
        
        // Add Refresh Control to Table View
        
        tableView.separatorInset = tableInsets
    
        //setting up the flexible cell height
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        //removing empty cells
        tableView.tableFooterView = UIView.init()
        tableView.layoutMargins = .zero
        tableView.register(VideoTableViewCell.nibCell, forCellReuseIdentifier: VideoTableViewCell.reuseIdentifier)
        
        tableView.dataSource = dataSource
        
        tableView.refreshControl = refreshTVControl
        // Configure Refresh Control
        refreshTVControl.addTarget(self, action: #selector(refreshVideosData(_:)), for: .valueChanged)
        
    }
}

