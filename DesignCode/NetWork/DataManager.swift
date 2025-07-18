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
            return "Đặt ngay"
        case .en:
            return "Book Now"
        case .ph:
            return "Mag-book Ngayon" // Filipino (Philippines)
        case .kr:
            return "지금 예약하기" // Korean
        case .tw:
            return "立即預訂" // Traditional Chinese (Taiwan)
        }
    }
    
    var selectBookingTitle: String {
        switch self {
        case .vn:
            return "Chọn chuyên viên ngay"
        case .en:
            return "Choose Specialist Now"
        case .ph:
            return "Pumili ng Espesyalista Ngayon" // Filipino (Philippines)
        case .kr:
            return "지금 전문가를 선택하세요" // Korean
        case .tw:
            return "立即選擇專家" // Traditional Chinese (Taiwan)
        }
    }
    
    var registerTitle: String {
        switch self {
        case .vn:
            return "Ứng tuyển ngay"
        case .en:
            return "Apply Now"
        case .ph:
            return "Mag-apply Ngayon" // Filipino (Philippines)
        case .kr:
            return "지금 지원하세요" // Korean
        case .tw:
            return "立即申請" // Traditional Chinese (Taiwan)
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
        let defaultData = KeyManager.shared.dataInit?.vi ?? []
        switch self {
        case .vn:
            return defaultData
        case .en:
            return KeyManager.shared.dataInit?.en ?? defaultData
        case .ph:
            return  KeyManager.shared.dataInit?.ph ?? defaultData
        case .kr:
            return  KeyManager.shared.dataInit?.ko ?? defaultData
        case .tw:
            return  KeyManager.shared.dataInit?.tw ?? defaultData
        }
    }
}




enum GridButtonItem: CaseIterable {
    
    case price
    case service
    case workingHour
    case travelTime
    case wokingProcess
    case contact
    case benifit
    case feedback
    case payment
    case guide
    
    func url(_ code: String) -> String {
        switch self {
        case .price:
            return DOMAIN_URL + code + "/posts/pricing"
        case .service:
            return DOMAIN_URL + code + "/posts/service-types"
        case .workingHour:
            return DOMAIN_URL + code + "/posts/working-hours"
        case .travelTime:
            return DOMAIN_URL + code + "/posts/travel-time"
        case .wokingProcess:
            return DOMAIN_URL + code + "/posts/massage-process"
        case .contact:
            return DOMAIN_URL + code + "/posts/contact"
        case .benifit:
            return DOMAIN_URL + code + "/posts/benefits-notes"
        case .feedback:
            return DOMAIN_URL + code + "/posts/complaints-feedback"
        case .payment:
            return DOMAIN_URL + code + "/posts/payment-methods"
        case .guide:
            return DOMAIN_URL + code + "/posts/booking-guide"
        }
    }
    
    
    func title(_ language: LanguageSelect) -> String {
        switch self {
        case .price:
            return priceTitle(language)
        case .service:
            return serviceTitle(language)
        case .workingHour:
            return wokingTimeTitle(language)
        case .travelTime:
            return travelTimeTitle(language)
        case .wokingProcess:
            return wokingProcessTitle(language)
        case .contact:
            return contactTitle(language)
        case .benifit:
            return benifitTitle(language)
        case .feedback:
            return feedbackTitle(language)
        case .payment:
            return paymentTitle(language)
        case .guide:
            return guideTitle(language)
        }
    }
    
    func priceTitle(_ language: LanguageSelect) -> String {
        switch language {
        case .vn:
            return "GIÁ VÉ MASSAGE"
        case .en:
            return "Massage rates"
        case .ph:
            return "Presyo ng tiket sa masahe"
        case .kr:
            return "마사지 티켓 가격"
        case .tw:
            return "按摩票價"
        }
    }
    
    func serviceTitle(_ language: LanguageSelect) -> String {
        switch language {
        case .vn:
            return "LOẠI DỊCH VỤ"
        case .en:
            return "SERVICE TYPE"
        case .ph: // Tagalog (Philippines)
            return "URI NG SERBISYO"
        case .kr: // Korean
            return "서비스 종류"
        case .tw: // Traditional Chinese (Taiwan)
            return "服務類型"
        }
    }
    
