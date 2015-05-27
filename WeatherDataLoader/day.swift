//
//  day.swift
//  WeatherDataLoader
//
//  Created by Kyle Tuczynski on 5/26/15.
//  Copyright (c) 2015 Kyle Tuczynski. All rights reserved.
//

import Foundation

struct day {
    
    var date : NSDate
    
    // arrays to hold all readings for one day
    var windspeedReadings = [Double]()
    var barometricPressureReadings = [Double]()
    var airTemperatureReadings = [Double]()
    
    init(intialDate: NSDate){
        self.date = intialDate
    }
}