//
//  Result.swift
//  videoDownloadingApp
//
//  Created by Michael Bielodied on 2/5/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import Foundation

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}
