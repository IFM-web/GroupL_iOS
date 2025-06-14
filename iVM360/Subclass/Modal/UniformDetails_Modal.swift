//
//  UniformDetails_Modal.swift
//  iVM360
//
//  Created by 1707 on 04/03/25.
//

import UIKit
class UniformItemModal: Codable {
    var image: String
    var status: String
    var uniformID: Int
    var uniformItem: String
    var isYes = false
    var isNo  = false

    init() {
        self.image = ""
        self.status = ""
        self.uniformID = 0
        self.uniformItem = ""
    }

    convenience init(withData data: [String: Any]) {
        self.init()
        self.image = String(describing: data["Image"] ?? "")
        self.status = String(describing: data["Status"] ?? "")
        self.uniformID = data["UniformID"] as? Int ?? 0
        self.uniformItem = String(describing: data["UniformItem"] ?? "")
    }
}
