//
//  Date+Extension.swift
//  videoDownloadingApp
//
//  Created by Michael Bielodied on 2/7/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import Foundation

extension Date {
    public func asString(withFormat: String = "dd.MM.yy") -> String? {
        
        let dcDateFormatter: DateFormatter = DateFormatter.init()
        dcDateFormatter.dateFormat = withFormat// example "dd.MM.yy"
        return dcDateFormatter.string(from: self)
    }
}
