//
//  extention.swift
//  DesignCode
//
//  Created by HuyTD on 19/08/2023.
//  Copyright © 2023 huytd. All rights reserved.
//

import Foundation
import SwiftUI



extension ProgressView {
    
    func defaultProgessView() -> some View {
        self.progressViewStyle(CircularProgressViewStyle(tint: .white))
            .scaleEffect(2)
            .frame(maxWidth: UIScreen.screenWidth, maxHeight: UIScreen.screenHeight)
            .background(Color.black.opacity(0.3))
            .ignoresSafeArea()
    }
}


// MARK: - To be able to use HEX as Color
extension Color {
    
    init(hex string: String) {
        var string: String = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if string.hasPrefix("#") {
            _ = string.removeFirst()
        }

        // Double the last value if incomplete hex
        if !string.count.isMultiple(of: 2), let last = string.last {
            string.append(last)
        }

        // Fix invalid values
        if string.count > 8 {
            string = String(string.prefix(8))
        }

        // Scanner creation
        let scanner = Scanner(string: string)

        var color: UInt64 = 0
        scanner.scanHexInt64(&color)

        if string.count == 2 {
            let mask = 0xFF

            let g = Int(color) & mask

            let gray = Double(g) / 255.0

            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: 1)

        } else if string.count == 4 {
            let mask = 0x00FF

            let g = Int(color >> 8) & mask
            let a = Int(color) & mask

            let gray = Double(g) / 255.0
            let alpha = Double(a) / 255.0

            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: alpha)

        } else if string.count == 6 {
            let mask = 0x0000FF
            let r = Int(color >> 16) & mask
            let g = Int(color >> 8) & mask
            let b = Int(color) & mask

            let red = Double(r) / 255.0
            let green = Double(g) / 255.0
            let blue = Double(b) / 255.0

            self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1)

        } else if string.count == 8 {
            let mask = 0x000000FF
            let r = Int(color >> 24) & mask
            let g = Int(color >> 16) & mask
            let b = Int(color >> 8) & mask
            let a = Int(color) & mask

            let red = Double(r) / 255.0
            let green = Double(g) / 255.0
            let blue = Double(b) / 255.0
            let alpha = Double(a) / 255.0

            self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)

        } else {
            self.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 1)
        }
    }
}

extension View {
    
    /// Sets background color and title color for UINavigationBar.
    @available(iOS 14, *)
    func navigationBar(backgroundColor: Color, titleColor: Color) -> some View {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor(backgroundColor)

        let uiTitleColor = UIColor(titleColor)
        appearance.largeTitleTextAttributes = [.foregroundColor: uiTitleColor]
        appearance.titleTextAttributes = [.foregroundColor: uiTitleColor]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        return self
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}


struct PullToRefreshView: View {
    
    var coordinateSpaceName: String
    var onRefresh: ()->Void
    
    @State var needRefresh: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            if (geo.frame(in: .named(coordinateSpaceName)).midY > 50) {
                Text("")
                    .onAppear {
                        needRefresh = true
                    }
            } else if (geo.frame(in: .named(coordinateSpaceName)).maxY < 10) {
                Text("")
                    .onAppear {
                        if needRefresh {
                            needRefresh = false
                            onRefresh()
                        }
                    }
            }
            HStack {
                Spacer()
                if needRefresh {
                    ProgressView()
                } else {
                    Text("Pull To Refresh")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                Spacer()
            }
        }
        .padding(.top, -50)
        .fixedSize(horizontal: false, vertical: true)
    }
}

extension UIImage {
    func compress() -> Data? {
        guard let png = pngData() else {
            return nil
        }
        if png.count >= 0 {
            return png
        }
        guard let imageData = jpegData(compressionQuality: 1) else {
            return nil
        }
        return imageData
    }
      
    func isMoreThan5MB() -> Bool {
        guard let imageData = self.compress() else {return false}
        let imageSizeKB = Double(imageData.count) / 1024
        if imageSizeKB > 5120 {
            return true
        }
        return false
    }
    
    func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
          let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
          let format = imageRendererFormat
          format.opaque = isOpaque
          return UIGraphicsImageRenderer(size: canvas, format: format).image {
              _ in draw(in: CGRect(origin: .zero, size: canvas))
          }
    }
}

