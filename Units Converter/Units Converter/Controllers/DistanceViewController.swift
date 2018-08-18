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
        
        
    }
    
    //metre Textfield editing change  event
    @objc private func metreTextFieldEditingDidChange(_ textField: UITextField) {
        if textField.text != nil && textField.text != "" {
            let text =  textField.text
            let Doublevalue = Double("\(text!)")
            
            convertValue(Value: Doublevalue!, selectedType: WeightTypes.Gram.type())
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
            
            convertValue(Value: Doublevalue!, selectedType: WeightTypes.Gram.type())
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
            
            convertValue(Value: Doublevalue!, selectedType: WeightTypes.Kilogram.type())
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
            
            convertValue(Value: Doublevalue!, selectedType: WeightTypes.Ounce.type())
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
            
            convertValue(Value: Doublevalue!, selectedType: WeightTypes.Pound.type())
        }
        else{
            clearFields()
        }
    }
    //unit convertion
    func convertValue(Value:Double,selectedType:String){
        var weights = WeightModel(gram: 0.0, kilogram: 0.0, ounce: 0.0, pound: 0.0)
        if(selectedType == WeightTypes.Pound.type() ){
            weights.pound = Value
            weights = weights.convert(selectedUnitType:selectedType)
            kiloMetreTextField.text = SetupDecimalPaces(weights.kilogram)
            footTextField.text = SetupDecimalPaces(weights.ounce)
            metreTextField.text = SetupDecimalPaces(weights.gram)
            
        }
        else if(selectedType == WeightTypes.Ounce.type() ){
            weights.ounce = Value
            weights = weights.convert(selectedUnitType:selectedType)
            kiloMetreTextField.text = SetupDecimalPaces(weights.kilogram)
            metreTextField.text = SetupDecimalPaces(weights.gram)
            mileTextField.text = SetupDecimalPaces(weights.pound)
            
        }
        else  if(selectedType == WeightTypes.Gram.type() ){
            weights.gram = Value
            weights = weights.convert(selectedUnitType:selectedType)
            kiloMetreTextField.text = SetupDecimalPaces(weights.kilogram)
            footTextField.text = SetupDecimalPaces(weights.ounce)
            mileTextField.text = SetupDecimalPaces(weights.pound)
            
        }
        else{
            weights.kilogram = Value
            weights = weights.convert(selectedUnitType:selectedType)
            footTextField.text = SetupDecimalPaces(weights.ounce)
            metreTextField.text = SetupDecimalPaces(weights.gram)
            mileTextField.text = SetupDecimalPaces(weights.pound)
        }
        
        
    }
    //clear text fields
    func clearFields(){
        
        self.metreTextField.text = ""
        self.kiloMetreTextField.text = ""
        self.mileTextField.text = ""
        self.footTextField.text = ""
    }
    
    //when textfield begin editing clear textfield values
    func textFieldDidBeginEditing(_ textField: UITextField) {
        clearFields()
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
        if textField.text != nil && textField.text != "" {
            let text =  textField.text
            let Doublevalue = Double("\(text!)")
            if(!(Doublevalue?.isLessThanOrEqualTo(10000000))!){
                
                
                textField.text = formatLargeNumbers(value: Doublevalue!)
            }
            
        }
        
    }
}
