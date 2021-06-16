//
//  ServerListData.swift
//
//  Created by Nidhi Jariwala on 2021-06-03.
//

import CoreData

public class ServerListData: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var id: Int16
    @NSManaged var country_code: String
    @NSManaged var status: Int16
    @NSManaged var premium_only: Bool
    @NSManaged var p2p: Bool
    @NSManaged var tz: String
    @NSManaged var tz_offset: String
    @NSManaged var loc_type: String
    @NSManaged var force_expand: Bool
    @NSManaged var dsn_hostname: String
}
