//
//  Message.swift
//  ConfirmationButton
//
//  Created by Nitin Bhatia on 12/01/26.
//

import Foundation

struct Message: Identifiable, Hashable {
    let id = UUID()
    let sender: String
    let preview: String
    let time: String
    let isUnread: Bool
}

let SAMPLE_MESSAGES: [Message] = [
    Message(sender: "Alice", preview: "Hey, are we still on for today?", time: "9:12 AM", isUnread: true),
    Message(sender: "Bob", preview: "I’ve pushed the latest changes to the repo.", time: "8:45 AM", isUnread: false),
    Message(sender: "Charlie", preview: "Can you review my PR when you get time?", time: "Yesterday", isUnread: true),
    Message(sender: "Diana", preview: "Meeting moved to 3 PM.", time: "Yesterday", isUnread: false),
    Message(sender: "Ethan", preview: "Thanks for the quick help!", time: "Yesterday", isUnread: false),
    Message(sender: "Fiona", preview: "The designs are finalized.", time: "2 days ago", isUnread: true),
    Message(sender: "George", preview: "Let’s sync up tomorrow.", time: "2 days ago", isUnread: false),
    Message(sender: "Hannah", preview: "Invoice has been sent.", time: "3 days ago", isUnread: false),
    Message(sender: "Ian", preview: "Any update on the task?", time: "3 days ago", isUnread: true),
    Message(sender: "Julia", preview: "Great presentation today 👏", time: "4 days ago", isUnread: false),
    Message(sender: "Kevin", preview: "Can you share the document?", time: "4 days ago", isUnread: false),
    Message(sender: "Laura", preview: "I’ll be out of office tomorrow.", time: "5 days ago", isUnread: true),
    Message(sender: "Mike", preview: "Bug fixed in latest build.", time: "5 days ago", isUnread: false),
    Message(sender: "Nina", preview: "Let me know your thoughts.", time: "6 days ago", isUnread: false),
    Message(sender: "Oscar", preview: "Reminder about the deadline.", time: "6 days ago", isUnread: true),
    Message(sender: "Priya", preview: "Happy to help anytime!", time: "1 week ago", isUnread: false),
    Message(sender: "Quinn", preview: "Please check the updated schedule.", time: "1 week ago", isUnread: false),
    Message(sender: "Ravi", preview: "Can we reschedule our call?", time: "1 week ago", isUnread: true),
    Message(sender: "Sophia", preview: "Welcome to the team 🎉", time: "1 week ago", isUnread: false),
    Message(sender: "Tom", preview: "See you soon.", time: "2 weeks ago", isUnread: false)
]
