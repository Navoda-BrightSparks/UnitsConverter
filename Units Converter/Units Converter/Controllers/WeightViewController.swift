//
//  WeightViewController.swift
//  Units Converter
//
//  Created by Navoda Sathsarani on 8/11/18.
//  Copyright © 2018 sliit. All rights reserved.
//

import UIKit

class WeightViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var gramTextField: UITextField!
    
    @IBOutlet weak var kgTextField: UITextField!
    
    @IBOutlet weak var poundTextField: UITextField!
    
    @IBOutlet weak var ounceTextField: UITextField!
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    override func viewDidLoad() {
        super.viewDidLoad()
        //delegates
        gramTextField.delegate = self
        kgTextField.delegate = self
        poundTextField.delegate = self
        ounceTextField.delegate = self
        
        // add tap GestureRecognizer
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(WeightViewController.dismissKeyboard))
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
        gramTextField.addTarget(self, action: #selector(gramTextFieldEditingDidChange), for: UIControlEvents.editingChanged)
        kgTextField.addTarget(self, action: #selector(kgTextFieldEditingDidChange), for: UIControlEvents.editingChanged)
        ounceTextField.addTarget(self, action: #selector(ounceTextFieldEditingDidChange), for: UIControlEvents.editingChanged)
        poundTextField.addTarget(self, action: #selector(poundTextFieldEditingDidChange), for: UIControlEvents.editingChanged)
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
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(WeightViewController.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        self.gramTextField.inputAccessoryView = doneToolbar
        self.kgTextField.inputAccessoryView = doneToolbar
        self.poundTextField.inputAccessoryView = doneToolbar
        self.ounceTextField.inputAccessoryView = doneToolbar
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
    @objc private func gramTextFieldEditingDidChange(_ textField: UITextField) {
        if textField.text != nil && textField.text != "" {
            let text =  textField.text
            let Doublevalue = Double("\(text!)")
            
            convertValue(Value: Doublevalue!, selectedType: WeightTypes.Gram.type())
        }
        else{
            clearFields()
        }
    }
    //kilo Textfield editing change  event
    @objc private func kgTextFieldEditingDidChange(_ textField: UITextField) {
        if textField.text != nil && textField.text != "" {
            let text =  textField.text
            let Doublevalue = Double("\(text!)")
            
            convertValue(Value: Doublevalue!, selectedType: WeightTypes.Kilogram.type())
        }
        else{
            clearFields()
        }
    }
    //ounce Textfield editing change  event
    @objc private func ounceTextFieldEditingDidChange(_ textField: UITextField) {
        if textField.text != nil && textField.text != "" {
            let text =  textField.text
            let Doublevalue = Double("\(text!)")
            
            convertValue(Value: Doublevalue!, selectedType: WeightTypes.Ounce.type())
        }
        else{
            clearFields()
        }
    }
    //pound Textfield editing change  event
    @objc private func poundTextFieldEditingDidChange(_ textField: UITextField) {
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
            kgTextField.text = SetupDecimalPaces(weights.kilogram)
            ounceTextField.text = SetupDecimalPaces(weights.ounce)
            gramTextField.text = SetupDecimalPaces(weights.gram)
            
        }
        else if(selectedType == WeightTypes.Ounce.type() ){
            weights.ounce = Value
            weights = weights.convert(selectedUnitType:selectedType)
            kgTextField.text = SetupDecimalPaces(weights.kilogram)
            gramTextField.text = SetupDecimalPaces(weights.gram)
            poundTextField.text = SetupDecimalPaces(weights.pound)
            
        }
        else  if(selectedType == WeightTypes.Gram.type() ){
            weights.gram = Value
            weights = weights.convert(selectedUnitType:selectedType)
            kgTextField.text = SetupDecimalPaces(weights.kilogram)
            ounceTextField.text = SetupDecimalPaces(weights.ounce)
            poundTextField.text = SetupDecimalPaces(weights.pound)
            
        }
        else{
            weights.kilogram = Value
            weights = weights.convert(selectedUnitType:selectedType)
            ounceTextField.text = SetupDecimalPaces(weights.ounce)
            gramTextField.text = SetupDecimalPaces(weights.gram)
            poundTextField.text = SetupDecimalPaces(weights.pound)
        }
        
        
    }
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
        
        self.gramTextField.text = ""
        self.kgTextField.text = ""
        self.poundTextField.text = ""
        self.ounceTextField.text = ""
    }
    
    //when textfield begin editing clear textfield values
    func textFieldDidBeginEditing(_ textField: UITextField) {
        clearFields()
        if(UIDevice.current.modelName == "iPhone 5"   || UIDevice.current.modelName == "iPhone SE" || UIDevice.current.modelName == "iPhone 5s"){
            self.animateViewMoving(up: true, moveValue: 50)
        }
    }
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
            else{
                
                textField.text = ""
            }
        
        
        }
       
    
    //when tap done button
    @objc func doneButtonAction() {
        self.gramTextField.resignFirstResponder()
        self.kgTextField.resignFirstResponder()
        self.poundTextField.resignFirstResponder()
        self.ounceTextField.resignFirstResponder()
        
    }
    
}

