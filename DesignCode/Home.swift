//
//  Home.swift
//  DesignCode
//
//  Created by Mithun x on 7/12/19.
//  Copyright © 2019 Mithun. All rights reserved.
//

import SwiftUI
import Kingfisher

struct Home: View {
    var body: some View {
        VStack {
            HStack {
                // Logo
                Image("iconApp-Img")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                Spacer()
                
                HStack(spacing: 15) {
                    Image(systemName: "globe") // Biểu tượng quả địa cầu
                        .font(.title2)
                    Image(systemName: "chevron.down") // Biểu tượng mũi tên xuống
                        .font(.caption) // Kích thước nhỏ hơn
                    
                    // Dấu phân cách dọc
                    Divider()
                        .frame(width: 1, height: 25)
                        .background(Color.gray.opacity(0.5))
                    
                    Image(systemName: "line.horizontal.3") // Biểu tượng hamburger menu
                        .font(.title2)
                }
                .foregroundColor(.gray)
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    VStack() {
                        if let url = URL(string: KeyManager.shared.dataInit?.vi?.first ?? ""){
                            KFImage.url(url)
                                .resizable()
                                .scaledToFill()
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(color: .gray.opacity(0.3), radius: 8, x: 0, y: 5)
                                .padding(.horizontal)
                                .padding(.top, 10)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        HStack(spacing: 20) {
                            Spacer()
                            LanguageFlagView(imageName: "icons8-vietnam-96", languageName: "Tiếng Việt")
                            LanguageFlagView(imageName: "icons8-english-96", languageName: "English")
                            LanguageFlagView(imageName: "icons8-philippines-96", languageName: "Philippines")
                            Spacer()
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical)
                    
                    VStack() {
                        if let url = URL(string: KeyManager.shared.dataInit?.vi?[1] ?? ""){
                            KFImage.url(url)
                                .resizable()
                                .scaledToFill()
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(color: .gray.opacity(0.3), radius: 8, x: 0, y: 5)
                                .padding(.horizontal)
                                .padding(.top, 10)
                        }
                    }
                    
                    VStack() {
                        if let url = URL(string: KeyManager.shared.dataInit?.vi?[2] ?? ""){
                            KFImage.url(url)
                                .resizable()
                                .scaledToFill()
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(color: .gray.opacity(0.3), radius: 8, x: 0, y: 5)
                                .padding(.horizontal)
                                .padding(.top, 10)
                        }
                    }
                    
                    GridButtonsView()
                    
                    VStack() {
                        if let url = URL(string: KeyManager.shared.dataInit?.vi?.last ?? ""){
                            KFImage.url(url)
                                .resizable()
                                .scaledToFill()
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(color: .gray.opacity(0.3), radius: 8, x: 0, y: 5)
                                .padding(.horizontal)
                                .padding(.top, 10)
                        }
                    }
                    Spacer()
                }
            }
        }
            .background(Color.white)
            .navigationBarBackButtonHidden(true)
    }
}

struct LanguageFlagView: View {
    let imageName: String
    let languageName: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
//                .overlay(
//                    Circle().stroke(Color.gray.opacity(0.4), lineWidth: 1) // Viền xám mờ
//                )
            Text(languageName)
                .font(.footnote)
                .foregroundColor(.black.opacity(0.8))
        }
    }
}

struct GridButtonItem: Identifiable {
    let id = UUID()
    let title: String
}

struct GridButtonsView: View {
    let items: [GridButtonItem] = [
        GridButtonItem(title: "GIÁ VÉ MASSAGE"),
        GridButtonItem(title: "LOẠI DỊCH VỤ"),
        GridButtonItem(title: "THỜI GIAN LÀM VIỆC"),
        GridButtonItem(title: "THỜI GIAN DI CHUYỂN"),
        GridButtonItem(title: "QUY TRÌNH MASSAGE"),
        GridButtonItem(title: "QUYỀN LỢI - LƯU Ý"),
        GridButtonItem(title: "LIÊN HỆ"),
        GridButtonItem(title: "KHIẾU NẠI - GÓP Ý"),
        GridButtonItem(title: "PHƯƠNG THỨC THANH TOÁN"),
        GridButtonItem(title: "HƯỚNG DẪN ĐẶT MASSAGE")
    ]

    let gridItems: [GridItem] = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]

    var body: some View {
       
        ScrollView {
            LazyVGrid(columns: gridItems, spacing: 15) {
                ForEach(items) { item in
                    Button(action: {
                        print("Nút '\(item.title)' đã được nhấn!")
                    }) {
                        Text(item.title)
                            .font(.system(size: 14, weight: .bold)) // Kích thước và độ đậm của chữ
                            .foregroundColor(.white) // Màu chữ trắng
                            .frame(maxWidth: .infinity) // Chiều rộng tối đa để lấp đầy cột
                            .padding(.vertical, 20) // Khoảng cách trên và dưới của chữ so với viền nút
                            .background(Color(red: 0.15, green: 0.45, blue: 0.25)) // Màu nền xanh đậm
                            .cornerRadius(10) // Bo góc nút
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3) // Đổ bóng nhẹ
                    }
                }
            }
            .padding(.horizontal, 20) // Khoảng cách hai bên của toàn bộ lưới
            .padding(.vertical, 20) // Khoảng cách trên dưới của toàn bộ lưới
        }
        .background(Color.white) // Màu nền tổng thể của view
        .edgesIgnoringSafeArea(.all) // Mở rộng nền ra toàn bộ màn hình
    }
}
