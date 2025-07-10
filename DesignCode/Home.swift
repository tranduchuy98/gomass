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
    @State private var isLoadData = true
    var body: some View {
        ZStack {
            NavigationLink(destination: CommonWebView(title: titleWeb, stringURL: url), tag: "CommonWebView", selection: $selection) {EmptyView()}.hidden()
            VStack (spacing: 0) {
                if !self.isLoadData {
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
                    .frame(height: 64)
                    .padding(.horizontal)
                    .background(Color("Primary"))
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        Button {
                            self.url = keyManager.language.bookingUrl
                            self.titleWeb =  keyManager.language.bookingTitle
                            WebViewModel.share.isLoad = false
                            selection = "CommonWebView"
                        } label: {
                            VStack() {
                                    KFImage.url(URL(string: keyManager.language.homeImage.first ?? ""))
                                        .resizable()
                                        .placeholder {
                                            Image("placeholder")
                                                .resizable()
                                        }
                                        .scaledToFill()
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
                                        KFImage.url(URL(string: keyManager.language.homeImage[1]))
                                            .resizable()
                                            .placeholder {
                                                Image("placeholder")
                                                    .resizable()
                                            }
                                            .scaledToFill()
                                            .background(Color.white)
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
                                        KFImage.url(URL(string: keyManager.language.homeImage[2]))
                                            .resizable()
                                            .placeholder {
                                                Image("placeholder")
                                                    .resizable()
                                            }
                                            .scaledToFill()
                                            .background(Color.white)
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
                                        KFImage.url(URL(string: keyManager.language.homeImage[3]))
                                            .resizable()
                                            .placeholder {
                                                Image("placeholder")
                                                    .resizable()
                                            }
                                            .scaledToFill()
                                            .background(Color.white)
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
                        
                        GridButtonsView(language: keyManager.language, onclick: {
                            self.url = $0.url(keyManager.language.langualeCode)
                            self.titleWeb =  $0.title(keyManager.language)
                            WebViewModel.share.isLoad = false
                            selection = "CommonWebView"
                        })
                  
                        Spacer()
                    }
                }
            }
            .background(Color.white)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    self.isLoadData = false
                }
            }
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

struct GridButtonsView: View {
 
    let language: LanguageSelect
    let onclick: (GridButtonItem) -> Void
    
   private let gridItems: [GridItem] = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]

    var body: some View {
       
        ScrollView {
            LazyVGrid(columns: gridItems, spacing: 15) {
                ForEach(GridButtonItem.allCases, id: \.self) { item in
                    Button(action: {
                        onclick(item)
                    }) {
                        Text(item.title(language))
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .background(Color(red: 0.15, green: 0.45, blue: 0.25))
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}
