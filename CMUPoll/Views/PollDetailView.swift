////
////  PollDetailView.swift
////  CMUPoll
////
////  Created by 이시헌 on 2019/11/04.
////  Copyright © 2019 Aiden Lee. All rights reserved.
////
//
//import SwiftUI
//
//struct PollDetailView: View {
//  let profile = Image("user_pic")
//  let uploaderName = "Aiden Lee"
//  let uploaderMajor = "Information Systems"
//  let uploaderGraduationYear: String = "2020"
//  let uploadedDaysAgo = "29"
//  let poll: Poll
//  @State var tags = [Tag]()
//  @State var questions = [Question]()
//  @State var pollUser: User?
//  @State var questionAnswered = [String: Bool]()
//  @State var accumulatedQuestionAnswered = [String: Bool]()
//  @State var initialized: Bool = false
//
//
//  var body: some View {
//    List {
//      if (pollUser != nil) {
//        PollUploaderProfileView(uploaderName: "\(pollUser!.first_name) \(pollUser!.last_name)", uploaderMajor: pollUser!.major, uploaderGraduationYear: String(pollUser!.graduation_year ?? 2020), uploadedDaysAgo: uploadedDaysAgo)
//      }
//      Text(poll.title)
//        .fontWeight(.semibold)
//        .multilineTextAlignment(.leading)
//        .font(Font.system(size: 20, design: .default))
//        .lineSpacing(10)
//      HStack(alignment: .firstTextBaseline, spacing: 5) {
//        ForEach(self.tags) { tag in
//          TagView(tagText: tag.name)
//        }
//      }
//      PollDetailDescriptionView(description: poll.description)
//      Text(verbatim: "You will get 5 point per questions that you answered")
//        .font(Font.system(size: 12, design: .default))
//        .fontWeight(.semibold)
//        .foregroundColor(Color(red: 236 / 255.0, green: 0 / 255.0, blue: 0 / 255.0))
//      if self.initialized {
//        ForEach(self.questions) { question in
//          if self.questionAnswered[question.id] == true {
//            AnswerGraphView(question: question, onEditedAnswer: {
//              self.questionAnswered[question.id] = false
//            })
//          } else {
//            AnswerBoxView(question: question, onNewAnswer: {
//              self.questionAnswered[question.id] = true
//            })
//          }
//        }
//      }
//    }
//    .frame(minWidth: 0, maxWidth: .infinity, idealHeight: 188.0, alignment: .center)
//    .padding(.vertical, 25)
//    .padding(.horizontal, 15)
//    .onAppear {
//      self.initialized = false
//      self.getPollUser()
//    }
//  }
//
//  func getPollUser() {
//    self.poll.user(completion: { user in
//      DispatchQueue.main.async {
//        self.pollUser = user
//        self.getPollTags()
//      }
//    })
//  }
//
//  func getPollTags() {
//    self.poll.tags(completion: { tags in
//      DispatchQueue.main.async {
//        self.tags = tags
//        self.getPollQuestions()
//      }
//    })
//  }
//
//  func getPollQuestions() {
//    self.poll.questions(completion: { questions in
//      DispatchQueue.main.async {
//        self.questions = questions
//        self.getQuestionAnswered()
//      }
//    })
//  }
//
//  func accumulateQuestionAnswered(question_id: String, hasAnswer: Bool) {
//    accumulatedQuestionAnswered[question_id] = hasAnswer
//    if (accumulatedQuestionAnswered.count >= self.questions.count) {
//      self.questionAnswered = self.accumulatedQuestionAnswered
//      self.initialized = true
//    }
//  }
//
//  func getQuestionAnswered() {
//    self.accumulatedQuestionAnswered = [:]
//    for question in self.questions {
//      question.userHasAnswer(completion: { hasAnswer in
//        DispatchQueue.main.async {
//          self.accumulateQuestionAnswered(question_id: question.id, hasAnswer: hasAnswer)
//        }
//      })
//    }
//  }
//}
//
//struct PollDetailView_Previews: PreviewProvider {
//  static var previews: some View {
//    PollDetailView(poll: Poll(id: "1", user_id: "1", title: "Who is your favorite IS Professor?", description: "Nyo", posted_at: "2019-10-24", link: "", is_private: false, is_closed: false))
//  }
//}


//
//  PollDetailView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/11/04.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI

struct PollDetailView: View {
  let profile = Image("user_pic")
  let uploaderName = "Aiden Lee"
  let uploaderMajor = "Information Systems"
  let uploaderGraduationYear: String = "2020"
  let uploadedDaysAgo = "29"
  let poll: Poll
  
  @State var tags = [Tag]()
  @State var questions = [Question]()
  @State var likes = [Like]()
  @State var pollUser: User?
  @State var questionAnswered = [String: Bool]()
  @State var accumulatedQuestionAnswered = [String: Bool]()
  @State var userAlreadyLiked: Bool = false
  
  
  
