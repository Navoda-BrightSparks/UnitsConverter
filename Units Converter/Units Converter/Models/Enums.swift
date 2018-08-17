//
//  Enums.swift
//  Units Converter
//
//  Created by Navoda Sathsarani on 8/15/18.
//  Copyright © 2018 sliit. All rights reserved.
//

import Foundation

enum WeightTypes :String {
    case Gram, Kilogram ,Ounce ,Pound
    
    func type()->String{
        return self.rawValue
        
    }
}
