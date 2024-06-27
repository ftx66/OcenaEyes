//
//  SpeciesInfo.swift
//  OceanEyes
//
//  Created by 方正豪 on 2024/6/21.
//

import Foundation

struct SpeciesInfo: Codable {
    var name: String
    var describe: String
}

extension SpeciesInfo {
    init() {
        self.name = ""
        self.describe = ""
    }
}

