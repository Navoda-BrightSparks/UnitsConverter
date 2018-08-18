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
class TemperatureModel{
    
    var kelvin:Double
    var celsius:Double
    var fahrenheit:Double
    
    
    init(kelvin: Double,celsius:Double,fahrenheit:Double) {
        
        self.kelvin = kelvin
        self.fahrenheit = fahrenheit
        self.celsius = celsius
      
    }
    
    func convert(selectedUnitType:String) -> TemperatureModel {
        
        if(selectedUnitType == TempTypes.Kelvin.type()){
            let temp = self.kelvin
            self.celsius = temp - (-273.15)
            self.fahrenheit = (temp * ( 9/5) ) - 459.67
           
        }
        else if(selectedUnitType == TempTypes.Fahrenheit.type()){
            let temp = self.fahrenheit
            self.celsius = (temp - 32 ) / (9/5)
            self.kelvin = (temp  +  459.67) * 5/9
          
        }
        else {
            let temp = self.celsius
            self.fahrenheit = (temp * (9/5)) + 32
            self.kelvin = temp + 273.15
          
        }
    
        return self
        
    }
}
class SpeedModel{
    
    var milePerHour:Double
    var kiloPerHour:Double
    var feetPerMin:Double
    var metrePerSec:Double
  
    init(metrePerSec: Double,kiloPerHour:Double,feetPerMin:Double,milePerHour:Double) {
        
        self.metrePerSec = metrePerSec
        self.kiloPerHour = kiloPerHour
        self.feetPerMin = feetPerMin
        self.milePerHour = milePerHour
    }
    
    func convert(selectedUnitType:String) -> SpeedModel {
        
        if(selectedUnitType == SpeedTypes.metrePerSec.type()){
            let speed = self.metrePerSec
            self.kiloPerHour = speed  * 3.6
            self.feetPerMin = speed  * 196.8503937008
            self.milePerHour = speed  * 2.2369362921
        }
        else if(selectedUnitType == SpeedTypes.kiloPerHour.type()){
            let speed = self.kiloPerHour
            self.metrePerSec = speed * 0.2777777778
            self.milePerHour = speed * 0.6213711922
            self.feetPerMin = speed  * 54.6806649169
        }
        else if(selectedUnitType == SpeedTypes.feetPerMin.type()){
            let speed = self.feetPerMin
            self.metrePerSec = speed *  0.00508
            self.milePerHour = speed * 0.0113636364
            self.kiloPerHour = speed  * 0.018288
        }
        else{
            let speed = self.milePerHour
            self.kiloPerHour = speed * 1.609344
            self.metrePerSec = speed *  0.44704
            self.feetPerMin = speed * 88
            
        }
        return self
        
    }
}
