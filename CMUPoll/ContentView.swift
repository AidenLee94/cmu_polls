//
//  ContentView.swift
//  CMUPoll
//
//  Created by Aiden Lee on 10/28/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI
import GoogleSignIn
import CoreData

struct ContentView: View {
  @State var loggedIn: Bool?
  @State var showEmailAlert: Bool = false
  @State var delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
  @State var email: String?
  @State var givenName: String?
  @State var familyName: String?
  
  var body: some View {
    return Group {
      if loggedIn == nil {
        LoginView().alert(isPresented: $showEmailAlert) {
          Alert(title: Text("Invalid Email!"), message: Text("Your email address must end with 'cmu.edu'"), dismissButton: .default(Text("Try Again")))
        }
      } else if loggedIn! {
        TabbarView()
      } else {
        InitializeUserView(first_name: self.givenName!, last_name: self.familyName!, email: self.email!)
      }
    }.onAppear() {
      self.setAfterSignInOperations()
      self.restoreLogin()
    }
  }
  
  func setAfterSignInOperations() {
    let uponExistingUser: AfterSignIn = { self.loggedIn = true }
    let uponNewUser: AfterSignIn = {
      self.loggedIn = false
      self.email = self.delegate.signedEmail!
      self.givenName = self.delegate.signedGivenName!
      self.familyName = self.delegate.signedFamilyName!
    }
    let uponInvalidInput: AfterSignIn = { self.showEmailAlert = true }
    let uponLogOut: AfterSignIn = { self.loggedIn = nil }
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    delegate.uponExistingUser = uponExistingUser
    delegate.uponNewUser = uponNewUser
    delegate.uponInvalidInput = uponInvalidInput
    delegate.uponLogOut = uponLogOut
  }
  
  func restoreLogin() {
    let context = self.delegate.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Login")
    request.returnsObjectsAsFaults = false
    do {
      let result = try context.fetch(request)
      for login in result as! [Login] {
        if let id = login.user_id {
          print("Found CoreData: \(id)")
          User.withId(id: id, completion: { user in
            if user != nil {
              User.current = user
              self.loggedIn = true // Restore Log in
            }
          })
        }
      }
    } catch {
      print("CoreData Access failed")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}


