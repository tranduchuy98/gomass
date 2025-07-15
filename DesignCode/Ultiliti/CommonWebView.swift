//
//  File.swift
//  DesignCode
//
//  Created by Huy Tran on 7/7/25.
//  Copyright © 2025 Mithun. All rights reserved.
//

import Foundation
import SwiftUI

struct CommonWebView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var isLoading = true
    @State private var selection: String? = nil
    var title: String?
    var stringURL: String?
    var onClose: (() -> Void)?
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    Button {
                        if WebViewModel.share.webview?.canGoBack ?? false {
                            WebViewModel.share.webview?.goBack()
                        } else {
                            presentationMode.wrappedValue.dismiss()
                        }
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(Color("Primary"))
                            .padding()
                        Text(title ?? "")
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Primary"))
                    }
                    Spacer()
                }
                ZStack {
                    if let directURL = URL(string: stringURL ?? "") {
                        WebView(request: URLRequest(url: directURL))
                            .didFinish {
                                isLoading = false
                            }
                    } else {
                        VStack {
                            Spacer()
                            Text("404")
                                .font(.largeTitle)
                            Text("ERROR NOT FOUND!")
                                .font(.callout)
                            Spacer()
                        }
                        .onAppear {
                            isLoading = false
                        }
                    }
                    
                    if isLoading {
                        ProgressView()
                            .defaultProgessView()
                    }
                }
            }
            .background(Color.white)
        }
        .navigationBarHidden(true)
    }
}
