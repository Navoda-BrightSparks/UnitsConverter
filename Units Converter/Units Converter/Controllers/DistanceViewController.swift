//
//  DistanceViewController.swift
//  Units Converter
//
//  Created by Navoda Sathsarani on 8/12/18.
//  Copyright © 2018 sliit. All rights reserved.
//

import UIKit

class DistanceViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var metreTextField: UITextField!
    
    @IBOutlet weak var kiloMetreTextField: UITextField!
    @IBOutlet weak var yardTextField: UITextField!
    
    @IBOutlet weak var mileTextField: UITextField!
    @IBOutlet weak var footTextField: UITextField!
    @IBOutlet weak var distanceView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //delegates
        metreTextField.delegate = self
        kiloMetreTextField.delegate = self
        mileTextField.delegate = self
        footTextField.delegate = self
        yardTextField.delegate = self
        // add tap GestureRecognizer
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DistanceViewController.dismissKeyboard))
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
        metreTextField.addTarget(self, action: #selector(metreTextFieldEditingDidChange), for: UIControlEvents.editingChanged)
        kiloMetreTextField.addTarget(self, action: #selector(kiloMetreTextFieldEditingDidChange), for: UIControlEvents.editingChanged)
        footTextField.addTarget(self, action: #selector(footTextFieldEditingDidChange), for: UIControlEvents.editingChanged)
        mileTextField.addTarget(self, action: #selector(mileTextFieldEditingDidChange), for: UIControlEvents.editingChanged)
        yardTextField.addTarget(self, action: #selector(yardTextFieldEditingDidChange), for: UIControlEvents.editingChanged)
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
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(DistanceViewController.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.metreTextField.inputAccessoryView = doneToolbar
        self.kiloMetreTextField.inputAccessoryView = doneToolbar
        self.mileTextField.inputAccessoryView = doneToolbar
        self.footTextField.inputAccessoryView = doneToolbar
        self.yardTextField.inputAccessoryView = doneToolbar
        
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
    //metre Textfield editing change  event
    @objc private func metreTextFieldEditingDidChange(_ textField: UITextField) {
        if textField.text != nil && textField.text != "" {
            let text =  textField.text
            let Doublevalue = Double("\(text!)")
            
            convertValue(Value: Doublevalue!, selectedType: DistanceTypes.metre.type())
        }
        else{
            clearFields()
        }
    }
    //yard Textfield editing change  event
    @objc private func yardTextFieldEditingDidChange(_ textField: UITextField) {
        if textField.text != nil && textField.text != "" {
            let text =  textField.text
            let Doublevalue = Double("\(text!)")
            
            convertValue(Value: Doublevalue!, selectedType: DistanceTypes.yard.type())
        }
        else{
            clearFields()
        }
    }
    //kilometre Textfield editing change  event
    @objc private func kiloMetreTextFieldEditingDidChange(_ textField: UITextField) {
        if textField.text != nil && textField.text != "" {
            let text =  textField.text
            let Doublevalue = Double("\(text!)")
            
            convertValue(Value: Doublevalue!, selectedType: DistanceTypes.kilometre.type())
        }
        else{
            clearFields()
        }
    }
    //foot Textfield editing change  event
    @objc private func footTextFieldEditingDidChange(_ textField: UITextField) {
        if textField.text != nil && textField.text != "" {
            let text =  textField.text
            let Doublevalue = Double("\(text!)")
            
            convertValue(Value: Doublevalue!, selectedType: DistanceTypes.foot.type())
        }
        else{
            clearFields()
        }
    }
    //mile Textfield editing change  event
    @objc private func mileTextFieldEditingDidChange(_ textField: UITextField) {
        if textField.text != nil && textField.text != "" {
            let text =  textField.text
            let Doublevalue = Double("\(text!)")
            
            convertValue(Value: Doublevalue!, selectedType: DistanceTypes.mile.type())
        }
        else{
            clearFields()
        }
    }
    //unit convertion
    func convertValue(Value:Double,selectedType:String){
        var distances = DistanceModel(metre: 0.00, foot: 0.00, yard: 0.00, kilometre: 0.00, mile: 0.00)
        if(selectedType == DistanceTypes.metre.type() ){
            distances.metre = Value
            distances = distances.convert(selectedUnitType:selectedType)
            kiloMetreTextField.text = SetupDecimalPaces(distances.kilometre)
            footTextField.text = SetupDecimalPaces(distances.foot)
            yardTextField.text = SetupDecimalPaces(distances.yard)
            mileTextField.text = SetupDecimalPaces(distances.mile)
        }
        else if(selectedType == DistanceTypes.mile.type()  ){
            distances.mile = Value
            distances = distances.convert(selectedUnitType:selectedType)
            kiloMetreTextField.text = SetupDecimalPaces(distances.kilometre)
            metreTextField.text = SetupDecimalPaces(distances.metre)
            footTextField.text = SetupDecimalPaces(distances.foot)
            yardTextField.text = SetupDecimalPaces(distances.yard)
        }
        else  if(selectedType == DistanceTypes.yard.type() ){
            distances.yard = Value
            distances = distances.convert(selectedUnitType:selectedType)
            kiloMetreTextField.text = SetupDecimalPaces(distances.kilometre)
            footTextField.text = SetupDecimalPaces(distances.foot)
            mileTextField.text = SetupDecimalPaces(distances.mile)
            metreTextField.text = SetupDecimalPaces(distances.metre)
        }
        else  if(selectedType == DistanceTypes.foot.type() ){
            distances.foot = Value
            distances = distances.convert(selectedUnitType:selectedType)
            kiloMetreTextField.text = SetupDecimalPaces(distances.kilometre)
            yardTextField.text = SetupDecimalPaces(distances.yard)
            mileTextField.text = SetupDecimalPaces(distances.mile)
            metreTextField.text = SetupDecimalPaces(distances.metre)
        }
        else{
            distances.kilometre = Value
            distances = distances.convert(selectedUnitType:selectedType)
            footTextField.text = SetupDecimalPaces(distances.foot)
            metreTextField.text = SetupDecimalPaces(distances.metre)
            mileTextField.text = SetupDecimalPaces(distances.mile)
            yardTextField.text = SetupDecimalPaces(distances.yard)
        
        }
    }
    //clear text fields
    func clearFields(){
        
        self.metreTextField.text = ""
        self.kiloMetreTextField.text = ""
        self.mileTextField.text = ""
        self.footTextField.text = ""
        self.yardTextField.text = ""
    }
    
    //when textfield begin editing clear textfield values
    func textFieldDidBeginEditing(_ textField: UITextField) {
        clearFields()
        if(UIDevice.current.modelName == "iPhone 5"   || UIDevice.current.modelName == "iPhone SE" || UIDevice.current.modelName == "iPhone 5s"){
            self.animateViewMoving(up: true, moveValue: 120)
        }
        else if(UIDevice.current.modelName == "iPhone 6" || UIDevice.current.modelName ==  "iPhone 6s"){
            
              self.animateViewMoving(up: true, moveValue: 50)
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
    //when tap done button
    @objc func doneButtonAction() {
        self.metreTextField.resignFirstResponder()
        self.kiloMetreTextField.resignFirstResponder()
        self.mileTextField.resignFirstResponder()
        self.footTextField.resignFirstResponder()
        
    }
    
    //if textfield value is large convert to e notation
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
       
        if(UIDevice.current.modelName == "iPhone 5"   || UIDevice.current.modelName == "iPhone SE" || UIDevice.current.modelName == "iPhone 5s"){
            animateViewMoving(up: false, moveValue: 120)
        }
        else if(UIDevice.current.modelName == "iPhone 6" || UIDevice.current.modelName ==  "iPhone 6s"){
            
            self.animateViewMoving(up: false, moveValue: 50)
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
}
