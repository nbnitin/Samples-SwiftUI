//
//  ReactionPicker.swift
//  ReactionPickerParticleEffect
//
//  Created by Nitin Bhatia on 31/08/26.
//

enum EmojiList {
    static let all: [Character] = [
        // MARK: - Positive / Approval
        "👍", "👎", "👌", "✌️", "🤞", "🤟", "🤘", "🤙",
        "👏", "🙌", "🫶", "💪", "🙏", "👊", "✊",
        "💯", "✅", "✔️", "⭐", "🌟", "🏆",

        // MARK: - Love / Affection
        "❤️", "🩷", "🧡", "💛", "💚", "💙", "🩵", "💜",
        "🤎", "🖤", "🩶", "🤍", "💔", "💕", "💞", "💓",
        "💗", "💖", "💘", "💝", "💟", "❣️", "😘", "🥰",
        "😍", "🫰",

        // MARK: - Happy / Joy
        "😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣",
        "😊", "😇", "🙂", "🙃", "😉", "😌", "😋", "😛",
        "😝", "😜", "🤪", "🤩", "🥳", "😎", "😏", "😺",
        "😸", "😹", "😻", "😽", "🙀", "😹",

        // MARK: - Laughing / Funny
        "😂", "🤣", "😆", "😹", "😄", "😁", "😅", "🤭",
        "🫢", "🫣", "🤪", "😜", "😝", "😛", "😏", "🙃",

        // MARK: - Love / Cute
        "🥰", "😍", "😘", "😚", "😙", "😗", "☺️", "😊",
        "😇", "🥹", "🫶", "💋", "💐", "🌹", "🌸", "🦋",

        // MARK: - Excitement / Celebration
        "🎉", "🎊", "🥳", "🤩", "🔥", "✨", "💥", "🎆",
        "🎇", "🎈", "🪅", "🏅", "🏆", "🥇", "🥳", "🙌",
        "👏", "💃", "🕺", "🍾",

        // MARK: - Thinking / Unsure
        "🤔", "🧐", "🤨", "😐", "😑", "😶", "🫥", "🙄",
        "😏", "🤷", "🤷‍♂️", "🤷‍♀️", "🤦", "🤦‍♂️", "🤦‍♀️",

        // MARK: - Surprise / Shock
        "😮", "😯", "😲", "😳", "🤯", "😱", "😨", "😰",
        "😦", "😧", "😵", "🫨", "😱", "🙀",

        // MARK: - Sad / Disappointed
        "😔", "😞", "😟", "😕", "🙁", "☹️", "😣", "😖",
        "😫", "😩", "🥺", "😢", "😭", "💔", "😿", "🙍",
        "🙍‍♂️", "🙍‍♀️",

        // MARK: - Angry / Frustrated
        "😤", "😠", "😡", "🤬", "💢", "😾", "👿", "😈",
        "🤯", "💥", "🔥",

        // MARK: - Confused / Awkward
        "😕", "🤔", "🤨", "🧐", "😐", "😑", "😬", "🙃",
        "😶", "🫥", "🫠", "🤐", "🤥", "😵",

        // MARK: - Cool / Confidence
        "😎", "🤠", "🥸", "😏", "🤑", "🤩", "😈", "👑",
        "💪", "🔥", "⚡", "💯",

        // MARK: - Agreement / Acknowledgement
        "👍", "👌", "✅", "✔️", "☑️", "💯", "🙌", "👏",
        "🤝", "🫡", "🙏", "👊", "✊", "💪",

        // MARK: - Thanks / Appreciation
        "🙏", "❤️", "🫶", "🥰", "😊", "☺️", "👏", "🙌",
        "💐", "🌷", "🌹", "💝", "✨", "⭐",

        // MARK: - Greetings
        "👋", "🤚", "🖐️", "✋", "🤝", "🙋", "🙋‍♂️", "🙋‍♀️",
        "😊", "🙂", "😄",

        // MARK: - Party / Fun
        "🥳", "🎉", "🎊", "🎈", "🎂", "🍰", "🥂", "🍻",
        "🎵", "🎶", "🎸", "🎤", "🎧", "🪩", "💃", "🕺",

        // MARK: - Fire / Hype
        "🔥", "💥", "⚡", "🚀", "💯", "✨", "🌟", "⭐",
        "🏆", "👑", "💪", "🤩",

        // MARK: - Cute / Playful
        "🥰", "😊", "😇", "🥹", "😻", "😽", "🙈", "🙉",
        "🙊", "🐶", "🐱", "🐻", "🐼", "🦄", "🦋",

        // MARK: - Common Reaction Symbols
        "❤️", "💔", "💯", "🔥", "✨", "⭐", "🌟", "💥",
        "💫", "💢", "❗", "❓", "‼️", "⁉️", "⚠️",
        "✅", "❌", "⭕", "➕", "➖", "💡",

        // MARK: - Food / Drink Reactions
        "☕", "🍕", "🍔", "🍟", "🍺", "🍻", "🥂", "🍾",
        "🍰", "🎂", "🍪", "🍩", "🍫", "🍿",

        // MARK: - Miscellaneous
        "💤", "💭", "👀", "🫣", "🫢", "🤫", "🤭", "🙈",
        "💅", "💁", "💁‍♂️", "💁‍♀️", "🤌", "🫰", "☝️",
        "👇", "👉", "👈", "👀", "🗣️"
    ]
}

