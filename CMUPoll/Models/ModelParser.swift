//
//  ModelParser.swift
//  CMUPoll
//
//  Created by Sung on 11/2/19.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import Foundation
import SwiftUI

enum Collection: String, CaseIterable {
    case user, poll, question, like, comment, polltag, tag, option, answer
}

class ModelParser {
  
  static func parse(collection: Collection, data: [FirebaseData]) -> [Any] {
    var result: [Any] = []
    
    for obj in data {      
      switch collection {
      case .poll:
        let id: String = "\(String(describing: obj["id"]!))"
        let user_id: String = "\(String(describing: obj["user_id"]!))"
        let title: String = obj["title"] as! String
        let description: String = obj["description"] as! String
        let posted_at: String = obj["posted_at"] as! String
//        let link: String = (obj["link"] ?? "") as! String // Disabled
        let is_private: Bool = obj["private"] as! Bool
        let is_closed: Bool = obj["closed"] as! Bool
        var passcode: String?
        if obj["passcode"] == nil {
          passcode = nil
        } else if "\(String(describing: obj["passcode"]!))" == "<null>" {
          passcode = nil
        } else {
          passcode = "\(String(describing: obj["passcode"]!))"
        }
        let poll = Poll(id: id, user_id: user_id, title: title, description: description, posted_at: posted_at, link: "", is_private: is_private, is_closed: is_closed, passcode: passcode)
        result.append(poll)
        break
        
      case .like:
        let id: String = "\(String(describing: obj["id"]!))"
        let user_id: String = "\(String(describing: obj["user_id"]!))"
        let poll_id: String = "\(String(describing: obj["poll_id"]!))"
        let like = Like(id: id, user_id: user_id, poll_id: poll_id)
        result.append(like)
        break
        
      case .user:
        let id: String = "\(String(describing: obj["id"]!))"
        let first_name: String = obj["first_name"] as! String
        let last_name: String = obj["last_name"] as! String
        let email: String = obj["email"] as! String
        let major: String = obj["major"] as! String
        let graduation_year: Int? = obj["graduation_year"] == nil ? nil : Int("\(String(describing: obj["graduation_year"]!))")
        let points: Int? = Int("\(String(describing: obj["points"]!))")
        let user = User(id: id, first_name: first_name, last_name: last_name, email: email, major: major, graduation_year: graduation_year, points: points)
        result.append(user)
        break
        
      case .comment:
        let id: String = "\(String(describing: obj["id"]!))"
        let content: String = obj["content"] as! String
        let posted_at: String = obj["posted_at"] as! String
        let user_id: String = "\(String(describing: obj["user_id"]!))"
        var comment_id: String?
        if obj["comment_id"] == nil {
          comment_id = nil
        } else if "\(String(describing: obj["comment_id"]!))" == "<null>" {
          comment_id = nil
        } else {
          comment_id = "\(String(describing: obj["comment_id"]!))"
        }
        let poll_id: String = "\(String(describing: obj["poll_id"]!))"
        let comment = Comment(id: id, content: content, posted_at: posted_at, user_id: user_id, comment_id: comment_id, poll_id: poll_id)
        result.append(comment)
        break
        
      case .polltag:
        let id: String = "\(String(describing: obj["id"]!))"
        let poll_id: String = "\(String(describing: obj["poll_id"]!))"
        let tag_id: String = "\(String(describing: obj["tag_id"]!))"
        let polltag = PollTag(id: id, poll_id: poll_id, tag_id: tag_id)
        result.append(polltag)
        break
        
      case .tag:
        let id: String = "\(String(describing: obj["id"]!))"
        let name: String = obj["name"] as! String
        let tag = Tag(id: id, name: name)
        result.append(tag)
        break
        
      case .question:
        let id: String = "\(String(describing: obj["id"]!))"
        let is_multiple_choice: Bool = obj["is_multiple_choice"] as! Bool
        let title: String = obj["title"] as! String
        let poll_id: String = "\(String(describing: obj["poll_id"]!))"
        let question = Question(id: id, is_multiple_choice: is_multiple_choice, title: title, poll_id: poll_id)
        result.append(question)
        break
        
      case .answer:
        let id: String = "\(String(describing: obj["id"]!))"
        let user_id: String = "\(String(describing: obj["user_id"]!))"
        let question_id: String = "\(String(describing: obj["question_id"]!))"
        let option_id: String = "\(String(describing: obj["option_id"]!))"
        let answer = Answer(id: id, user_id: user_id, question_id: question_id, option_id: option_id)
        result.append(answer)
        break
        
      case .option:
        let id: String = "\(String(describing: obj["id"]!))"
        let text: String = obj["text"] as! String
        let question_id: String = "\(String(describing: obj["question_id"]!))"
        let option = Option(id: id, text: text, question_id: question_id)
        result.append(option)
        break
      }
    }
    return result
  }
}
