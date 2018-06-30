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
    
    @IBOutlet weak var tfCompanyName: UITextField!
    
    fileprivate let CLASS_NAME:String = "ViewController"
    private var companyList:[Company] = [Company]()
    fileprivate var dropDown = DropDown()
    fileprivate var selectedCompanyId:String?
    fileprivate var isCompanyListLoaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       //getCompanyList(text: "")
    }
    
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
                         self.populateCompanyListToDropdown()

                        //set company list loaded to true
                         self.isCompanyListLoaded = true
                    }else{
                        //   SnackBarManager.showSnackBar(message: "Company not found")
                    }
                }else{
                    //                    SnackBarManager.showSnackBar(message:                swiftyJson["message"].stringValue)
                }

                //hide progrees dialog
                // SVProgressHUD.dismiss()

                //   print(self.CLASS_NAME+" -- getCompanyList()  -- response -- "+(String(describing: response)))

        }
    }
    

    //Press onKeyPressCompanyField to see the comapny dropDown
    @IBAction func onKeyPressCompanyField(_ sender: UITextField) {

        let text = tfCompanyName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if text.count > 2 {
            getCompanyList(text: text)
        }
        if text.count < 1 {
            self.companyList.removeAll()
        }
        //populate company list to dropdown
        if isCompanyListLoaded {
            populateCompanyListToDropdown()
        } else {
            print("Comapny not found")
        }
        
    }
    
    //populate company list to dropdown
    private func populateCompanyListToDropdown() -> Void {
        var companyListForDropdown:[Company] = [Company]()
        var comapnayNameListForDropdown:[String] = [String]()
        
        for i in 0 ..< companyList.count {
            companyListForDropdown.append(companyList[i])
            comapnayNameListForDropdown.append(companyList[i].name!)
        }
        
        // The list of items to display. Can be changed dynamically
        if comapnayNameListForDropdown.count > 0 {
            self.dropDown.dataSource = comapnayNameListForDropdown
            //Action triggered on selection
            self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                self.tfCompanyName.text = item
                self.selectedCompanyId = companyListForDropdown[index].id
                self.dropDown.hide()
            }
            self.dropDown.show()
        }
  
    }
}

/**
 Alamofire.request(
 URL(string:"string goes here")!,
 method: .get,
 parameter: ["plateform" : "mobile"] )
 .responseJSON { (response) -> Void in
 **/


