//
//  AllPollsView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/11/02.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI

struct AllPollsView: View {
  let polls = [
    Poll(id: "1", user_id: "1", title: "Who is your favorite IS Professor?", description: "Nyo", link: "", is_private: false),
    Poll(id: "2", user_id: "1", title: "What is your favorite sports?", description: "Nyo", link: "", is_private: false),
    Poll(id: "3", user_id: "1", title: "Where is your favorite study place?", description: "Nyo", link: "", is_private: false),
    Poll(id: "4", user_id: "1", title: "Sample Title", description: "Nyo", link: "", is_private: false),
    Poll(id: "5", user_id: "1", title: "Sleepy Sleepy Night", description: "Nyo", link: "", is_private: false),
  ]
  
  let tags = [
    Tag(id: "1", name: "IS"),
    Tag(id: "3", name: "CS"),
    Tag(id: "4", name: "Life"),
    Tag(id: "5", name: "Academic"),
    Tag(id: "8", name: "Food"),
  ]
  
  @State private var searchTerm: String = ""
  
  var body: some View {
    NavigationView {
      List {
        SearchBarView(text: $searchTerm)
        TagsView(tags: tags)
        ForEach(self.polls) { poll in
          NavigationLink(destination: PollDetailView(poll: poll)) {
            PollView(poll: poll)
          }
        }
      }
      .navigationBarTitle(Text("CMUPoll"), displayMode: .inline)
      .navigationBarItems(trailing:
        // TODO: should connect to a form view
        NavigationLink(destination: PollCreateView()) {
          Text("Add")
        }
      )
    }
  }
}

struct AllPollsView_Previews: PreviewProvider {
  static var previews: some View {
    AllPollsView()
  }
}