  var body: some View {
    List {
      if (pollUser != nil) {
        PollUploaderProfileView(uploaderName: "\(pollUser!.first_name) \(pollUser!.last_name)", uploaderMajor: pollUser!.major, uploaderGraduationYear: String(pollUser!.graduation_year ?? 2020), uploadedDaysAgo: uploadedDaysAgo)
      }
      
      HStack(alignment: .firstTextBaseline) {
        Text(poll.title)
          .fontWeight(.semibold)
          .multilineTextAlignment(.leading)
          .font(Font.system(size: 20, design: .default))
          .lineSpacing(10)
        
        Spacer()
        
        
        
        if !self.userAlreadyLiked {
          Button(action: {
            print("like button is clicked!")
            print("here, likes: \(self.likes)")
            
            self.addLike()
            self.getPollLikes()
          }) {
            Image(systemName: "hand.thumbsup")
              .foregroundColor(.gray)
              .frame(width: CGFloat(20.0), height: CGFloat(20.0)
                ,alignment: .bottomLeading)
            
            
            Text("Like")
              .fontWeight(.regular)
              .foregroundColor(Color.gray)
              .font(Font.system(size: 10, design: .default))
          }
        }
        else {
          Button(action: {
            print("like button is unclicked!")
            print("here, likes: \(self.likes)")
            
            self.deleteLike()
            self.getPollLikes()
          }) {
            Image(systemName: "hand.thumbsup.fill")
              .foregroundColor(.gray)
              .frame(width: CGFloat(20.0), height: CGFloat(20.0)
                ,alignment: .bottomLeading)
            
            Text("Unlike")
              .fontWeight(.regular)
              .foregroundColor(Color.gray)
              .font(Font.system(size: 10, design: .default))
          }
        }
        
        
        
      }
      HStack(alignment: .firstTextBaseline, spacing: 5) {
        ForEach(self.tags) { tag in
          TagView(tagText: tag.name)
        }
      }
      PollDetailDescriptionView(description: poll.description)
      Text(verbatim: "You will get 5 point per questions that you answered")
        .font(Font.system(size: 12, design: .default))
        .fontWeight(.semibold)
        .foregroundColor(Color(red: 236 / 255.0, green: 0 / 255.0, blue: 0 / 255.0))
      if !self.questionAnswered.isEmpty {
        ForEach(self.questions) { question in
          if self.questionAnswered[question.id] == true {
            AnswerGraphView(question: question, onEditedAnswer: {
              self.questionAnswered[question.id] = false
            })
          } else {
            AnswerBoxView(question: question, onNewAnswer: {
              self.questionAnswered[question.id] = true
            })
          }
        }
      }
    }
    .frame(minWidth: 0, maxWidth: .infinity, idealHeight: 188.0, alignment: .center)
    .padding(.vertical, 25)
    .padding(.horizontal, 15)
    .onAppear {
      self.getPollTags()
      self.getPollQuestions()
      self.getPollUser()
      self.getPollLikes()
      
    }
  }
  
  func getPollTags() {
    self.poll.tags(completion: { tags in
      DispatchQueue.main.async {
        self.tags = tags
      }
    })
  }
  
  func getPollQuestions() {
    self.poll.questions(completion: { questions in
      DispatchQueue.main.async {
        self.questions = questions
        self.getQuestionAnswered()
      }
    })
  }
  
  func getPollUser() {
    self.poll.user(completion: { user in
      DispatchQueue.main.async {
        self.pollUser = user
      }
    })
  }
  
  
  func getPollLikes() {
    self.poll.likes(completion: { likes in
      DispatchQueue.main.async {
        self.likes = likes
        print("currently, self likes is \(self.likes)")
        let temp = self.likes.filter {$0.user_id == User.current?.id}
        if temp.isEmpty {
          self.userAlreadyLiked = false
        }
        else {
          self.userAlreadyLiked = true
        }
      }
    })
  }
  
  func addLike() {
    Like.create(poll_id: self.poll.id, completion: { like in })
  }
  
  func deleteLike() {
    let temp = self.likes.filter {$0.user_id == User.current?.id}
    if temp.isEmpty {
      print("current user did not like this poll yet!")
    }
    else {
      print("the like has been deleted!")
      temp[0].delete(completion: { () in }
      )
    }
  }
  
  
  
  
  
  
  func accumulateQuestionAnswered(question_id: String, hasAnswer: Bool) {
    accumulatedQuestionAnswered[question_id] = hasAnswer
    if (accumulatedQuestionAnswered.count >= self.questions.count) {
      self.questionAnswered = self.accumulatedQuestionAnswered
    }
  }
  
  func getQuestionAnswered() {
    self.accumulatedQuestionAnswered = [:]
    for question in self.questions {
      question.userHasAnswer(completion: { hasAnswer in
        DispatchQueue.main.async {
          self.accumulateQuestionAnswered(question_id: question.id, hasAnswer: hasAnswer)
        }
      })
    }
  }
}

struct PollDetailView_Previews: PreviewProvider {
  static var previews: some View {
    PollDetailView(poll: Poll(id: "1", user_id: "1", title: "Who is your favorite IS Professor?", description: "Nyo", posted_at: "2019-10-24", link: "", is_private: false, is_closed: false))
  }
}