    func wokingTimeTitle(_ language: LanguageSelect) -> String {
        switch language {
        case .vn:
            return "THỜI GIAN LÀM VIỆC"
        case .en:
            return "WORKING HOURS"
        case .ph: // Tagalog (Philippines)
            return "ORAS NG TRABAHO"
        case .kr: // Korean
            return "근무 시간"
        case .tw: // Traditional Chinese (Taiwan)
            return "營業時間" // Or 工作時間 if it's specifically about employee work time
        }
    }
    
    func travelTimeTitle(_ language: LanguageSelect) -> String {
        switch language {
        case .vn:
            return "THỜI GIAN DI CHUYỂN"
        case .en:
            return "TRAVEL TIME"
        case .ph: // Tagalog (Philippines)
            return "ORAS NG BIYAHE"
        case .kr: // Korean
            return "이동 시간"
        case .tw: // Traditional Chinese (Taiwan)
            return "交通時間" // Or 旅行時間 if it's about the duration of a trip
        }
    }
    
    func wokingProcessTitle(_ language: LanguageSelect) -> String {
        switch language {
        case .vn:
            return "QUY TRÌNH MASSAGE"
        case .en:
            return "MASSAGE PROCESS"
        case .ph: // Tagalog (Philippines)
            return "PROSESO NG MASAHE"
        case .kr: // Korean
            return "마사지 과정"
        case .tw: // Traditional Chinese (Taiwan)
            return "按摩流程"
        }
    }
    
    func contactTitle(_ language: LanguageSelect) -> String {
        switch language {
        case .vn:
            return "LIÊN HỆ"
        case .en:
            return "CONTACT"
        case .ph: // Tagalog (Philippines)
            return "CONTACT" // Or "MAKIPAG-UGNAYAN" (to make contact)
        case .kr: // Korean
            return "문의" // (Inquiry/Contact)
        case .tw: // Traditional Chinese (Taiwan)
            return "聯絡我們" // (Contact Us) or 聯絡 (Contact)
        }
    }
    
    func benifitTitle(_ language: LanguageSelect) -> String {
        switch language {
        case .vn:
            return "QUYỀN LỢI - LƯU Ý"
        case .en:
            return "BENEFITS - NOTES"
        case .ph: // Tagalog (Philippines)
            return "MGA BENEPISYO - PAALALA"
        case .kr: // Korean
            return "혜택 - 유의사항"
        case .tw: // Traditional Chinese (Taiwan)
            return "權益 - 注意事項"
        }
    }
    
    func feedbackTitle(_ language: LanguageSelect) -> String {
        switch language {
        case .vn:
            return "KHIẾU NẠI - GÓP Ý"
        case .en:
            return "COMPLAINTS - FEEDBACK"
        case .ph: // Tagalog (Philippines)
            return "MGA REKLAMO - FEEDBACK" // Or "MGA REKLAMO - MGA MUNGKAHI"
        case .kr: // Korean
            return "불만 - 피드백" // Or "불만 사항 및 제안" (Complaints and Suggestions)
        case .tw: // Traditional Chinese (Taiwan)
            return "投訴 - 意見回饋"
        }
    }
    
    func paymentTitle(_ language: LanguageSelect) -> String {
        switch language {
        case .vn:
            return "PHƯƠNG THỨC THANH TOÁN"
        case .en:
            return "PAYMENT METHODS"
        case .ph: // Tagalog (Philippines)
            return "PARAAN NG PAGBABAYAD"
        case .kr: // Korean
            return "결제 방법"
        case .tw: // Traditional Chinese (Taiwan)
            return "付款方式"
        }
    }

    func guideTitle(_ language: LanguageSelect) -> String {
        switch language {
        case .vn:
            return "HƯỚNG DẪN ĐẶT MASSAGE"
        case .en:
            return "GUIDE TO BOOKING MASSAGE"
        case .ph: // Tagalog (Philippines)
            return "GABAY SA PAG-BOOK NG MASAHE"
        case .kr: // Korean
            return "마사지 예약 안내"
        case .tw: // Traditional Chinese (Taiwan)
            return "按摩預約指南"
        }
    }
    
}
