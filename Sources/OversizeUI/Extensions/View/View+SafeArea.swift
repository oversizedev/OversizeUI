//
// Copyright © 2021 Alexander Romanov
// Created on 26.08.2021
//

import SwiftUI

public enum EdgeInsetsType {
    case top, leading, tralling, bottom
}

/*
 public extension View {
     func getSafeArea() -> UIEdgeInsets {
         UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
     }

     func getSafeArea(_ edge: EdgeInsetsType) -> CGFloat {
         switch edge {
         case .top:
             return UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
         case .leading:
             return UIApplication.shared.windows.first?.safeAreaInsets.left ?? 0
         case .tralling:
             return UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
         case .bottom:
             return UIApplication.shared.windows.first?.safeAreaInsets.right ?? 0
         }
     }
 }
  */
