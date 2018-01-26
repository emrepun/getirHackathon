//
//  LoadDataTableViewController.swift
//  getirHackathon
//
//  Created by Emre HAVAN on 25.01.2018.
//  Copyright © 2018 Emre HAVAN. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoadDataTableViewController: UITableViewController {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var incommingParameters = [String]()
    var dataArray = [jsonData]()
    let connectionErrorTitle = NSLocalizedString("connectionErrorTitle", comment: "")
    let connectionErrorDetail = NSLocalizedString("connectionError", comment: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        print(incommingParameters)
        fetchData()
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()

    }
    
    //MARK: Get data from the url.
    func fetchData() {
        
        let baseUrl = "https://getir-bitaksi-hackathon.herokuapp.com/searchRecords"
        let fetchParameters: Parameters = [
            "startDate": "\(incommingParameters[0])",
            //"startDate": "2015-02-02",
            //"endDate": "2017-02-02",
            "endDate": "\(incommingParameters[1])",
            "minCount": Int(incommingParameters[2]) ?? 2700,
            "maxCount": Int(incommingParameters[3]) ?? 3000,
            ]
        
        Alamofire.request(baseUrl, method: .post, parameters: fetchParameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for (_, subJson) in json["records"] {
                    let myFetchedData = jsonData(userJson: subJson)
                    self.dataArray.append(myFetchedData)
                }
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
                self.showAlert(title: self.connectionErrorTitle, message: self.connectionErrorDetail)
            }
        }
    }

    //MARK: Tableview thing.
    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? DataCell else { return UITableViewCell() }
        
        cell.idLabel.text = dataArray[indexPath.row].id
        cell.keyLabel.text = dataArray[indexPath.row].key
        cell.valueLabel.text = dataArray[indexPath.row].value
        cell.creationDateLabel.text = dataArray[indexPath.row].createdAt
        
        //MARK: Lets make em cells more distinguishable x)
        let separatorLineView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 3))
        separatorLineView.backgroundColor = UIColor.black
        cell.contentView.addSubview(separatorLineView)
        
        return cell
    }

}