import SwiftUI

struct ReactionPicker<Label: View>: View {
    @Binding var forcePopOver: Bool
    @Binding var addInsertButton: Bool
    @State var reactions: [Character]
    @Binding var selectedReaction: Character?
    @ViewBuilder var label: Label
    var onInsertTapped: () -> () = {}
    @State private var showPopover: Bool = false
    @State private var showEmojiPicker: Bool = false
    @Namespace private var animation
    // Using availability check because AnyNavigationTransition is not a valid type; NavigationTransition is only available in newer OS versions.
    var body: some View {
        label
            .contentShape(.capsule)
            .matchedTransitionSource(id: "SOURCE", in: animation)
            .glassEffect(.regular.interactive(), in: .capsule)
            .overlay{
                GeometryReader{
                    ParticleEmitterAnimator($0.size)
                }
            }
            .onTapGesture {
                showPopover = true
            }
            .popover(isPresented: $showPopover) {
                ReactionsView(forcePopOver: forcePopOver, addInsertButton: addInsertButton, reactions: reactions){ reactions in
                    selectedReaction = reactions
                    showPopover = false
                } onInsertTapped: {
                    // Keep the reactions popover open or close it before presenting the picker
                    showPopover = false
                    showEmojiPicker = true
                    onInsertTapped()
                }
                .presentationCompactAdaptation(.popover)
                .ifAvailableNavigationTransition(forcePopOver: forcePopOver, animation: animation)
            }
            .sheet(isPresented: $showEmojiPicker) {
                EmojiAutoGridPickerView(recent: reactions) { emoji in
                    reactions.removeAll(where: { $0 == emoji })
                    reactions.insert(emoji, at: 0)
                    showEmojiPicker = false
                } onCancel: {
                    showEmojiPicker = false
                }
            }
    }
    ///Particle Emiiter Effect
    @ViewBuilder
    private func ParticleEmitterAnimator(_ size: CGSize) -> some View {
        let count: Int = 10
        let duration: CGFloat = 2.0
        let fontSize: CGFloat = size.height / 2
        KeyframeAnimator(initialValue: CGFloat.zero, trigger: selectedReaction) { progress in
            ZStack {
                ForEach(0 ..< count, id: \.self) {index in
                    let currentProgress = progress < CGFloat(index) ? 0 : min(progress - CGFloat(index), 4)
                    let opacity = currentProgress > 3 ? (currentProgress - 3) / 1: 0
                    let scaleProgress = currentProgress < 0.5 ? (currentProgress / 0.5) : 1
                    Text(String(selectedReaction ?? "❤️"))
                        .font(.system(size: fontSize))
                        .opacity(1 - opacity)
                        .scaleEffect(scaleProgress, anchor: .bottom)
                        .offset(x: index % 2 == 0 ? -fontSize / 2: fontSize / 2)
                        .offset(y: currentProgress * -35)
                }
            }
            
        } keyframes: { _ in
            MoveKeyframe(0)
            LinearKeyframe(CGFloat(count + 3), duration: duration)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .offset(y: -fontSize)
    }
}

fileprivate struct ReactionsView: View {
    var forcePopOver: Bool
    var addInsertButton: Bool
    var reactions: [Character]
    var onTap: (Character) -> ()
    var onInsertTapped: () -> ()
    @State private var isAnimated: Bool = false
    @State private var staggeredContent: [Character] = []
    var body: some View {
        let limited = Array(reactions.prefix(addInsertButton ? 5 : 6))
        HStack(spacing: 0) {
            ForEach(limited, id: \.self) { reaction in
                let isVisible = staggeredContent.contains(reaction)
                Text(String(reaction))
                    .font(.system(size: 26))
                    .scaleEffect(isVisible ? 1 : 0.01, anchor: .leading)
                    .frame(width: 60, height: 45)
                    .contentShape(.rect)
                    .onTapGesture {
                        onTap(reaction)
                    }
            }
            if (addInsertButton) {
                let isVisible = staggeredContent.contains("+")
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 26))
                    .foregroundStyle(.gray)
                    .scaleEffect(isVisible ? 1 : 0.01, anchor: .leading)
                    .frame(width: 60, height: 45)
                    .contentShape(.rect)
                    .onTapGesture {
                        onInsertTapped()
                    }
            }
        }
        .padding(.horizontal, 5)
        .task {
            guard !isAnimated else {return}
            isAnimated = true
            let reactions = limited + (addInsertButton ? ["+"] : [])
            try? await Task.sleep(for: .seconds(forcePopOver ? 0.08 : 0.15))
            for (index, reaction) in reactions.enumerated() {
                let delay = Double(index) * (forcePopOver ? 0.015 : 0.03) //delay to display reactions in popover
                try? await Task.sleep(for: .seconds(delay))
                withAnimation(.spring(response: 0.4, dampingFraction: 0.4, blendDuration: 0)) {
                    staggeredContent.append(reaction)
                }
            }
            
        }
    }
}

