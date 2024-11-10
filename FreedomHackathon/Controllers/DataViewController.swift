//
//  DataViewController.swift
//  FreedomHackathon
//
//  Created by Alikhan Kopzhanov on 10.11.2024.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON

class DataViewController: UIViewController {
    
    var spec = ""
    var prompt = ""
    var CVarray: [CV] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()

        // Do any additional setup after loading the view.
    }
    

    func getData() {
        SVProgressHUD.show()
        
        let parameters = ["vacancy": prompt]
        
        AF.request(Urls.SEARCH_URL, method: .get,parameters: parameters).responseData { response in
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data{
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print("JSON: \(json)")
                
                let total = json["total"].int
                
                if total != 0 {
                    if let array = json["data"].array{
                        for item in array{
                            let cv = CV(json: item)
                            self.CVarray.append(cv)
                        }
                    }
                    self.showList()
                } else {
                    SVProgressHUD.showError(withStatus: "No appropriate CV was found, try another Vacancy")
                }
            } else {
                var ErrorString = "Connection Error"
                if let sCode = response.response?.statusCode{
                    ErrorString = ErrorString + " \(sCode)"
                }
                ErrorString = ErrorString + " \(resultString)"
                SVProgressHUD.showError(withStatus: "\(ErrorString)")
            }
        }
    }
    
    func showList() {
        let tableViewController = storyboard?.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
        
        tableViewController.spec = spec
        tableViewController.CVarray = CVarray
        
        navigationController?.show(tableViewController, sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
