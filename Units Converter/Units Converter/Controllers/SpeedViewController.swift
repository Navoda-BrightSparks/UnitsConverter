//
//  SpeedViewController.swift
//  Units Converter
//
//  Created by Navoda Sathsarani on 8/12/18.
//  Copyright © 2018 sliit. All rights reserved.
//

import UIKit

class SpeedViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var milesPerHourTextField: UITextField!
    @IBOutlet weak var kiloPHourTextField: UITextField!
    @IBOutlet weak var feetPMinTextField: UITextField!
    @IBOutlet weak var metrePerSecTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        //delegates
        milesPerHourTextField.delegate = self
        kiloPHourTextField.delegate = self
        feetPMinTextField.delegate = self
        metrePerSecTextField.delegate = self
        // add tap GestureRecognizer
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SpeedViewController.dismissKeyboard))
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
        milesPerHourTextField.addTarget(self, action: #selector(milesPerHourTextFieldEditingDidChange), for: UIControlEvents.editingChanged)
        kiloPHourTextField.addTarget(self, action: #selector(kiloPHourTextFieldEditingDidChange), for: UIControlEvents.editingChanged)
        feetPMinTextField.addTarget(self, action: #selector(feetPMinTextFieldEditingDidChange), for: UIControlEvents.editingChanged)
        metrePerSecTextField.addTarget(self, action: #selector(metrePerSecTextFieldEditingDidChange), for: UIControlEvents.editingChanged)
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
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(SpeedViewController.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.milesPerHourTextField.inputAccessoryView = doneToolbar
        self.kiloPHourTextField.inputAccessoryView = doneToolbar
        self.metrePerSecTextField.inputAccessoryView = doneToolbar
        self.feetPMinTextField.inputAccessoryView = doneToolbar
        
        
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
    //gram Textfield editing change  event
    @objc private func milesPerHourTextFieldEditingDidChange(_ textField: UITextField) {
        if textField.text != nil && textField.text != "" {
            let text =  textField.text
            let Doublevalue = Double("\(text!)")
            
            convertValue(Value: Doublevalue!, selectedType: SpeedTypes.milePerHour.type())
        }
        else{
            clearFields()
        }
    }
    //kilo Textfield editing change  event
    @objc private func kiloPHourTextFieldEditingDidChange(_ textField: UITextField) {
        if textField.text != nil && textField.text != "" {
            let text =  textField.text
            let Doublevalue = Double("\(text!)")
            
            convertValue(Value: Doublevalue!, selectedType: SpeedTypes.kiloPerHour.type())
        }
        else{
            clearFields()
        }
    }
    //ounce Textfield editing change  event
    @objc private func feetPMinTextFieldEditingDidChange(_ textField: UITextField) {
        if textField.text != nil && textField.text != "" {
            let text =  textField.text
            let Doublevalue = Double("\(text!)")
            
            convertValue(Value: Doublevalue!, selectedType: SpeedTypes.feetPerMin.type())
        }
        else{
            clearFields()
        }
    }
    //pound Textfield editing change  event
    @objc private func metrePerSecTextFieldEditingDidChange(_ textField: UITextField) {
        if textField.text != nil && textField.text != "" {
            let text =  textField.text
            let Doublevalue = Double("\(text!)")
            
            convertValue(Value: Doublevalue!, selectedType:SpeedTypes.metrePerSec.type())
        }
        else{
            clearFields()
        }
    }
    //unit convertion
    func convertValue(Value:Double,selectedType:String){
        var speeds = SpeedModel(metrePerSec: 0.00, kiloPerHour: 0.00, feetPerMin: 0.00, milePerHour: 0.00)
        if(selectedType == SpeedTypes.feetPerMin.type() ){
            speeds.feetPerMin = Value
            speeds = speeds.convert(selectedUnitType:selectedType)
            kiloPHourTextField.text = SetupDecimalPaces(speeds.kiloPerHour)
            metrePerSecTextField.text = SetupDecimalPaces(speeds.metrePerSec)
            milesPerHourTextField.text = SetupDecimalPaces(speeds.milePerHour)
            
        }
        else if(selectedType == SpeedTypes.metrePerSec.type()  ){
            speeds.metrePerSec = Value
            speeds = speeds.convert(selectedUnitType:selectedType)
            kiloPHourTextField.text = SetupDecimalPaces(speeds.kiloPerHour)
            milesPerHourTextField.text = SetupDecimalPaces(speeds.milePerHour)
            feetPMinTextField.text = SetupDecimalPaces(speeds.feetPerMin)
            
        }
        else  if(selectedType == SpeedTypes.kiloPerHour.type()  ){
            speeds.kiloPerHour = Value
            speeds = speeds.convert(selectedUnitType:selectedType)
            milesPerHourTextField.text = SetupDecimalPaces(speeds.milePerHour)
            feetPMinTextField.text = SetupDecimalPaces(speeds.feetPerMin)
            metrePerSecTextField.text = SetupDecimalPaces(speeds.metrePerSec)
            
        }
        else{
            speeds.milePerHour = Value
            speeds = speeds.convert(selectedUnitType:selectedType)
            feetPMinTextField.text = SetupDecimalPaces(speeds.feetPerMin)
            kiloPHourTextField.text = SetupDecimalPaces(speeds.kiloPerHour)
            metrePerSecTextField.text = SetupDecimalPaces(speeds.metrePerSec)
        }
        
        
    }
    //clear text fields
    func clearFields(){
        
        self.milesPerHourTextField.text = ""
        self.kiloPHourTextField.text = ""
        self.metrePerSecTextField.text = ""
        self.feetPMinTextField.text = ""
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
        self.milesPerHourTextField.resignFirstResponder()
        self.kiloPHourTextField.resignFirstResponder()
        self.metrePerSecTextField.resignFirstResponder()
        self.feetPMinTextField.resignFirstResponder()
        
    }
    //if textfield value is large convert to e notation
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
        if(UIDevice.current.modelName == "iPhone 5"   || UIDevice.current.modelName == "iPhone SE" || UIDevice.current.modelName == "iPhone 5s"){
            animateViewMoving(up: false, moveValue: 50)
        }
        
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
}
