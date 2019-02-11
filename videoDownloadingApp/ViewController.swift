//
//  ViewController.swift
//  videoDownloadingApp
//
//  Created by Michael Bielodied on 2/3/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UITableViewController {
    
    //MARK : variables
    let refreshTVControl = UIRefreshControl()
    private let tableInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    private let dataSource = VideoListDataSource()
    fileprivate weak var playerVC: AVPlayerViewController?
    
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
            
            // 1
            guard let newIndexPathsToReload = self.viewModel.newIndexPathsToReload else {
                self.tableView.reloadData()
                return
            }
            
            // 2
            let indexPathsToReload = self.visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
            
            if indexPathsToReload.count > 0 {
                self.tableView.beginUpdates()
                self.tableView.reloadRows(at: indexPathsToReload, with: .automatic)
                self.tableView.endUpdates()
            } else {
                self.tableView.reloadData()
            }
        }
        
        viewModel.fetchVideos()
    }
    
    @objc private func refreshVideosData(_ sender: Any) {
        // Fetch Videos Data
        viewModel.fetchVideos()
    }
    
    @objc func longPressAction() {
        
        guard let _playerVC = playerVC else {
            return
        }
        
        Alert.showAlert(on: _playerVC, title: "Would you like to save this video to library?", cancelTitle: "Cancel", otherTitle: "Save to the camera roll", failure: { [weak self] in
            guard let self = self else {
                return
            }
            
            MediaHelper.shared.saveVideoFile(from: "", completion: { (result) in
                switch result {
                    case .success(let isSuccess) :
                        
                        Alert.showAlert(on: self, msg: isSuccess ? "Video Saved" : "Unable to save the video")
                        
                    break
                    case .failure(let error) :
                        Alert.showAlert(on: self, msg: error.localizedDescription)
                    break
                }
            })

        })
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let player = MediaHelper.shared.showVideoPlayer(with: dataSource.data.value[indexPath.row].videoFiles.mp4)
        
        guard let _player = player else {
            return
        }
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction))
        _player.view.addGestureRecognizer(longPressGestureRecognizer)
        
        present(_player, animated: true) {
            self.playerVC = _player
        }
        
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
        tableView.prefetchDataSource = self
        tableView.refreshControl = refreshTVControl
        
        // Configure Refresh Control
        refreshTVControl.addTarget(self, action: #selector(refreshVideosData(_:)), for: .valueChanged)
        
    }
}

extension ViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.fetchVideos()
        }
    }
}

private extension ViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.currentCount
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}
