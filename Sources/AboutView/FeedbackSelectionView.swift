//
//  FeedbackSelectionView.swift
//  givefeedback
//
//  Created by tim on 10/31/22.
//

import SwiftUI

@available(iOS 14, *)
public struct FeedbackSelectionView: View {
    @State var onSendFeedback: (FeedbackType, String, String, [URL])->Void = { feedback, description, email, attachments in
        print("FeedbackSelectionView.onSendFeedback() called with no implementation")
    }
    
    public init(onSendFeedback: @escaping (FeedbackType, String, String, [URL])->Void) {
        _onSendFeedback = State(initialValue: onSendFeedback)
    }
    
    public var body: some View {
        
        NavigationView {
            List {
                NavigationLink(destination:
                    FeedbackView(feedback: .Positive, onSendFeedback: { description, email, attachments in
                    onSendFeedback(.Positive, description, email, attachments)
                }), label: {
                    HStack {
                        Image(systemName: "hand.thumbsup")
                        Text("Something I Like")
                    }
                })
                
                NavigationLink(destination:
                    FeedbackView(feedback: .Negative, onSendFeedback: {  description, email, attachments in
                    onSendFeedback(.Negative, description, email, attachments)
                }), label: {
                    HStack {
                        Image(systemName: "hand.thumbsdown")
                        Text("Something I don't Like")
                    }
                })
                
                NavigationLink(destination:
                    FeedbackView(feedback: .Suggestion, onSendFeedback: { description, email, attachments in
                    onSendFeedback(.Suggestion, description, email, attachments)
                }), label: {
                    HStack {
                        Image(systemName: "face.smiling")
                        Text("Recommend a feature")
                    }
                })
        
            }.navigationTitle("Give Feedback")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
