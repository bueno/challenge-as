//
//  RegistrationViewController.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/23/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import  Eureka

class RegistrationViewController : FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeForm()
    }
    
    private func initializeForm() {
        form
            
            +++ Section("Personal")
            
            <<< TextRow(){
                $0.title = "Name"
                $0.placeholder = "Enter your name here"
            }
            <<< DateRow(){
                $0.title = "Date of Birth"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
            }
            <<< PhoneRow(){
                $0.title = "Phone"
                $0.placeholder = "Enter your phone here"
            }
            <<< EmailRow() {
                $0.title = "Email"
            }
            
            
            +++ Section("Address")
            
            <<< TextRow(){
                $0.title = "Address"
                $0.placeholder = "Enter your address here"
            }
            
            <<< PushRow<String>("countries") {
                $0.title = "Country"
                $0.options = ["Brazil", "USA"]
                $0.selectorTitle = "Select a Country"
                $0.value = "Select a Country"
                }.onPresent { from, to in
                    to.dismissOnSelection = true
                    to.dismissOnChange = true
            }
            <<< PushRow<String>("states") {
                $0.title = "State"
                $0.options = ["São Paulo", "Rio de Janeiro", "Minas Gerais"]
                $0.selectorTitle = "Select a State"
                $0.value = "Select a State"
                $0.disabled = "$countries = 'Select a Country'"
                }.onPresent { from, to in
                    to.dismissOnSelection = true
                    to.dismissOnChange = true
            }
            <<< PushRow<String>() {
                $0.title = "City"
                $0.options = ["São Paulo", "Santos", "Araraquara"]
                $0.selectorTitle = "Select a City"
                $0.value = "Select a City"
                $0.disabled = "$states = 'Select a State'"
                }.onPresent { from, to in
                    to.dismissOnSelection = true
                    to.dismissOnChange = true
            }
        
            
            +++ Section()
            
            <<< SwitchRow("Joint Account"){
                $0.title = $0.tag
            }
            <<< TextRow(){
                $0.title = "Spouse Name"
                $0.placeholder = "Enter the name of your spouse"
                $0.hidden = .function(["Joint Account"], { form -> Bool in
                    let row: RowOf<Bool>! = form.rowBy(tag: "Joint Account")
                    return row.value ?? false == false
                })
            }
            <<< DateRow(){
                $0.title = "Spouse Date of Birth"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
                $0.hidden = .function(["Joint Account"], { form -> Bool in
                    let row: RowOf<Bool>! = form.rowBy(tag: "Joint Account")
                    return row.value ?? false == false
                })
            }
    }
}
