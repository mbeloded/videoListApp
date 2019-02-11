//
//  MediaHelper.swift
//  videoDownloadingApp
//
//  Created by Michael Bielodied on 2/11/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import Foundation
import AVKit
import AVFoundation
import Photos

class MediaHelper {
    
    public static var shared = MediaHelper()
    
    fileprivate let defVideoFormat = ".mp4"
    
    func showVideoPlayer(with url: String) -> AVPlayerViewController? {
        
        guard let selectedVideoURL = URL.init(string: url) else {
            return nil
        }
        
        let player = AVPlayer(url: selectedVideoURL)
        let playerController = AVPlayerViewController()
        playerController.entersFullScreenWhenPlaybackBegins = true
        playerController.player = player
        
        return playerController
    }
    
    func saveVideoFile(from url: String, completion: @escaping ((Result<Bool, ErrorResult>) -> Void)) {
        APIService.init().get(urlString: url) { [weak self] (response) in
            
            guard let self = self else {
                return
            }
            
            switch response {
                case .success(let data):
                    
                    let targetPath = NSTemporaryDirectory().appending("\(abs(url.hashValue))\(self.defVideoFormat)")
                    if FileManager.default.fileExists(atPath: targetPath) {
                        do {
                            try FileManager.default.removeItem(atPath: targetPath)
                        } catch {
                            completion(.failure(.custom(string: "video was not saved")))
                            return
                        }
                    }
                    
                    do {
                        try data.write(to: URL(fileURLWithPath: targetPath))
                    } catch {
                        completion(.failure(.custom(string: "video was not saved")))
                        return
                    }
                
                    let assetURL = URL(fileURLWithPath: targetPath)
                    PHPhotoLibrary.shared().performChanges({
                        PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: assetURL)
                    }) { saved, error in
                        
                        if let error = error {
                            completion(.failure(.custom(string: error.localizedDescription)))
                            return
                        }
                        
                        if saved {
                            completion(.success(true))
                        } else {
                            completion(.success(false))
                        }
                        
                    }
                    
                    
                break
                case .failure(let error):
                    completion(.failure(.custom(string: error.localizedDescription)))
                break
            }
        }

    }
}
