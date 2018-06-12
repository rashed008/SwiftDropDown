//
//  Company.swift
//  companyNameDropDown
//
//  Created by Mominur Rahman on 6/6/18.
//  Copyright © 2018 metakave. All rights reserved.
//

import UIKit

class Company: NSObject {
    open var id:String?
    open var name:String?
    open var details:String?
    open var status:Int?
    
    
    init(id:String?, name:String?, details:String?, status:Int?) {
        self.id = id
        self.name = name
        self.details = details
        self.status = status
    }
    
}
