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
    case vn = "Tiếng Việt"
    case en = "English"
    case ph = "Philippines"
    case kr = "한국어"
    case tw = "臺灣華語"
    
    var imageName: String {
        switch self {
        case .vn:
            return "icons8-vietnam-96"
        case .en:
            return "icons8-english-96"
        case .ph:
            return "icons8-philippines-96"
        case .kr:
            return "icons8-korean-flag-96"
        case .tw:
            return "icons8-taiwan-96"
        }
    }
    
    var langualeCode: String {
        switch self {
        case .vn:
            return "vi"
        case .en:
            return "en"
        case .ph:
            return "ph"
        case .kr:
            return "ko"
        case .tw:
            return "tw"
        }
    }
    
    var bookingUrl: String {
        return DOMAIN_URL + langualeCode + "/booking"
    }
    
    var bookingTitle: String {
        switch self {
        case .vn:
            return "Đặt lịch"
        case .en:
            return "Booking"
        case .ph:
            return "Pagbu-book"
        case .kr:
            return "예약"
        case .tw:
            return "預訂"
        }
    }
    
    var registerTitle: String {
        switch self {
        case .vn:
            return "Đăng ký"
        case .en:
            return "Register"
        case .ph:
            return "Magparehistro"
        case .kr:
            return "등록"
        case .tw:
            return "註冊"
        }
    }
    
    var techniciansUrl: String {
        return DOMAIN_URL + langualeCode + "/technicians"
    }
    
    var apllyUrl: String {
        return DOMAIN_URL + langualeCode + "/apply"
    }
    
    
    var randomEmploy: String {
        switch self {
        case .vn:
            return "Vé chọn nhân viên ngẫu nhiên"
        case .en:
            return "Random staff selection ticket"
        case .ph:
            return "Ticket para sa random na pagpili ng kawani"
        case .kr:
            return "무작위 직원 선택권"
        case .tw:
            return "隨機員工選票"
        }
    }
    
    var designatedEmploy: String {
        switch self {
        case .vn:
            return "Vé chọn nhân viên chỉ định"
        case .en:
            return "Random staff selection ticket"
        case .ph:
            return "Ticket para sa itinalagang pagpili ng kawani"
        case .kr:
            return "지정 직원 선택권"
        case .tw:
            return "指定員工選票"
        }
    }
    
    var registerEmploy: String {
        switch self {
        case .vn:
            return "Đăng ký để trở thành nhân viên của Go Mass"
        case .en:
            return "Apply to become a Go Mass employee"
        case .ph:
            return "Mag-apply para maging empleyado ng Go Mass"
        case .kr:
            return "Go Mass 직원이 되기 위해 지원하세요"
        case .tw:
            return "申請成為 Go Mass 員工"
        }
    }
    
    var bookNow: String {
        switch self {
        case .vn:
            return "Đặt lịch ngay"
        case .en:
            return "Book now"
        case .ph:
            return "Mag-book na ngayon"
        case .kr:
            return "지금 예약하세요"
        case .tw:
            return "立即預約"
        }
    }
    
    var registerNow: String {
        switch self {
        case .vn:
            return "Đăng ký ngay"
        case .en:
            return "Register now"
        case .ph:
            return "Magrehistro na ngayon"
        case .kr:
            return "지금 등록하세요"
        case .tw:
            return "立即註冊"
        }
    }
    
    var homeImage: [String] {
        switch self {
        case .vn:
            return (KeyManager.shared.dataInit?.vi ?? []).isEmpty ? ["","","",""] : KeyManager.shared.dataInit?.vi ?? []
        case .en:
            return (KeyManager.shared.dataInit?.en ?? []).isEmpty ? ["","","",""] : KeyManager.shared.dataInit?.en ?? []
        case .ph:
            return (KeyManager.shared.dataInit?.ph ?? []).isEmpty ? ["","","",""] : KeyManager.shared.dataInit?.ph ?? []
        case .kr:
            return (KeyManager.shared.dataInit?.ko ?? []).isEmpty ? ["","","",""] : KeyManager.shared.dataInit?.ko ?? []
        case .tw:
            return (KeyManager.shared.dataInit?.tw ?? []).isEmpty ? ["","","",""] : KeyManager.shared.dataInit?.tw ?? []
        }
    }
}
