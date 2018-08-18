//
//  FirstViewController.swift
//  Units Converter
//
//  Created by Navoda Sathsarani on 8/11/18.
//  Copyright © 2018 sliit. All rights reserved.
//

import UIKit

class TemperatureViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var kelvinTextField: UITextField!
    @IBOutlet weak var fahrenheitTextField: UITextField!
    @IBOutlet weak var celciusTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        //delegates
        kelvinTextField.delegate = self
        fahrenheitTextField.delegate = self
        celciusTextField.delegate = self
        // add tap GestureRecognizer
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TemperatureViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        //add done button to keyboard
        self.addDoneButtonOnKeyboard()
        //set up text fileds for change event
        setUpTextFields()
 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Set up textFields for controll events{
    func setUpTextFields(){
        kelvinTextField.addTarget(self, action: #selector(kelvinTextFieldEditingDidChange), for: UIControlEvents.editingChanged)
        celciusTextField.addTarget(self, action: #selector(celciusTextFieldEditingDidChange), for: UIControlEvents.editingChanged)
        fahrenheitTextField.addTarget(self, action: #selector(fahrenheitTextFieldEditingDidChange), for: UIControlEvents.editingChanged)
        
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    //when tap return  key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    //add done button to keyboard
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(TemperatureViewController.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.kelvinTextField.inputAccessoryView = doneToolbar
        self.celciusTextField.inputAccessoryView = doneToolbar
        self.fahrenheitTextField.inputAccessoryView = doneToolbar
    }
  
    // animation for the view
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    //celsius Textfield editing change  event
    @objc private func celciusTextFieldEditingDidChange(_ textField: UITextField) {
        if textField.text != nil && textField.text != "" {
            let text =  textField.text
            let Doublevalue = Double("\(text!)")
            
            convertValue(Value: Doublevalue!, selectedType: TempTypes.Celcius.type())
        }
        else{
            clearFields()
        }
    }
    //fahrenheit Textfield editing change  event
    @objc private func fahrenheitTextFieldEditingDidChange(_ textField: UITextField) {
        if textField.text != nil && textField.text != "" {
            let text =  textField.text
            let Doublevalue = Double("\(text!)")
            
            convertValue(Value: Doublevalue!, selectedType: TempTypes.Fahrenheit.type())
        }
        else{
            clearFields()
        }
    }
    //kelvin Textfield editing change  event
    @objc private func kelvinTextFieldEditingDidChange(_ textField: UITextField) {
        if textField.text != nil && textField.text != "" {
            let text =  textField.text
            let Doublevalue = Double("\(text!)")
            
            convertValue(Value: Doublevalue!, selectedType: TempTypes.Kelvin.type())
        }
        else{
            clearFields()
        }
    }
   
    
    //unit convertion
    func convertValue(Value:Double,selectedType:String){
        var temps = TemperatureModel(kelvin: 0.00, celsius: 0.00, fahrenheit: 0.00)
        if(selectedType == TempTypes.Kelvin.type() ){
            temps.kelvin = Value
            temps = temps.convert(selectedUnitType:selectedType)
            celciusTextField.text = SetupDecimalPaces(temps.celsius)
            fahrenheitTextField.text = SetupDecimalPaces(temps.fahrenheit)
        }
        else if(selectedType == TempTypes.Celcius.type()  ){
            temps.celsius = Value
            temps = temps.convert(selectedUnitType:selectedType)
            kelvinTextField.text = SetupDecimalPaces(temps.kelvin)
            fahrenheitTextField.text = SetupDecimalPaces(temps.fahrenheit)
            
        }
        else {
            temps.fahrenheit = Value
            temps = temps.convert(selectedUnitType:selectedType)
            kelvinTextField.text = SetupDecimalPaces(temps.kelvin)
            celciusTextField.text = SetupDecimalPaces(temps.celsius)
        }
        
        
        
    }
    //only allow decimal numbers
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        // Allow Only Valid Decimal Numbers
        if let textFieldText = textField.text   {
            
            let finalText = (textFieldText as NSString).replacingCharacters(in: range, with: string)
            if Double(finalText) != nil {
                return true
            }
        }
        return false
    }
    
    //clear text fields
    func clearFields(){
        
        self.kelvinTextField.text = ""
        self.fahrenheitTextField.text = ""
        self.celciusTextField.text = ""
        
    }
    
    //when textfield begin editing clear textfield values
    func textFieldDidBeginEditing(_ textField: UITextField) {
        clearFields()
        if(UIDevice.current.modelName == "iPhone 5"   || UIDevice.current.modelName == "iPhone SE" || UIDevice.current.modelName == "iPhone 5s"){
            self.animateViewMoving(up: true, moveValue: 50)
        }
    }
    
    //when tap done button
    @objc func doneButtonAction() {
        self.celciusTextField.resignFirstResponder()
        self.kelvinTextField.resignFirstResponder()
        self.fahrenheitTextField.resignFirstResponder()
        
        
    }
    //if textfield value is large convert to e notation
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if textField.text != nil && textField.text != "" {
            let text =  textField.text
            let Doublevalue = Double("\(text!)")
            if(UIDevice.current.modelName == "iPhone 5"   || UIDevice.current.modelName == "iPhone SE" || UIDevice.current.modelName == "iPhone 5s"){
                if(!(Doublevalue?.isLessThanOrEqualTo(10000000))!){
                    textField.text = formatLargeNumbers(value: Doublevalue!)
                }
            }
            else {
                if(!(Doublevalue?.isLessThanOrEqualTo(10000000000))!){
                    textField.text = formatLargeNumbers(value: Doublevalue!)
                }
            }
            
        }
        if(UIDevice.current.modelName == "iPhone 5"   || UIDevice.current.modelName == "iPhone SE" || UIDevice.current.modelName == "iPhone 5s"){
            animateViewMoving(up: false, moveValue: 50)
        }
    }
}

