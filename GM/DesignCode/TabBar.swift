//
//  TabBar.swift
//  DesignCode
//
//  Created by huytd x on 7/15/19.
//  Copyright © 2019 huytd. All rights reserved.
//

import SwiftUI

struct TabBar: View {
   var body: some View {
      TabView {
         Home().tabItem {
            Image("IconHome")
            Text("Home")
         }
         .tag(1)
         ContentView().tabItem {
            Image("IconCards")
            Text("Certificates")
         }
         .tag(2)
       
      }
      .edgesIgnoringSafeArea(.top)
   }
}

#if DEBUG
struct TabBar_Previews: PreviewProvider {
   static var previews: some View {
      TabBar()
//         .environment(\.colorScheme, .dark)
   }
}
#endif