struct PrimayTextField: View {
    let placeholder: String
    @Binding var text: String
    var maxLengt = 350
    var body: some View {
        HStack {
            TextField("", text: $text)
                .onReceive(text.publisher.collect()) {
                      self.text = String($0.prefix(maxLengt))
                  }
                .multilineTextAlignment(.leading)
                .foregroundColor(Color("Grey-2"))
                .padding(.all, 10)
                .frame(height: 52)
                .placeholder(when: text.isEmpty) {
                        Text("   \(placeholder)").foregroundColor(.gray)
                }
        }
        .background(Color.white)
        .frame(height: 52)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.3), lineWidth: 2)
        )
        .cornerRadius(16)
    }
}

extension Binding where Value == String {
    func max(_ limit: Int) -> Self {
        if self.wrappedValue.count > limit {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.dropLast())
            }
        }
        return self
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder()
                .opacity(shouldShow ? 1 : 0)
            self
        }
    }
}


struct PrimayButton: View {
    let title: String
    var subText: String = ""
    var isDisable: Bool = false
    var onClick: (()->Void)?
    
    var body: some View {
        Button {
            onClick?()
            FeedbackManager.mediumFeedback()
        } label: {
            VStack (spacing: 5) {
                Text(title)
                if (!subText.isEmpty){
                    Text(subText)
                }
            }.frame(height: 20)
        }
        .buttonStyle(PrimaryButtonStyle {
            Color(isDisable ? "Grey-5" : "Pink")
                .edgesIgnoringSafeArea(.all)
                .clipShape(RoundedRectangle(cornerRadius: 16))
        })
        .padding(.bottom, 10)
        .disabled(isDisable)
    }
}

// MARK: - For Settings
extension View {
    func settingsBackground() -> some View {
        self
            .padding(.horizontal)
            .padding(.vertical, 8)
//            .background(RoundedRectangle(cornerRadius: 16, style: .continuous)
//                .fill(Color(.white)))
            .padding(.bottom, 6)
            .padding(.horizontal)
    }
    
    func customHoverEffect() -> some View {
        if #available(macCatalyst 13.4, *), #available(iOS 13.4, *) {
            return AnyView(self.hoverEffect())
        } else {
            return AnyView(self)
        }
    }
    
    func hideKeyboardWhenTappedAround() -> some View  {
        return self.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                            to: nil, from: nil, for: nil)
        }
    }
}

public struct PrimaryButtonStyle<Background: View>: ButtonStyle {
    private var background: Background
    
    public init(_ background: () -> Background) {
        self.background = background()
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration
            .label
            .padding(.vertical)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(background)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .padding(.top)
    }
}

struct OutlineButtonStyle: ButtonStyle {
    let color: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .buttonStyle(BorderlessButtonStyle())
            .padding(.vertical)
            .frame(maxWidth: .infinity, alignment: .center)
            .foregroundColor(configuration.isPressed ? color.opacity(0.67) : color)
            .background(
                RoundedRectangle(
                    cornerRadius: 8,
                    style: .continuous
                )
                .stroke(color, lineWidth: 1/2)
            )
            .scaleEffect(configuration.isPressed ? 0.99 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
        
    }
}

enum FeedbackManager {
    static func mediumFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
    }
}


extension Date {
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        
        if secondsAgo < minute {
            return "\(secondsAgo) sec ago"
        } else if secondsAgo < hour {
            return "\(secondsAgo / minute) min ago"
        } else if secondsAgo < day {
            return "\(secondsAgo / hour) hrs ago"
        } else if secondsAgo < week {
            return "\(secondsAgo / day) days ago"
        }
        return "\(secondsAgo / week) weeks ago"
    }
}

public struct IfTrue<Content: View>: View {
    var value: Bool
    let content: () -> Content
    
    public init(value: Bool = true, @ViewBuilder content: @escaping () -> Content) {
        self.value = value
        self.content = content
    }
    
    public var body: some View {
        if value == true {
            content()
        }
    }
}

public struct IfFalse<Content: View>: View {
    var value: Bool
    let content: () -> Content
    
    public init(value: Bool = false, @ViewBuilder content: @escaping () -> Content) {
        self.value = value
        self.content = content
    }
    
    public var body: some View {
        if value == false {
            content()
        }
    }
}


public extension View {
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}

extension String {
   
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
    
    func localized(with argument: CVarArg = [], comment: String = "") -> String {
        return String(format: self.localized(comment: comment), argument)
    }
}

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let screenSize = UIScreen.main.bounds.size
    
    static func fracion(height value: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.height * value
    }
    
    static func fracion(width value: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.width * value
    }
}
