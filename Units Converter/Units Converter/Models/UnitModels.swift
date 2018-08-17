//
//  UnitModels.swift
//  Units Converter
//
//  Created by Navoda Sathsarani on 8/12/18.
//  Copyright © 2018 sliit. All rights reserved.
//

import Foundation

class WeightModel{
    
    var gram:Double
    var kilogram:Double
    var ounce:Double
    var pound:Double
    
    init(gram: Double,kilogram:Double,ounce:Double,pound:Double) {
    
        self.gram = gram
        self.kilogram = kilogram
        self.ounce = ounce
        self.pound = pound
    }
    
    func convert(selectedUnitType:String) -> WeightModel {
        
        if(selectedUnitType == WeightTypes.Gram.type()){
            let weight = self.gram
            self.kilogram = weight / 1000
            self.ounce = weight / 28.34952
            self.pound = weight / 453.59237
        }
        else if(selectedUnitType == WeightTypes.Kilogram.type()){
            let weight = self.kilogram
            self.gram = weight * 1000
            self.ounce = weight / 0.02834952
            self.pound = weight / 0.45359237
        }
        else if(selectedUnitType == WeightTypes.Ounce.type()){
            let weight = self.ounce
            self.gram = weight *  28.34952
            self.kilogram = weight * 0.02834952
            self.pound = weight / 16
        }
        else{
            let weight = self.pound
            self.gram = weight * 453.59237
            self.kilogram = weight * 0.45359237
            self.ounce = weight * 16
            
        }
        return self
        
    }
}
