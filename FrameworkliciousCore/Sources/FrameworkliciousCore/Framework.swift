//
//  File.swift
//  
//
//  Created by Jia Chen Yee on 09/06/23.
//

import SwiftUI
import CoreLocation
@available(iOS 16.0, *)
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public enum Framework {
    case healthKit
    case speech
    case machineLearning
    case vision
    case watch
    case multipeerConnectivity
    case shareplay
    case coreHaptics
    case siriKit
    case messages
    case coreLocation
    case liveActivities
    case pencilKit
    case coreMotion
    case gameKit
    case swiftUIAnimations
    case augmentedReality
    
    public var name: String {
        switch self {
        case .healthKit:
            return "HealthKit"
        case .speech:
            return "Speech"
        case .machineLearning:
            return "Machine Learning"
        case .vision:
            return "Vision"
        case .watch:
            return "Apple Watch"
        case .multipeerConnectivity:
            return "Multipeer Connectivity"
        case .shareplay:
            return "SharePlay"
        case .coreHaptics:
            return "CoreHaptics"
        case .siriKit:
            return "SiriKit"
        case .messages:
            return "Messages"
        case .coreLocation:
            return "CoreLocation"
        case .liveActivities:
            return "Live Activities"
        case .pencilKit:
            return "PencilKit"
        case .coreMotion:
            return "CoreMotion"
        case .gameKit:
            return "GameKit"
        case .swiftUIAnimations:
            return "SwiftUI Animations"
        case .augmentedReality:
            return "Augmented Reality"
        }
    }
    
    public var subtitle: String {
        switch self {
        case .healthKit:
            return "Integrate with the Health App"
        case .speech:
            return "Perform speech recognition on audio"
        case .machineLearning:
            return "Create intelligent features by leveraging on-device machine learning"
        case .vision:
            return "Apply computer vision algorithms on images and videos"
        case .watch:
            return "Implement communication between an iOS app a watchOS app"
        case .multipeerConnectivity:
            return "Support connectivity and the discovery of nearby devices"
        case .shareplay:
            return "Create activities your users can share and experience together"
        case .coreHaptics:
            return "Compose and play haptic patterns to customize your iOS app’s haptic feedback"
        case .siriKit:
            return "Allow users to interact with their devices through voice, intelligent suggestions, and personalized workflows"
        case .messages:
            return "Create apps that allow users to send text, stickers, media files, and interactive messages"
        case .coreLocation:
            return "Obtain the geographic location and orientation of a device"
        case .liveActivities:
            return "Extend the reach of your app by creating widgets, watch complications, and Live Activities"
        case .pencilKit:
            return "Capture touch and Apple Pencil input as a drawing, and display that content from your app"
        case .coreMotion:
            return "Process accelerometer, gyroscope, pedometer, and environment-related events"
        case .gameKit:
            return "Enable players to interact with friends, compare leaderboard ranks, earn achievements, and participate in multiplayer games"
        case .swiftUIAnimations:
            return "Build stunning animations that bring your app to life in SwiftUI."
        case .augmentedReality:
            return "Integrate hardware sensing features to produce augmented reality apps and games."
        }
    }
    
    public var icon: String {
        switch self {
        case .healthKit:
            return "heart.text.square"
        case .speech:
            return "waveform"
        case .machineLearning:
            return "brain.head.profile"
        case .vision:
            return "eye"
        case .watch:
            return "applewatch"
        case .multipeerConnectivity:
            return "antenna.radiowaves.left.and.right"
        case .shareplay:
            return "shareplay"
        case .coreHaptics:
            return "iphone.gen3.radiowaves.left.and.right"
        case .siriKit:
            return "mic"
        case .messages:
            return "message"
        case .coreLocation:
            return "location"
        case .liveActivities:
            return "platter.filled.top.iphone"
        case .pencilKit:
            return "scribble.variable"
        case .coreMotion:
            return "move.3d"
        case .gameKit:
            return "gamecontroller"
        case .swiftUIAnimations:
            return "figure.walk.motion"
        case .augmentedReality:
            return "arkit"
        }
    }
    
    public var color: Color {
        switch self {
        case .healthKit:
            return .red
        case .speech:
            return .yellow
        case .machineLearning:
            return .teal
        case .vision:
            return .blue
        case .watch:
            return .teal
        case .multipeerConnectivity:
            return .mint
        case .shareplay:
            return .green
        case .coreHaptics:
            return .mint
        case .siriKit:
            return .purple
        case .messages:
            return .green
        case .coreLocation:
            return .blue
        case .liveActivities:
            return .pink
        case .pencilKit:
            return .orange
        case .coreMotion:
            return .green
        case .gameKit:
            return .purple
        case .swiftUIAnimations:
            return .blue
        case .augmentedReality:
            return .orange
        }
    }
    
    public var description: String {
        switch self {
        case .healthKit:
            return "HealthKit provides a central repository for health and fitness data on iPhone and Apple Watch. With the user’s permission, apps can access and share the user's health data allowing them to create personalized health and fitness experiences.\n\nHealthKit apps take a collaborative approach to building this experience. Your app doesn’t need to provide all of these features. Instead, you can focus just on the subset of tasks that most interests you."
        case .speech:
            return "The Speech framework recognizes spoken words in recorded or live audio. The iOS keyboard’s dictation functionality uses this framework to translate audio content into text.\n\nYou may use speech recognition to recognize verbal commands or to handle text dictation in other parts of your app."
        case .machineLearning:
            return "Core ML applies a provided machine learning algorithm to a set of training data to create a model. Model can be used to make predictions based on new input data.\n\nModels can accomplish a wide variety of tasks that would be difficult or impractical to write in code. For example, you can train a model to categorize photos, or detect specific objects within a photo directly from its pixels, or even create AI-generated images on iPhone."
        case .vision:
            return "The Vision framework performs face detection, text detection, barcode recognition, image registration, and general feature tracking.\n\nVision also allows the use of custom machine learning models for tasks like classification or object detection."
        case .watch:
            return "Transfer data between your iOS app and a watchOS app. You can pass small amounts of data or entire files. You also use this framework to trigger an update to your watchOS app's complication."
        case .multipeerConnectivity:
            return "The Multipeer Connectivity framework allows nearby devices to communicate with one another. This allows you to share message-based data, streaming data, and resources (such as files) between devices.\n\nThe framework uses infrastructure Wi-Fi networks, peer-to-peer Wi-Fi, and Bluetooth personal area networks for the underlying transport."
        case .shareplay:
            return "SharePlay lets people share experiences while connecting in a FaceTime call or a Messages conversation. With this framework, you can bring movies, TV, music, games, workouts, and other shared activities from your app into a space where people are already connecting with each other."
        case .coreHaptics:
            return "Core Haptics lets you add customized haptic and audio feedback to your app. Use haptics to engage users physically, with tactile and audio feedback that gets attention and reinforces actions.\n\nSome system-provided interface elements—like pickers, switches, and sliders—automatically provide haptic feedback as users interact with them."
        case .siriKit:
            return "This framework drives interactions that start with “Hey Siri…” and Shortcuts actions. This allows you to extend the functionality of Siri and Shortcuts by integrating your app into it."
        case .messages:
            return "The Messages framework allows you to create sticker packs and iMessage apps.\n\nSticker packs provide static sets of stickers, images that users can send inline as messages or peel off and attach to message bubbles in the transcript. Sticker packs don’t require any code.\n\niMessage apps allow you to create custom user interfaces within iMessage and send text, stickers, media files, or custom interactive messages."
        case .coreLocation:
            return "Core Location provides services that determine a device’s geographic location, altitude, and orientation, or its position relative to a nearby iBeacon device.\n\nThe framework gathers data using all available components on the device, including the Wi-Fi, GPS, Bluetooth, magnetometer, barometer, and cellular hardware."
        case .liveActivities:
            return "Using WidgetKit, you can make your app’s content available in contexts outside the app and extend its reach by building an ecosystem of glanceable, up-to-date experiences through widgets, watch complications, and live activities."
        case .pencilKit:
            return "PencilKit makes it easy to incorporate hand-drawn content into your apps. PencilKit provides a canvas for uesrs to draw with an Apple Pencil or their finger. The environment comes with tools for creating, erasing, and selecting lines. You can even inspect, edit, and export PencilKit drawings."
        case .coreMotion:
            return "Core Motion reports motion- and environment-related data from the onboard hardware, including from the accelerometers and gyroscopes, and from the pedometer, magnetometer, and barometer.\n\nYou use this framework to access hardware-generated data so that you can use it in your app. For example, a game might use accelerometer and gyroscope data to control onscreen game behavior."
        case .gameKit:
            return "GameKit allows you to implement Game Center social-gaming network features. Game Center is an Apple service that provides a single account that identifies players across all their games and devices. After players sign in to Game Center on their device, they can access their friends and use Game Center features you implement."
        case .swiftUIAnimations:
            return "You tell SwiftUI how to draw your app’s user interface for different states, and then rely on SwiftUI to make interface updates when the state changes."
        case .augmentedReality:
            return "Augmented reality (AR) describes user experiences that add 2D or 3D elements to the live view from a device’s sensors in a way that makes those elements appear to inhabit the real world. ARKit/RealityKit combines device motion tracking, world tracking, scene understanding, and display conveniences to simplify building an AR experience."
        }
    }
    
    static let all: [Self] = [
        .healthKit,
        .speech,
        .machineLearning,
        .vision,
        .watch,
        .multipeerConnectivity,
        .shareplay,
        .coreHaptics,
        .siriKit,
        .messages,
        .coreLocation,
        .liveActivities,
        .pencilKit,
        .coreMotion,
        .gameKit
    ]
    
    // Index used for iBeacon
    var index: UInt16 {
        UInt16(Self.all.firstIndex(of: self)!)
    }
}
