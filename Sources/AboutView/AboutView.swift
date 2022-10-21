//
//  AboutView.swift
//  about
//
//  Created by tim on 10/20/22.
//

import SwiftUI
import UIKit

@available(iOS 14, *)
public struct AboutView: View {
    @State var appIcon: UIImage
    @State var appName: String
    @State var appVersion: String
    @State var isDeveloperMode: Bool
    @State var licenseText: String
    @State var privacyText: String
    @State var opensourceText: String
    @State var acknowledgementsText: String
    
    @State var onDeveloperModeChanged: (Bool) -> Void 
    
    public init(appName: String, appIcon: UIImage, appVersion: String , isDeveloperMode: Bool, licenseText: String, privacyText: String, opensourceText: String, acknowledgementsText:String, onDeveloperModeChanged: @escaping  (Bool) -> Void) {
        
        _appName = State(initialValue: appName)
        _appIcon = State(initialValue: appIcon)
        _appVersion = State(initialValue: appVersion)
        _isDeveloperMode = State(initialValue: isDeveloperMode)
        _licenseText = State(initialValue: licenseText)
        _privacyText = State(initialValue: privacyText)
        _opensourceText = State(initialValue: opensourceText)
        _acknowledgementsText = State(initialValue: acknowledgementsText)
        _onDeveloperModeChanged = State(initialValue: onDeveloperModeChanged)
    }
    
    public var body: some View {
        NavigationView {
            VStack {
            
                // Product name & Icon
                Image(uiImage: appIcon)
                    .resizable()
                    .frame(width:50,height:50)
                
                Text(appName).fontWeight(.black)
                
                // Version & Build number
                Text(appVersion)
                
                List {
                    // License agreement
                    // Privacy agreement
                    // Open source packages
                    // 3rd Party Notices
                    
                    if licenseText != "" {
                        NavigationLink(destination: ScrollView { Text(licenseText) }, label: { Text("License Agreement")} )
                    }
                    if privacyText != "" {
                        NavigationLink(destination: ScrollView { Text(privacyText) }, label: { Text("Privacy Agreement")} )
                    }
                    if opensourceText != "" {
                        NavigationLink(destination: ScrollView { Text(opensourceText) }, label: { Text("Open Source")} )
                    }
                    if acknowledgementsText != "" {
                        NavigationLink(destination: ScrollView { Text(acknowledgementsText) }, label: { Text("Acknowledgements")} )
                    }
                    
            
                }
                 
                // Developer Mode
                Toggle(isOn: $isDeveloperMode) {
                    Text("Developer Mode")
                }.padding()
                    
                Spacer()
            }.navigationTitle("About")
                .navigationBarTitleDisplayMode(.inline)
        }.onChange(of: isDeveloperMode, perform: { newvalue in
            onDeveloperModeChanged(newvalue)
        })
    }
}
