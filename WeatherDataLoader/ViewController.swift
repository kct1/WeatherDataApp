//
//  ViewController.swift
//  WeatherDataLoader
//
//  Created by Kyle Tuczynski on 5/26/15.
//  Copyright (c) 2015 Kyle Tuczynski. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBAction func SavaData(sender: AnyObject) {
        // read a text file into the app
        
        // break apart into individual readings (lines)
        
        // go through all readings - collect windspeed, temp and pressure numbers for each day
        
        // calculate mean and median 
        
        // format and save as a cloudkit record
        
    }
    
    func collapseToSingleDays(year : String) -> [day] {
        // Create array to hold 365 Day Structures
        var daysArray = [day]()
        
        // Get file path to one text file
        let path = NSBundle.mainBundle().pathForResource(year, ofType: "txt")
        
        // Read the text file into a string
        let fulltext = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)
        
        // Break into an array of individual readings
        let readings = fulltext?.componentsSeparatedByString("\n") as [String]!
        
        // Create and configure a date formatter to convert from string to NSDate
            let formatter = NSDateFormatter()
            formatter.timeZone = NSTimeZone(abbreviation: "PST")
            formatter.dateFormat = "yyyy_MM_dd"

        
        // Go through the array of readings
        for i in 1..<readings.count {
            //create a new array from each reading (each line), breaking apart by tab
            let weatherData = readings[i].componentsSeparatedByString("\t")
            
            // The first element is a date + time string
            let dateTime = weatherData[0]
            
            // Strip down to just the first 10 characters (the date)
            var justDate = dateTime.substringToIndex(advance(dateTime.startIndex, 10))
            
            // Convert from string to NSDate
            let dateofCurrentReading = formatter.dateFromString(justDate)
            
            // Get weather values, convert from strings to doubles 
            let temperatureValue = NSNumberFormatter(). numberFromString(weatherData[1])!.doubleValue
            let pressureValue = NSNumberFormatter().numberFromString(weatherData[2])!.doubleValue
            let windValue = NSNumberFormatter().numberFromString(weatherData[7])!.doubleValue
            
            // check array of Days - if empty, OT the most recent Day
            //is different from the current reading, create a new Day struct 
            if daysArray.count == 0 || (daysArray[daysArray.count - 1].date != dateofCurrentReading) {
                // create a new Day struct and add to the array
                let newDay = day(intialDate: dateofCurrentReading!)
                daysArray.append(newDay)
        
            }
            
            // add current readings to the most recent "day"
            daysArray[daysArray.count - 1].barometricPressureReadings.append(pressureValue)
            daysArray[daysArray.count - 1].windspeedReadings.append(windValue)
            daysArray[daysArray.count - 1].airTemperatureReadings.append(temperatureValue)
            
        }
        
        return daysArray
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

