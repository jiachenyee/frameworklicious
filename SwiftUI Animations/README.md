#  SwiftUI Animation

To implement an animation in SwiftUI, we need the following three elements:

- A timing curve algorithm function
- A declaration that associates the state (specific dependency) with the timing curve function
- An animatable component that depends on the state (specific dependency)

Animation modifier respect the preceding one instead of the latest one
This means the order of the modifier matters a lot which may make 
the animation behave differently than what intended

## Official Guiding Resource:
1. [Apple Doc - SwiftUI Animation](https://developer.apple.com/documentation/swiftui/animations)
2. [WWDC23 - Animate With Spring](https://developer.apple.com/wwdc23/10158)
3. [Apple Tutorial - Animating Views and Transitions](https://developer.apple.com/tutorials/swiftui/animating-views-and-transitions)

## Non-Official Guiding Resource:
1. [Demystifying SwiftUI Animation: A Comprehensive Guide](https://betterprogramming.pub/swiftui-animation-mechanism-a1adf2b9b417)
2. [Youtube - Kavsoft](https://www.youtube.com/@Kavsoft)
