//
//  SplashScreen.swift
//
//
//  Created by Yoshiki Hemmi on 2022/09/14.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        Text("Hello, SplashScreen")
            .foregroundColor(.primary)
            .statusBarHidden()
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
