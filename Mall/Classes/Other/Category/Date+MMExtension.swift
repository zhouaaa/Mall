//
//  Date+MMExtension.swift
//  Mall
//
//  Created by iOS on 2022/4/14.
//


import UIKit

extension Date {
    
    static var formatter : DateFormatter = DateFormatter.init()
    
    
    public static func getCurrentTime() -> Double {
        let nowDate = Date()
        let interval = Double(nowDate.timeIntervalSince1970)
        return interval
    }
    
    public func geTMicroSec() -> Double {
    
        let nowDate = self
        
        let interval = Double(nowDate.timeIntervalSince1970)
        
        return interval
    }
    
    public static func getCurrentDateTime() -> Date? {
        formatter.dateFormat = "yyyy-MM-dd HH:mm:SS"
        formatter.timeZone = TimeZone.init(secondsFromGMT: 8);
        let str =  formatter.string(from: Date())
        return formatter.date(from: str)
    }
    
    public static func getCurrentHourTime() -> String {
        let nowDate = Date()
        let zone = NSTimeZone.system
        let intev = zone.secondsFromGMT(for: nowDate)
        let _newDate = nowDate.addingTimeInterval(TimeInterval(intev))
        formatter.dateFormat = "HH"
        return formatter.string(from: _newDate)
    }
    
    public static func getCurrentDateTimeStr(format: String = "yyyy-MM-dd HH:mm:SS") -> String {
          let nowDate = Date()
          formatter.dateFormat = format
          return formatter.string(from: nowDate)
    }
    
    /// 时间戳转时间
    ///
    /// - Parameter date: 时间
    /// - Returns: 转换后的格式化时间c字符串
    public static func timeStampChangeDate(_ date:Double, format: String = "yyyy-MM-dd HH:mm:SS") -> String {
        let timeInterval:TimeInterval = TimeInterval(date)
        let date = Date(timeIntervalSince1970: timeInterval / 1000)
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    

    /// Date类型返回字符串
    /// - Parameters:
    ///   - date: date description
    ///   - format: format description
    /// - Returns: description
    public static func stringFromDate(_ date:Date , format:String = "yyyy-MM-dd HH:mm") -> String {
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
 
    /// 字符串转Date类型
    ///
    /// - parameter str:           日期字符串
    /// - parameter withFormatter: 格式化
    ///
    /// - returns: date
    public static func dateFromString(_ str:String ,withFormatter:String) -> Date? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.init(secondsFromGMT: 8);
        formatter.dateFormat = withFormatter
        return formatter.date(from: str)
    }
    
    
}
