//
//  Alert.swift
//  videoDownloadingApp
//
//  Created by Michael Bielodied on 2/3/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import UIKit

struct Alert {
    
    private static func showBasicAlert(on vc: UIViewController, with title: String, message: String, cancelTitle: String? = "OK", otherTitle: String? = nil, completion: (()->())? = nil, failure: (()->())? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let _otherTitle = otherTitle {
            alert.addAction(UIAlertAction(title: _otherTitle, style: .default, handler: { (action) in
                completion?()
            }))
        }
        
        if let _cancelTitle = cancelTitle {
            alert.addAction(UIAlertAction(title: _cancelTitle, style: .cancel, handler: { (action) in
                failure?()
            }))
        }
        
        DispatchQueue.main.async {
            vc.present(alert, animated: true)
        }
    }
    
    static func showRequestError(on vc: UIViewController, errorMsg: String) {
        showBasicAlert(on: vc, with: "Request error", message: errorMsg)
    }
    
    static func showAlert(on vc: UIViewController, title: String = "", msg: String = "", cancelTitle: String? = "OK", otherTitle: String? = nil, completion: (()->())? = nil, failure: (()->())? = nil) {
        showBasicAlert(on: vc, with: title, message: msg, cancelTitle: cancelTitle, otherTitle: otherTitle, completion: completion, failure: failure)
    }
    
    static func showActionSheet(on vc: UIViewController, title: String = "", msg: String = "", actions: [UIAlertAction], completion: (()->())? = nil) {
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .actionSheet)
        actions.forEach { (action) in
            alertController.addAction(action)
        }
        vc.present(alertController, animated: true, completion: completion)
    }
}
