//
//  ContentView.swift
//  Notes WatchKit Extension
//
//  Created by Andre Abtahi on 8/15/21.
//

import SwiftUI

struct ContentView: View {
    
    //  MARK: - PROPERTY
    
    @AppStorage("lineCount") var lineCount: Int = 1
    
    @State private var notes: [Note] = [Note]()
    @State private var text: String = ""
    // test
    
    //  MARK: - FUNCTION
    
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func save(){
        // Dumps giving object's content in the console.
        
        //dump(notes)
        
        do {
        //HOW TO WRITE DATA TO APPLE WATCH
            
            // 1. Convert notes array to data using JSONEncoder
            let data = try JSONEncoder().encode(notes)
            
            // 2. Create a new url to save the file using the getDocumentDirectory
            let url = getDocumentDirectory().appendingPathComponent("notes")
            
            // 3. Write the data to the given url
            try data.write(to: url)
            
        } catch{
            print("Saving data has failed")
        }
        
    }// SAVE FUNCTION
    
    func load(){
        
        /*
         SUMMARY
         
         An object that manages the execution of tasks serially or concurrently on your app's main thread or on a background thread.
         
         Part of apple framework called ground central dispatch.
         This method tells watchOS to run the actions at the next possible opportunity that isn't right now.
         We will run these actions and change the programs state will milisec delay to prevent crashing app
         */
        DispatchQueue.main.async {
            do {
                // 1. Get notes url path
                let url = getDocumentDirectory().appendingPathComponent("notes")
                
                // 2. Create new property for the data
                let data = try Data(contentsOf: url)
                
                // 3. Decode the data
                notes = try JSONDecoder().decode([Note].self, from: data)
            } catch{
                // Do nada since there is no data on watch
            }
        }// DISPATCH QUEUE
        
    }// LOAD FUNCTION
    
    func delete(offsets: IndexSet){
        notes.remove(atOffsets: offsets)
        save()
    }// DELETE FUNCTION
    //  MARK: - BODY
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 6){
                TextField("Add New Note", text: $text)
                Button(action: {
                    // 1. Only run button's action when text field is not empty
                    guard text.isEmpty == false else{ return }
                    
                    // 2. Create a new note item and initialize with text value
                    let note = Note(id: UUID(), text: text)
                    
                    // 3. add the new note item to the notes array (append)
                    notes.append(note)
                    
                    // 4. Make the text field empty
                    text = ""
                    
                    // 5. Save the notes (function)
                    save()
                    
                }, label: {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 42, weight: .semibold))
                })// BUTTON
                .fixedSize()
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(.accentColor)
                //.buttonStyle(BorderedButtonStyle(tint: .accentColor)) - creates a border and padding. Design more strict.
            }// HSTACK
            Spacer() // pushes HSTACK up
            
            if notes.count >= 1 {
                List{
                    ForEach(0..<notes.count, id: \.self ){ i in
                        NavigationLink(
                            destination: DetailView(note: notes[i], count: notes.count, index: i)){
                            HStack{
                                Capsule()
                                    .frame(width: 4)
                                    .foregroundColor(.accentColor)
                                Text(notes[i].text)
                                    .lineLimit(lineCount)
                                    .padding(.leading, 5)
                            }
                        }// HSTACK
                    }// LOOOOOP
                    .onDelete(perform: delete)
                }
            } else {
                Spacer()
                Image(systemName: "note.text")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                    .opacity(0.25)
                    .padding(25)
                Spacer()
            }// LIST
            
        }// VSTACK
        .navigationTitle("Notes")
        .onAppear(perform: {
            load()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
