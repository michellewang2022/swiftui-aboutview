//
//  FeedbackView.swift
//  givefeedback
//
//  Created by tim on 10/27/22.
//

import SwiftUI

@available(iOS 16, *)
public enum FeedbackType {
    case Positive
    case Negative
    case Suggestion
}

@available(iOS 16, *)
public struct FeedbackView: View {
    @State var feedback: FeedbackType
    @State var description: String = ""
    @State var email: String = ""
    @State var isShowing: Bool = false
    @State var documents: [URL] = []
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var onSendFeedback: (String, String, [URL]) -> Void = {  description, email, attachments in
        print("No onSendFeedback() was implemented, description: \(description), email: \(email)")
    }
    
    func SendFeedback() {
        onSendFeedback( description, email, documents)
        self.presentationMode.wrappedValue.dismiss()
    }
    
    public init(feedback:FeedbackType,onSendFeedback: @escaping (String, String, [URL]) -> Void) {
        _feedback = State(initialValue: feedback)
        _onSendFeedback = State(initialValue: onSendFeedback)
    }
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading)  {
                if feedback == .Positive {
                    Text("What do you like the most?")
                        .fontWeight(.black)
                        .padding(.leading)
                } else if feedback == .Negative {
                    Text("Tell us more about your problem?")
                        .fontWeight(.black)
                        .padding(.leading)
                } else if feedback == .Suggestion {
                    Text("How can we make the app better?")
                        .fontWeight(.black)
                        .padding(.leading)
                }
                
                VStack(alignment: .leading) {
                    Text("Description")
                    TextEditor(text: $description)
                        .frame(minHeight:100, maxHeight: 100)
                        .border(Color.gray)
                        .onReceive(description.publisher.collect()) {
                            description = String($0.prefix(200))
                        }
                    Text("200 Max Chars (\(description.count) of 200)")
                        .font(Font.footnote)
                    
                    Text("Attachments").padding(.top)
                    ForEach(documents, id: \.self) { doc in
                        HStack {
                            Text(doc.lastPathComponent)
                                .font(Font.footnote)
                                .fontWeight(.black)
                            Button("X", action: {
                                documents.removeAll(where: {$0 == doc})
                            })
                        }
                        
                    }
                    
                    Button(action: {
                        isShowing = true
                    }, label: {
                        VStack {
                            HStack {
                                Spacer()
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width:25,height:25)
                                Spacer()
                            }.padding(.top)
                            Text("Upload a document/image")
                                .padding(.bottom)
                        }
                        .border(Color.gray)
                    })
                    
                    Text("Email").padding([.top])
                    TextField("Enter your email here", text: $email)
                        .keyboardType(.emailAddress)
                        .padding()
                        .border(Color.gray)
                }.padding()
                HStack
                {
                    Spacer()
                    Button("Send Feedback", action: SendFeedback)
                    .frame(width:180, height:50)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding()
                    Spacer()
                }
                Spacer()
                
            }.fileImporter(isPresented: $isShowing, allowedContentTypes: [.item], allowsMultipleSelection: true, onCompletion: { results in
                
                switch results {
                case .success(let fileurls):
                    print(fileurls.count)
                    
                    for fileurl in fileurls {
                        documents.append(fileurl)
                        print(fileurl.path)
                    }
                    
                case .failure(let error):
                    print(error)
                }
                
            })
        }
    }
}


