//
//  ServerList.swift
//
//  Created by Nidhi Jariwala on 2021-05-29.
//

import Foundation

class ServerModel {
    
    var serverData: [ServerDataModel]?
    
    init(json: [String: Any]) {
        var array: [ServerDataModel] = []
        if let data = json["data"] as? [[String: Any]] {
            for server in data {
                let dataModel = ServerDataModel(json: server)
                array.append(dataModel)
            }
        }
        serverData = array
        
    }
    
    
}


class ServerDataModel {
    let servrId: Int?
    let serverName: String?
    let serverCountryCode: String?
    let serverStatus: Int?
    let serverPremiumOnly: Bool?
    let serverHostName: String?
    let serverP2p:Bool?
    let serverTz: String?
    let serverTzOffset: String?
    let serverLocType: String?
    let serverForceExpand:Bool?
    let serverdnsHostname:String?
    let nodes: [NodeModel]?
    
    init(json: [String: Any]) {
        servrId = json["id"] as? Int
        serverName = json["name"] as? String
        serverCountryCode = json["country_code"] as? String
        serverStatus = json["status"] as? Int
        serverPremiumOnly = json["premium_only"] as? Bool
        serverHostName = json["short_name"] as? String
        serverP2p = json["p2p"] as? Bool
        serverTz = json["tz"] as? String
        serverTzOffset = json["tz_offset"] as? String
        serverLocType = json["loc_type"] as? String
        serverForceExpand = json["force_expand"] as? Bool
        serverdnsHostname = json["dns_hostname"] as? String
        
        var array: [NodeModel] = []
        if let data = json["nodes"] as? [[String: Any]] {
            for server in data {
                let dataModel = NodeModel(json: server)
                array.append(dataModel)
            }
        }
        nodes = array
    }
    
//    func storeData() {
//        guard let server = ServerModel.database.addData(ServerListData.self) else { return }
//        server.name = serverName ?? ""
//        server.country_code = serverCountryCode ?? ""
//        server.id = Int16(servrId ?? 0)
//        server.dsn_hostname = serverdnsHostname ?? ""
//        server.force_expand = serverForceExpand ?? false
//        server.loc_type = serverLocType ?? ""
//        server.status = Int16(serverStatus ?? 0)
//        server.p2p = serverP2p ?? false
//        server.tz = serverTz ?? ""
//        server.tz_offset = serverTzOffset ?? ""
//        server.premium_only = serverPremiumOnly ?? false
//    }
}

class NodeModel {
    
    let ip:String?
    let ip2:String?
    let ip3: String?
    let hostName: String?
    let weight:Double?
    let group: String?
    let gps: String?
    let tz: String?
    let type:String?
    let wgPubkey:String?
    let proOnly:Bool?
    
    
    init(json: [String: Any]) {
        ip = json["ip"] as? String
        ip2 = json["ip2"] as? String
        ip3 = json["ip3"] as? String
        hostName = json["hostname"] as? String
        weight = json["weight"] as? Double
        group = json["group"] as? String
        gps = json["gps"] as? String
        tz = json["tz"]  as? String
        type = json["type"]  as? String
        wgPubkey = json["wg_pubkey"]  as? String
        proOnly = json["pro_only"]  as? Bool
        
    }
}
