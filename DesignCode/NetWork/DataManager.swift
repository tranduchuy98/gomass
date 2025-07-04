//
//  DataManager.swift
//  DesignCode
//
//  Created by Huy Tran on 4/7/25.
//  Copyright © 2025 Mithun. All rights reserved.
//

import Foundation

class KeyManager : ObservableObject {
    
    static let shared = KeyManager()
    
    @Published public var dataInit: InnitDataModel? = nil
    @Published public var language: LanguageSelect = .vn
}

enum LanguageSelect: String, CaseIterable {
    case vn = "Việt Nam"
    case en = "English"
    case ph = "Philippin"
}
