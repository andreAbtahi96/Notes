//
//  SettingsView.swift
//  Notes WatchKit Extension
//
//  Created by Andre Abtahi on 8/16/21.
//

import SwiftUI

struct SettingsView: View {
    //  MARK: - PROPERTY
    /*
     App storage uses user defaults under the hood. Major benefit is: auto reinvokes the view's body property when line count changes. Refreshing user interface.
     */
    @AppStorage("lineCount") var lineCount: Int = 1
    @State private var value: Float = 1.0
    
    //  MARK: - FUNCTION
    func update(){
        lineCount = Int(value)
    }
    
    //  MARK: - BODY
    var body: some View {
        VStack(spacing: 8){
            
            // HEADER
            HeaderView(title: "Settings")
            //Spacer()
            
            // CURRENT LINE COUNT
            Text("Lines \(lineCount)".uppercased())
                .fontWeight(.bold)
            
            // SLIDER
            /*
             Custom binding with read and write binding value. on one hand the get
             closure has no parameters and returns a value. On other hand, the set
             closure has new parameter "newValue" for binding value
             */
            Slider(value: Binding(get: {
                self.value
            }, set: {(newValue) in
                self.value = newValue
                self.update()
            }), in: 1...4, step: 1) // END OF SLIDER
                .accentColor(.accentColor)
            
        }// VSTACK
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
