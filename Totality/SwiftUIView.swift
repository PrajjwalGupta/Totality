//
//  SwiftUIView.swift
//  Totality
//
//  Created by Prajjawal Gupta on 13/06/22.
//

import SwiftUI

struct SwiftUIView: View {
    
    @State var isCompleted: Bool = false
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            VStack {
                GroupBox() {
                    DisclosureGroup("") {
                        HStack {
                            Button {
                                
                            } label: {
                                Text("Copy")
                            }

                            Button {
                                
                            } label: {
                                Text("Delete")
                            }

                        }
                        
                    }
                    
                }
                
//                Image(systemName: isCompleted ? "chevron.up" : "chevron.down")
//                    .font(.title)
//                    .onTapGesture {
//                        isCompleted.toggle()
//                }

            }

        }.padding()
            .frame(width: 200, height: 0)
            .background(Color.red.opacity(0.1))
            //.frame(maxWidth: .infinity)
            
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
            .previewLayout(.sizeThatFits)
    }
}
