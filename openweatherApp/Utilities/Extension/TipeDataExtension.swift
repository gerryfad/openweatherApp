//
//  TipeDataExtension.swift
//  openweatherApp
//
//  Created by Gerry on 05/03/25.
//

import Foundation

extension Int {
    
    func toTimeString(timeZone: TimeZone = .current) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = timeZone
        return dateFormatter.string(from: date)
    }
    
}
