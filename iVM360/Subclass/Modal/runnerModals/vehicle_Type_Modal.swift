//
//  vehicle_Type_Modal.swift
//  iVM360
//
//  Created by 1707 on 27/01/25.
//

import Foundation
import Foundation

class vehicle_Type_Modal: Codable {
    var vehicleName: String
    var vehicleType: Int
    var vehicleTypeId: Int
    var description: String

    init() {
        self.vehicleName = ""
        self.vehicleType = 0
        self.vehicleTypeId = 0
        self.description = ""
    }

    convenience init(withData data: [String: Any]) {
        self.init()

        self.vehicleName = data["vehicleName"] as? String ?? ""
        self.vehicleType = data["vehicleType"] as? Int ?? 0
        self.vehicleTypeId = data["vehicleTypeId"] as? Int ?? 0
        self.description = data["description"] as? String ?? ""
    }
}
