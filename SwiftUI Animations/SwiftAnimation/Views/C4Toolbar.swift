//
//  C4Toolbar.swift
//  SwiftAnimation
//
//  Created by Bisma Mahendra I Dewa Gede on 28/06/23.
//

import SwiftUI

struct C4Toolbar<Leading:View, Trailing:View>: View {
    let leading: (() -> Leading)?
    let title: String
    let trailing: (() -> Trailing)?
    
    init(title: String
    ) where Leading == AnyView, Trailing == AnyView {
        self.leading = nil
        self.title = title
        self.trailing = nil
    }
    
    init(title: String, @ViewBuilder trailing: @escaping () -> Trailing
    ) where Leading == AnyView {
        self.leading = nil
        self.title = title
        self.trailing = trailing
    }
    
    init(@ViewBuilder leading: @escaping () -> Leading, title: String
    ) where Trailing == AnyView {
        self.leading = leading
        self.title = title
        self.trailing = nil
    }
    
    init(@ViewBuilder leading: @escaping () -> Leading, title: String, @ViewBuilder trailing: @escaping () -> Trailing
    ) {
        self.leading = leading
        self.title = title
        self.trailing = trailing
    }
    
    var body: some View {
        VStack {
            //Toolbar Item
            //TODO: find better way to style
            Grid {
                GridRow() {
                    // TODO: find way to have grid better
                    HStack {
                        if let leading = leading {
                            leading()
                        } else {
                            Text("")
                        }
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text(title)
                            .font(.headline)
                    }
                    
                    HStack() {
                        Spacer()
                        
                        if let trailing = trailing {
                            trailing()
                        } else {
                            Text("")
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .padding(.bottom, 8)
            
            Divider()
        }
    }
}

struct C4Toolbar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            C4Toolbar(leading: {
                Text("HIWHIWHIW")
            }, title: "Text")

            C4Toolbar(title: "Textdwoadowakod")
            
            C4Toolbar(leading: {
                Text("HIWHIWHIW")
            }, title: "Text") {
                Button {

                } label: {
                    Text("HEHEHE")
                }

            }
        }
    }
}
