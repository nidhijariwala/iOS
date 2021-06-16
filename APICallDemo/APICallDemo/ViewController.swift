//
//  ViewController.swift
//
//  Created by Nidhi Jariwala on 2021-05-29.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet var serverListTableView: UITableView!
   
    
//    var serverList = [ServerListData]() {
//        didSet {
//            self.serverListTableView.reloadData()
//        }
//    }
    var serverListResponse: [ServerDataModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadServerData()
        // Do any additional setup after loading the view.
    }

    

   

    func loadServerData() {
        APIHandler.shared.getServerData { (success, response) in
            if success, let serverData = response as? ServerModel {
                self.serverListResponse = serverData.serverData
                DispatchQueue.main.async {
                    self.serverListTableView.reloadData()
                }
                
                //print(self.serverListResponse ?? [])
            } else if let errorString = response as? String {
                debugPrint(errorString)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serverListResponse?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.serverListTableView.dequeueReusableCell(withIdentifier: "serverListCell")!
        let data = self.serverListResponse?[indexPath.row]
        // set the text from the data model
        cell.textLabel?.text = data?.serverName
        
        return cell
    }
    
    
}

