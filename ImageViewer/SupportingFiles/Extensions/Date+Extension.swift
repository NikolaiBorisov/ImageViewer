//
//  Date+Extension.swift
//  ImageViewer
//
//  Created by NIKOLAI BORISOV on 16.02.2022.
//

import Foundation

extension Date {
    
    static func getFormattedDate(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyy, HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
}
