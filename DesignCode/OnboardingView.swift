//
//  OnboardingView.swift
//  DesignCode
//
//  Created by HuyTD on 10/09/2023.
//  Copyright © 2023 Mithun. All rights reserved.
//

import SwiftUI

struct OnboardingView: View {
    @State private var selection: String? = ""
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: Home(), tag: "Home", selection: $selection) { EmptyView() }.isDetailLink(false).hidden()
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Image("iconApp-Img")
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 200, height: 200)
                        Spacer()
                    }
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.init(hex: "39564d")))
                        .scaleEffect(2.0, anchor: .center)
                        .padding(.top, 50)
                    Spacer()
                }
                .background(Color.white)
            }
        }
        .navigationViewStyle(.stack)
        .onAppear {
            DataService.getInitData(path: DOMAIN + "/api/v1/configHome") {  (data, response, error) in
                if let data = data {
                    if let model = data.toData(keyPath: "data").toModel(InnitDataModel.self) {
                        KeyManager.shared.dataInit = model
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.selection = "Home"
                        }
                    }
                }
            }
        }
//        .background(Color.init(hex: "39564d"))
    }
}

