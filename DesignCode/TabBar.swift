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
       Home()
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
