//
//  Data.swift
//  DynamicFloatSheetLikeFamilyApp
//
//  Created by Nitin Bhatia on 08/03/25.
//

import SwiftUI

struct Action: Identifiable, Hashable {
    var id: UUID = UUID()
    var image: String
    var title: String
}

let actions: [Action] = [
    .init(image: "xbox.logo", title: "Game Pass"),
    .init(image: "playstation.logo", title: "PS Plus"),
    .init(image: "apple.logo", title: "iCloud"),
    .init(image: "appletv.fill", title: "Apple TV")
]

struct Period: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var value: Int
}

let periods: [Period] = [
    .init(title: "1", value: 1),
    .init(title: "3", value: 3),
    .init(title: "5", value: 5),
    .init(title: "7", value: 7),
    .init(title: "9", value: 9),
    .init(title: "Custom", value: 0)
]

struct KeyPad: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var value: Int
    var isBack: Bool = false
}

let keypadValue: [KeyPad] = (1...9).compactMap({.init(title: String("\($0)"), value: $0)}) + [
    .init(title: "0", value: 0),
    .init(title: "chevron.left", value: -1, isBack: true)
]
