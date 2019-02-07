//
//  Common.swift
//  videoDownloadingApp
//
//  Created by Michael Bielodied on 2/7/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import Foundation

public class Common : NSObject
{
    struct Global{
        static let API_URL = "https://slide.ly/api"
        static let API_ALL = "/highlights/recent"
        static let API_ALL_WITH_PAGES = "?limit=%d&page=%d"
    }
    
    static var getAll: String {
        return Common.Global.API_URL + Common.Global.API_ALL
    }
    
    static var getRecentHighlightsByPage: String {
        return Common.Global.API_URL + Common.Global.API_ALL + Common.Global.API_ALL_WITH_PAGES
    }

}
