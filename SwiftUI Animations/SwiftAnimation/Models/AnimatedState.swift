//
//  AnimatedState.swift
//  SwiftAnimation
//
//  Created by Bisma Mahendra I Dewa Gede on 22/06/23.
//

import Foundation

struct AnimatedState<State>: AnimatedValue {
    var before: State
    var after: State
}
