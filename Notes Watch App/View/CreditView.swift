//
//  CreditView.swift
//  Notes Watch App
//
//  Created by Jadoul Nicolas on 14/05/2023.
//

import SwiftUI

struct CreditView: View {
  // MARK: - PROPERTY
  @State private var randomNumber: Int = Int.random(in: 1..<4)
  
  private var randomImage: String {
    return "developer-no\(randomNumber)"
  }

  // MARK: - BODY

  var body: some View {
    VStack(spacing: 3) {
      // PROFILE IMAGE
      Image(randomImage)
        .resizable()
        .scaledToFit()
        .layoutPriority(1)
      
      // HEADER
      HeaderView(title: "Credits")
      
      // CONTENT
      Text("Nicolas Jadoul")
        .foregroundColor(.primary)
        .fontWeight(.bold)
      
      Text("Developer")
        .font(.footnote)
        .foregroundColor(.secondary)
        .fontWeight(.light)
    } //: VSTACK
  }
}

struct CreditView_Previews: PreviewProvider {
    static var previews: some View {
        CreditView()
    }
}
