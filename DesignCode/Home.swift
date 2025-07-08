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
    
    @StateObject private var keyManager = KeyManager.shared
    @State private var selection: String? = nil
    @State private var url: String? = nil
    @State private var titleWeb: String? = nil
    var body: some View {
        ZStack {
            NavigationLink(destination: CommonWebView(title: titleWeb, stringURL: url), tag: "CommonWebView", selection: $selection) {EmptyView()}.hidden()
            VStack (spacing: 0) {
                HStack {
                    // Logo
                    Image("iconApp-Img")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    Spacer()
                    
                    Menu {
                        ForEach(LanguageSelect.allCases, id: \.self) { item in
                            Button {
                                withAnimation {
                                    keyManager.language = item
                                }
                            } label: {
                                Label(
                                    title: {Image(item.imageName)}, icon: {Text(item.rawValue)}
                                )
                            }
                        }
                        
                    } label: {
                        HStack(spacing: 15) {
                            Image(keyManager.language.imageName)
                                .resizable()
                                .frame(width: 30, height: 30)
                            Text(keyManager.language.rawValue)
                                .font(.subheadline)
                            Image(systemName: "chevron.down")
                                .foregroundColor(Color.white)
                        }
                    }
                    .foregroundColor(.white)
                }
                .padding(.horizontal)
                .background(Color("Primary"))
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        Button {
                            self.url = keyManager.language.bookingUrl
                            self.titleWeb =  keyManager.language.bookingTitle
                            WebViewModel.share.isLoad = false
                            selection = "CommonWebView"
                        } label: {
                            VStack() {
                                if let url = URL(string: keyManager.language.homeImage.first ?? ""){
                                    KFImage.url(url)
                                        .resizable()
                                        .scaledToFill()
                                }
                            }
                        }
                        VStack(spacing: 10) {
                            HStack {
                                Text("⭐️ \(keyManager.language.randomEmploy)")
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.top, 10)
                            Button {
                                self.url = keyManager.language.bookingUrl
                                self.titleWeb =  keyManager.language.bookingTitle
                                WebViewModel.share.isLoad = false
                                selection = "CommonWebView"
                            } label: {
                                VStack() {
                                    if let url = URL(string: keyManager.language.homeImage[1]){
                                        KFImage.url(url)
                                            .resizable()
                                            .scaledToFill()
                                            .background(Color.white)
                                    }
                                }
                            }
                            AnimatedButton(titleButton: keyManager.language.bookNow, onClick: {
                                self.url = keyManager.language.bookingUrl
                                self.titleWeb =  keyManager.language.bookingTitle
                                WebViewModel.share.isLoad = false
                                selection = "CommonWebView"
                            })
                            .padding(.horizontal)
                        }
                        
                        VStack(spacing: 10) {
                            HStack {
                                Text("⭐️ \(keyManager.language.designatedEmploy)")
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.top, 10)
                            Button {
                                self.url = keyManager.language.techniciansUrl
                                self.titleWeb =  keyManager.language.bookingTitle
                                WebViewModel.share.isLoad = false
                                selection = "CommonWebView"
                            } label: {
                                VStack() {
                                    if let url = URL(string: keyManager.language.homeImage[2]){
                                        KFImage.url(url)
                                            .resizable()
                                            .scaledToFill()
                                            .background(Color.white)
                                    }
                                }
                            }
                        
                            AnimatedButton(titleButton: keyManager.language.bookNow, onClick: {
                                self.url = keyManager.language.techniciansUrl
                                self.titleWeb =  keyManager.language.bookingTitle
                                WebViewModel.share.isLoad = false
                                selection = "CommonWebView"
                            })
                            .padding(.horizontal)
                        }
                
                        
                        
                        VStack(spacing: 10) {
                            HStack {
                                Text("⭐️ \(keyManager.language.registerEmploy)")
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.top, 10)
                            Button {
                                self.url = keyManager.language.apllyUrl
                                self.titleWeb =  keyManager.language.registerTitle
                                WebViewModel.share.isLoad = false
                                selection = "CommonWebView"
                            } label: {
                                VStack() {
                                    if let url = URL(string: keyManager.language.homeImage[3]){
                                        KFImage.url(url)
                                            .resizable()
                                            .scaledToFill()
                                            .background(Color.white)
                                 
                                    }
                                }
                            }
                            AnimatedButton(titleButton: keyManager.language.registerNow, onClick: {
                                self.url = keyManager.language.apllyUrl
                                self.titleWeb =  keyManager.language.registerTitle
                                WebViewModel.share.isLoad = false
                                selection = "CommonWebView"
                            })
                            .padding(.horizontal)
                        }
                  
                        Spacer()
                    }
                }
            }
            .background(Color.white)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
    }
}

struct AnimatedButton: View {
    @State private var isZoomed: Bool = false
    
    let titleButton: String
    let onClick: () -> Void
    
    var body: some View {
        Button(action: {
            onClick()
        }) {
            HStack {
                Spacer()
                Text(titleButton)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .padding()
                Spacer()
            }
        }
        .background(Color("Primary"))
        .foregroundColor(.white)
        .cornerRadius(10)
        .scaleEffect(isZoomed ? 1.0 : 0.8)
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                isZoomed.toggle()
            }
        }
    }
}
