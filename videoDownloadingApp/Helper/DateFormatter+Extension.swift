//
//  DateFormatter+Extension.swift
//  videoDownloadingApp
//
//  Created by Michael Bielodied on 2/7/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import Foundation

extension DateFormatter {
    //
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"//new is 2018-06-19T13:49:20.356Z
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
