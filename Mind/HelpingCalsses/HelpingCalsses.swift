//
//  HelpingCalsses.swift
//  Mind
//
//  Created by Adel on 8/14/18.
//  Copyright © 2018 Mind. All rights reserved.
//

import Foundation

import  UIKit
class HelpingMethods
{
    static func showActivityIndicator(myView:UIView)-> UIActivityIndicatorView
    {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.center = myView.center
        activityIndicator.color = #colorLiteral(red: 0, green: 0.7357301712, blue: 0.9509622455, alpha: 1)
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        myView.addSubview(activityIndicator)
        return activityIndicator
    }
    ///////
    static func removeActivityIndicator(activityIndicator:UIActivityIndicatorView)
    {
        
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        
        
    }
    // this function to show alertview
    class func showAlertView()
    {
        
    }
    // this function receive array of String(period pickerview values and return two dates (from date & to date))
    static func claculateFromAndToDates(period:String,fromDate:Date,toDate:Date)-> [Date]
    {
        ///////

        let date = Date() // to get current date
        var fromDate = fromDate
        var toDate = toDate
        
        switch  period{
        case "اليوم الحالي":
            fromDate = date
            toDate = date
            
            return [fromDate,toDate]
        case "اليوم السابق":
            fromDate = date.yesterday
            print("last date : \(fromDate)")
            toDate = date
            return [fromDate,toDate]
        case "الاسبوع الحالي":
            fromDate = Date().startOfWeek!
            print("Dateeee:\(fromDate)")
            return [fromDate,toDate]
        case "الاسبوع السابق":
            let lastWeekDate = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: Date())!

            fromDate = lastWeekDate
            return [fromDate,toDate]
        case "الشهر الحالي":
            let comp: DateComponents = Calendar.current.dateComponents([.year, .month,.day], from: date)
            let startOfMonth = Calendar.current.date(from: comp)!
            fromDate = startOfMonth
            
            return [fromDate,toDate]
        case "الشهر السابق":
           
            let nextMonth = Calendar.current.date(byAdding: .month, value: -1, to: Date())
            
            fromDate = nextMonth!
            print("last month \(nextMonth)")
            return [fromDate,toDate]
        case "العام الحالي":
            let date = Date()
            let calendar = Calendar.current
            
            let comp: DateComponents = Calendar.current.dateComponents([.year], from: date)
            let startOfYear = Calendar.current.date(from: comp)!
            fromDate = startOfYear
            print("year\(startOfYear)")
             return [fromDate,toDate]
        case "العام السابق":
            
            var lastYear = Calendar.current.date(byAdding: .year, value: -1, to: Date())!
            print("last month \(lastYear)")
            
            let currentDate = Date()
            let gregorianCalendar = Calendar(identifier: .gregorian)
            var components = gregorianCalendar.dateComponents([.year, .month, .day], from: lastYear)
            
            // Change int value which you want to minus from current Date.
            components.day = 1
            components.month = 1
            
            let date = gregorianCalendar.date(from: components)!
            
            fromDate = date
            return [fromDate,toDate]
        default:
            print("No Data")
        }
     
        return[fromDate,toDate]
    }
    ////
   
    // End of the class
}

// Extention date
/////
extension Date {
    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {
        
        let currentCalendar = Calendar.current
        
        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }
        
        return end - start
    }
}
// this extenion to add & subtract two days
extension Date {
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return tomorrow.month != month
    }
}
// this extenion to access last or next week/month/year
extension Date {
    
    static func today() -> Date {
        return Date()
    }
    
    func next(_ weekday: Weekday, considerToday: Bool = false) -> Date {
        return get(.Next,
                   weekday,
                   considerToday: considerToday)
    }
    
    func previous(_ weekday: Weekday, considerToday: Bool = false) -> Date {
        return get(.Previous,
                   weekday,
                   considerToday: considerToday)
    }
    
    func get(_ direction: SearchDirection,
             _ weekDay: Weekday,
             considerToday consider: Bool = false) -> Date {
        
        let dayName = weekDay.rawValue
        
        let weekdaysName = getWeekDaysInEnglish().map { $0.lowercased() }
        
        assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")
        
        let searchWeekdayIndex = weekdaysName.index(of: dayName)! + 1
        
        let calendar = Calendar(identifier: .gregorian)
        
        if consider && calendar.component(.weekday, from: self) == searchWeekdayIndex {
            return self
        }
        
        var nextDateComponent = DateComponents()
        nextDateComponent.weekday = searchWeekdayIndex
        
        
        let date = calendar.nextDate(after: self,
                                     matching: nextDateComponent,
                                     matchingPolicy: .nextTime,
                                     direction: direction.calendarSearchDirection)
        
        return date!
    }
    
}

// MARK: Helper methods
extension Date {
    func getWeekDaysInEnglish() -> [String] {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "en_US_POSIX")
        return calendar.weekdaySymbols
    }
    
    enum Weekday: String {
        case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    }
    
    enum SearchDirection {
        case Next
        case Previous
        
        var calendarSearchDirection: Calendar.SearchDirection {
            switch self {
            case .Next:
                return .forward
            case .Previous:
                return .backward
            }
        }
    }
}
//
extension Calendar {
    static let gregorian = Calendar(identifier: .islamic)
}
extension Date {
    var startOfWeek: Date? {
        return Calendar.init(identifier: .islamic).date(from: Calendar.init(identifier: .islamic).dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
    }
}
//
//extension NSDate {
//    static func changeDaysBy(days : Int) -> NSDate {
//        let currentDate = NSDate()
//        let dateComponents = NSDateComponents()
//        dateComponents.day = days
//        return NSCalendar.currentCalendar.dateByAddingComponents(dateComponents, toDate: currentDate, options: NSCalendar.Options(rawValue: 0))!
//    }
//}

