//
//  CreditsView.swift
//  Notes WatchKit Extension
//
//  Created by Andre Abtahi on 8/16/21.
//

import SwiftUI

struct CreditsView: View {
    //  MARK: - PROPERTIES
    //range from 1-3
    @State private var randomNumber: Int = Int.random(in: 1..<4)
    private var randomImage: String{
        return "developer-no\(randomNumber)"
    }
    //  MARK: - BODY
    var body: some View {
        VStack(spacing: 3){
            // PROFILE IMAGE
            Image("me")
                .resizable()
                .scaledToFit()
                .layoutPriority(1)
                .cornerRadius(10)
            // HEADER
            HeaderView(title: "Credits")
            
            // CONTENT
            Text("Andre Abtahi")
                .foregroundColor(.primary)
                .fontWeight(.bold)
            
            Text("Developer")
                .font(.footnote)
                .foregroundColor(.secondary)
                .fontWeight(.light)
        }// VSTACK
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}
