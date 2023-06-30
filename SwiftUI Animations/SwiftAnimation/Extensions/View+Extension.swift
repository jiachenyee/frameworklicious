//
//  View+Extension.swift
//  SwiftAnimation
//
//  Created by Bisma Mahendra I Dewa Gede on 26/06/23.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
