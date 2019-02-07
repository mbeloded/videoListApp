//
//  ErrorResult.swift
//  videoDownloadingApp
//
//  Created by Michael Bielodied on 2/5/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import Foundation

enum ErrorResult: Error {
    case network(string: String)
    case parser(string: String)
    case custom(string: String)
}
