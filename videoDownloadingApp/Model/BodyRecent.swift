//
//  BodyRecent.swift
//  videoDownloadingApp
//
//  Created by Michael Bielodied on 2/3/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import Foundation

struct BodyRecent: Decodable {
    let stories: [Story]
    let total: Int
    
    enum CodingKeys: String, CodingKey { //mapping the keys here
        case total = "total_stories", stories = "stories"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.total = try container.decode(Int.self, forKey: .total)
        self.stories = try container.decode([Story].self, forKey: .stories)
    }
    
    init(stories: [Story], total: Int) {
        self.stories = stories
        self.total = total
    }
}

extension BodyRecent: Parceable {
    
    static func parseObject(dictionary: [String : AnyObject]) -> Result<BodyRecent, ErrorResult> {
        if let total = dictionary["total_stories"] as? Int,
            let stories = dictionary["stories"] as? [String: Double] {
            
//            let finalRates : [CurrencyRate] = rates.flatMap({ CurrencyRate(currencyIso: $0.key, rate: $0.value) })
//            let conversion = Converter(base: base, date: date, rates: finalRates)

            let stories: [Story] = [Story]()//stories.flatMap({ Story() })
            
            let bodyRecent = BodyRecent(stories: stories, total: total)
            return Result.success(bodyRecent)
        } else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse conversion rate"))
        }
    }
}
