//
//  Extentions.swift
//  Units Converter
//
//  Created by Navoda Sathsarani on 8/18/18.
//  Copyright © 2018 sliit. All rights reserved.
//

import Foundation


public  func SetupDecimalPaces(_ numberToFormat:Double) -> String {
    let fmt = NumberFormatter()
    fmt.locale = Locale(identifier: "en_US_POSIX")
    fmt.maximumFractionDigits = 4
    fmt.minimumFractionDigits = 2
    let (wholePart, _) = modf(numberToFormat)
    if(!wholePart.isLessThanOrEqualTo(100000)){
    fmt.numberStyle = .scientific
    fmt.positiveFormat = "0.###E+0"
    fmt.exponentSymbol = "e"
 
    }
    return (fmt.string(for: numberToFormat))!
}

public func formatLargeNumbers(value:Double) -> String {
    
    let fmt = NumberFormatter()
    fmt.numberStyle = .scientific
    fmt.positiveFormat = "0.###E+0"
    fmt.exponentSymbol = "e"

    return (fmt.string(for: value))!
}
