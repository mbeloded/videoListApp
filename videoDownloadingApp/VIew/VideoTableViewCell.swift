//
//  VideoTableViewCell.swift
//  videoDownloadingApp
//
//  Created by Michael Bielodied on 2/3/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    //MARK: variables
    static let reuseIdentifier = "VideoTableViewCell"
    var videoItemListViewModel: VideoListItemViewModel? {
        didSet {
            if let videoItemListViewModel = videoItemListViewModel {
                titleLabel.text = videoItemListViewModel.title
                thumbnailImageView.download(from: videoItemListViewModel.thumbnailUrl)
                createdDateLabel.text = videoItemListViewModel.subtitle
            }
        }
    }
    
    //MARK: outlets
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            //set the font style
        }
    }
    @IBOutlet weak var createdDateLabel: UILabel! {
        didSet {
            //set the font style
        }
    }
    @IBOutlet weak var thumbnailImageView: UIImageView! {
        didSet {
            //setup the border line
            thumbnailImageView.layer.borderColor = UIColor.gray.cgColor
            thumbnailImageView.layer.borderWidth = 3
            thumbnailImageView.layer.cornerRadius = 5
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
