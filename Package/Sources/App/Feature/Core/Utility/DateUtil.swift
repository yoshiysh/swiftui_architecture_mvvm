//
//  DateUtil.swift
//
//
//  Created by yoshi on 2022/09/29.
//

import Foundation

public class DateUtil {

    public enum FormatType: String {
        case YYYYMMDD = "yyyy/MM/dd"
    }

    public static let shared = DateUtil()
    private let dateFormatter = DateFormatter()

    private init() {}

    public func formatDate(from date: Date, format: FormatType) -> String {
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: date)
    }
}
