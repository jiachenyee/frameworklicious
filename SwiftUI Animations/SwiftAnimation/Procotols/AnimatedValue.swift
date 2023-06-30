//
//  AnimatedState.swift
//  SwiftAnimation
//
//  Created by Bisma Mahendra I Dewa Gede on 22/06/23.
//

import SwiftUI

protocol AnimatedValue {
    associatedtype State
    
    var before: State { get set }
    var after: State { get set }
}