private extension View {
    @ViewBuilder
    func ifAvailableNavigationTransition(forcePopOver: Bool, animation: Namespace.ID) -> some View {
        if #available(iOS 18.0, macOS 15.0, visionOS 2.0, *) {
            if forcePopOver {
                self.navigationTransition(.automatic)
            } else {
                self.navigationTransition(.zoom(sourceID: "SOURCE", in: animation))
            }
        } else {
            self
        }
    }
}

fileprivate struct EmojiAutoGridPickerView: View {
    let recent: [Character]
    let onSelect: (Character) -> Void
    let onCancel: () -> Void

    @State private var allEmojis: [Character] = []

    private let columns: [GridItem] = Array(repeating: GridItem(.flexible(minimum: 36, maximum: 60), spacing: 10), count: 7)

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if !recent.isEmpty {
                        Text("Recent")
                            .font(.headline)
                            .padding(.horizontal)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(recent.prefix(12), id: \.self) { emoji in
                                    Button {
                                        onSelect(emoji)
                                    } label: {
                                        Text(String(emoji))
                                            .font(.system(size: 28))
                                            .frame(width: 44, height: 44)
                                            .contentShape(.rect)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }

                    Text("All")
                        .font(.headline)
                        .padding(.horizontal)

                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(allEmojis, id: \.self) { emoji in
                            Button {
                                onSelect(emoji)
                            } label: {
                                Text(String(emoji))
                                    .font(.system(size: 24))
                                    .frame(width: 36, height: 36)
                                    .contentShape(.rect)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 12)
            }
            .navigationTitle("Add Emoji")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { onCancel() }
                }
            }
            .task {
                if allEmojis.isEmpty {
                    allEmojis = emojis() //generateEmojis()
                }
            }
        }
    }

//    private func generateEmojis() -> [Character] {
//        // Curate by scanning a few well-known Unicode ranges that contain many emoji.
//        // This avoids shipping a hardcoded list while keeping performance reasonable.
//        var set: [Character] = []
//        func appendRange(_ range: ClosedRange<Int>) {
//            for cp in range {
//                if let scalar = UnicodeScalar(cp), scalar.properties.isEmoji { set.append(Character(scalar)) }
//            }
//        }
//        // Common emoji blocks
//        appendRange(0x1F600...0x1F64F) // Emoticons
//        appendRange(0x1F300...0x1F5FF) // Misc Symbols and Pictographs
//        appendRange(0x1F680...0x1F6FF) // Transport and Map
//        appendRange(0x2600...0x26FF)   // Misc symbols
//        appendRange(0x2700...0x27BF)   // Dingbats
//        appendRange(0x1F900...0x1F9FF) // Supplemental Symbols and Pictographs
//        appendRange(0x1FA70...0x1FAFF) // Symbols and Pictographs Extended-A
//
//        // Remove non-rendering or odd items, keep unique and sort by scalar value for stable layout
//        var unique: [Character] = []
//        var seen = Set<Character>()
//        for ch in set where !seen.contains(ch) {
//            seen.insert(ch)
//            unique.append(ch)
//        }
//        return unique
//    }
    
    private func emojis() -> [Character] {
        EmojiList.all
    }
}

#Preview {
    ContentView()
}
