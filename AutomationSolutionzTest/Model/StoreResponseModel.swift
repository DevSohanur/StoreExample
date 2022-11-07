//
//  StoreResponseModel.swift
//  AutomationSolutionzTest
//
//  Created by Sohanur Rahman on 6/11/22.
//

import Foundation

public struct StoreResponseModel: Codable {
    var code: String?
    var name: String?
    var type: String?
    var availability: Bool?
    var needing_repair: Bool?
    var durability: Int?
    var max_durability: Int?
    var mileage: Int?
    var price: Int?
    var minimum_rent_period: Int?
    var id: Int?
}
