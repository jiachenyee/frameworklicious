//
//  AnimationConfiguration.swift
//  SwiftAnimation
//
//  Created by Bisma Mahendra I Dewa Gede on 23/06/23.
//

import SwiftUI

protocol AnimationConfiguration {
    var duration: String { get set }
    var response: String { get set }
    var dampingFraction: String { get set }
    var delay: String { get set }
    var speed: String { get set }
    var repeatCount: String { get set }
    var repeatMode: Repeat { get set }
}
