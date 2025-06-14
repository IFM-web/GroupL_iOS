//
//  Trip_List.swift
//  iVM360
//
//  Created by 1707 on 26/01/25.
//

import Foundation

class Trip_List: Codable {
    var tripId: Int
    var userId: Int
    var tripTypeId: Int
    var assignedBy: String
    var totalFare: String
    var distanceTravelled: String
    var tripStatus: Int
    var startDate: String
    var endDate: String?
    var startKilometer: String?
    var endKilometer: String?
    var startMeterImage: String
    var endMeterImage: String?
    var createdDate: String
    var startTripComment: String
    var endTripComment: String?
    var vehicleTypeId: Int
    var vehicleName: String
    var startPoint: String
    var endPoint: String?
    var expense: [String] // Assuming expense is an array of strings

    // Default initializer
    init() {
        self.tripId = 0
        self.userId = 0
        self.tripTypeId = 0
        self.assignedBy = ""
        self.totalFare = "0.00"
        self.distanceTravelled = "0.00"
        self.tripStatus = 0
        self.startDate = ""
        self.endDate = nil
        self.startKilometer = nil
        self.endKilometer = nil
        self.startMeterImage = ""
        self.endMeterImage = nil
        self.createdDate = ""
        self.startTripComment = ""
        self.endTripComment = nil
        self.vehicleTypeId = 0
        self.vehicleName = ""
        self.startPoint = ""
        self.endPoint = nil
        self.expense = []
    }

    // Convenience initializer for dictionary parsing
    convenience init(withData data: [String: Any]) {
        self.init()

        self.tripId = data["tripId"] as? Int ?? 0
        self.userId = data["userId"] as? Int ?? 0
        self.tripTypeId = data["tripTypeId"] as? Int ?? 0
        self.assignedBy = data["assignedBy"] as? String ?? ""
        self.totalFare = data["totalFare"] as? String ?? "0.00"
        self.distanceTravelled = data["distanceTravelled"] as? String ?? "0.00"
        self.tripStatus = data["tripStatus"] as? Int ?? 0
        self.startDate = data["startDate"] as? String ?? ""
        self.endDate = data["endDate"] as? String
        self.startKilometer = data["startKilometer"] as? String
        self.endKilometer = data["endKilometer"] as? String
        self.startMeterImage = data["startMeterImage"] as? String ?? ""
        self.endMeterImage = data["endMeterImage"] as? String
        self.createdDate = data["createdDate"] as? String ?? ""
        self.startTripComment = data["startTripComment"] as? String ?? ""
        self.endTripComment = data["endTripComment"] as? String
        self.vehicleTypeId = data["vehicleTypeId"] as? Int ?? 0
        self.vehicleName = data["vehicleName"] as? String ?? ""
        self.startPoint = data["startPoint"] as? String ?? ""
        self.endPoint = data["endPoint"] as? String
        self.expense = data["expense"] as? [String] ?? []
    }
}
