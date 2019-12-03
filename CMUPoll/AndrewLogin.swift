//
//  AndrewLogin.swift
//  CMUPoll
//
//  Created by Sung on 11/6/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import Foundation
import SwiftUI
import GoogleSignIn

struct AndrewLogin: UIViewRepresentable {
  func makeUIView(context: UIViewRepresentableContext<AndrewLogin>) -> UIView {
    let button = GIDSignInButton()
    return button
  }
  
  func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<AndrewLogin>) {
    // This functin is needed to conform to UIViewRepresentable protocol
  }
  
  func attemptLogin() {    
    GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
    GIDSignIn.sharedInstance()?.signIn()
  }
}
