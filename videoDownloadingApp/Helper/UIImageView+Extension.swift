//
//  UIImageView+Extension.swift
//  videoDownloadingApp
//
//  Created by Michael Bielodied on 2/3/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import UIKit

extension UIImageView {
    
    //the problem of this code is that we are NOT caching the images here
    func download(from url: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        
        let completionHandler: (Result<Data, ErrorResult>) -> Void = { (result) in
            
            switch result {
                case .success(let data) :
                    DispatchQueue.main.async {
                        print("\ndownload completed")
                        self.image = UIImage(data: data)
                    }
                    break
            
                case .failure(let error) :
                    DispatchQueue.main.async {
                        print(error.localizedDescription)
                        self.image = UIImage(named: "")
                    }
                    break
                
            }
        }
        
        APIService.init().get(urlString: url, completion: completionHandler)
        
    }
}
