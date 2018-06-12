//
//  ViewController.swift
//  companyNameDropDown
//
//  Created by Mominur Rahman on 6/6/18.
//  Copyright © 2018 metakave. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import DropDown

class ViewController: UIViewController {
    
    
    fileprivate let CLASS_NAME:String = "ViewController"
    private var companyList:[Company] = [Company]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getCompanyList(text: "")
    }
    
    
//    private func getCompanyList(text:String) -> Void {
//
//       Alamofire.request( 
//            URL(string: "http://app.thesmartclubapp.com/api/companies")!,
//            method: .get,
//            parameters: ["platform": "mobile","search":text, "status":"active","approve": "true"])
//
//            .responseJSON { (response) -> Void in
//
//                let swiftyJson = JSON(response.data!)
//                if swiftyJson["success"].intValue == 1{
//
//                    //parse json data
//                    if(swiftyJson["data"].arrayValue.count > 0) {
//                        for i in 0 ..< swiftyJson["data"].arrayValue.count {
//                            let id = swiftyJson["data"][i]["id"].string
//                            let name = swiftyJson["data"][i]["name"].string
//                            let details = swiftyJson["data"][i]["details"].string
//                            let status = swiftyJson["data"][i]["status"].int
//
//                            self.companyList.append(Company(id:id, name:name, details: details, status: status))
//
//                            print(self.CLASS_NAME+" -- getCompanyList()  -- company  name -- "+(self.companyList[i].name!))
//                        }
//                    }
//                }
//
//        }
//
//    }
    
    
    
    
        private func getCompanyList(text:String) -> Void {
            //show progressbar
           // SVProgressHUD.show()
    
            Alamofire.request(
                URL(string: "http://app.thesmartclubapp.com/api/companies")!,
                method: .get,
                parameters: ["platform": "mobile"])
    
                .responseJSON { (response) -> Void in
    
                    //go to  login view controller
                    let swiftyJson = JSON(response.data!)
                    if  swiftyJson["success"].intValue == 1{
                        self.companyList.removeAll()
                        //                    SnackBarManager.showSnackBar(message: swiftyJson["message"].stringValue)
    
                        //                     print(self.CLASS_NAME+" -- getCompanyList()  -- response -- "+(String(describing: response)))
    
                        //parse json data
                        if(swiftyJson["data"].arrayValue.count > 0){
                            for i in 0 ..< swiftyJson["data"].arrayValue.count {
                                let id = swiftyJson["data"][i]["id"].string
                                let name = swiftyJson["data"][i]["name"].string
                                let details = swiftyJson["data"][i]["details"].string
                                let status = swiftyJson["data"][i]["status"].int
                                print("company_id - \(id)")
                                print("company_name - \(name)")
                                
                                self.companyList.append(Company(id:id, name:name, details:details, status:status))
                                
                               
                                print(self.CLASS_NAME+" -- getCompanyList()  -- company  name -- "+(self.companyList[i].name!))
                                
                            }
    
                            //populate dropdown
                          //  self.populateCompanyListToDropdown()
    
                            //set company list loaded to true
                        //    self.isCompanyListLoaded = true
                        }else{
                         //   SnackBarManager.showSnackBar(message: "Company not found")
                        }
                    }else{
                        //                    SnackBarManager.showSnackBar(message: swiftyJson["message"].stringValue)
                    }
    
                    //hide progrees dialog
                   // SVProgressHUD.dismiss()
    
                 //   print(self.CLASS_NAME+" -- getCompanyList()  -- response -- "+(String(describing: response)))
    
            }
        }
    
    
    
    
    
    
}


