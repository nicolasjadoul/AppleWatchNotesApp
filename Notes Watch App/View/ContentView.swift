//
//  ContentView.swift
//  Notes Watch App
//
//  Created by Jadoul Nicolas on 13/05/2023.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("lineCount") var lineCount: Int = 1
    @State private var notes: [Note] = [Note]()
    @State private var text: String = ""
    
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func save() {
//        dump(notes)
        do {
            // 1. Convert the notes array to data using JSONEncoder
            let data = try JSONEncoder().encode(notes)
          
            // 2. Create a new URL to save the file using the getDocumentDirectory
            let url = getDocumentDirectory().appendingPathComponent("notes")
          
            // 3. Write the data to the given URL
            try data.write(to: url)
            } catch {
                print("Saving data has failed!")
            }

    }
    
    func load() {
        DispatchQueue.main.async {
          do {
            // 1. Get the notes URL path
            let url = getDocumentDirectory().appendingPathComponent("notes")
            
            // 2. Create a new property for the data
            let data = try Data(contentsOf: url)
            
            // 3. Decode the data
            notes = try JSONDecoder().decode([Note].self, from: data)
          } catch {
            // Do nothing
          }
        }
    }
    
    func delete(offsets: IndexSet) {
        withAnimation {
          notes.remove(atOffsets: offsets)
          save()
        }
      }

    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .center, spacing: 6) {
                    TextField("Add New Note", text: $text)
                    Button {
                        guard text.isEmpty == false else { return }
                        let note = Note(id: UUID(), text: text)
                        notes.append(note)
                        text = ""
                        save()
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold))
                    }
                    .fixedSize()
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(.accentColor)
    //                .buttonStyle(BorderedButtonStyle(tint: .accentColor))
                }
                Spacer()
                
                if notes.count >= 1 {
                    List {
                        ForEach(0..<notes.count, id: \.self) { i in
                                    NavigationLink(destination: DetailView(note: notes[i], count: notes.count, index: i)) {
                                      HStack {
                                        Capsule()
                                          .frame(width: 4)
                                          .foregroundColor(.accentColor)
                                        Text(notes[i].text)
                                          .lineLimit(lineCount)
                                          .padding(.leading, 5)
                                      }
                                    } //: HSTACK
                                  } //: LOOP
                        .onDelete { IndexSet in
                            delete(offsets: IndexSet)
                        }
                    }
                } else {
                    Spacer()
                    Image(systemName: "note.text")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .opacity(0.7)
                        .padding(25)
                    Spacer()
                }
            }
            .navigationTitle("Notes")
            .onAppear {
                load()
        }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
