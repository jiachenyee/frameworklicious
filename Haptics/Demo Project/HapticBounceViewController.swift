/*
This demo is adopted from Official Apple Demo Project named: HapticBounce.
*/

import UIKit

import CoreHaptics
import CoreMotion

class HapticBounceViewController: UIViewController, UICollisionBehaviorDelegate {
    
    // View: A single circular view to represent the sphere.
    private var sphereView: UIView!
    
    // The sphere's radius matches the screen's corner radius.
    private let kSphereRadius: CGFloat = 72
    
    // Haptic Engine & State:
    private var engine: CHHapticEngine!
    private var engineNeedsStart = true
    
    // Animator:
    private var animator: UIDynamicAnimator!
    
    // Behaviors to give the sphere physical realism:
    private var gravity: UIGravityBehavior!
    private var wallCollisions: UICollisionBehavior!
    private var bounce: UIDynamicItemBehavior!
    
    // Managing motion data from the accelerometer & gyroscope:
    private var motionManager: CMMotionManager!
    private var motionQueue: OperationQueue!
    private var motionData: CMAccelerometerData!
    private let kMaxVelocity: Float = 500
    
    private var foregroundToken: NSObjectProtocol?
    private var backgroundToken: NSObjectProtocol?
    
    lazy var supportsHaptics: Bool = {
        return CHHapticEngine.capabilitiesForHardware().supportsHaptics
    }()
    
    // Track the screen dimensions:
    lazy var windowWidth: CGFloat = {
        return UIScreen.main.bounds.size.width
    }()
    
    lazy var windowHeight: CGFloat = {
        return UIScreen.main.bounds.size.height
    }()
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        // Create & configure the engine before doing anything else, since the game begins immediately.
        createAndStartHapticEngine()
        
        initializeSphere()
        initializeWalls()
        initializeBounce()
        initializeGravity()
        initializeAnimator()
        activateAccelerometer()
        
        addObservers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        engine.stop()
    }
    
    
    private func createAndStartHapticEngine() {
        guard supportsHaptics else { return }
        
        // Create and configure a haptic engine.
        do {
            engine = try CHHapticEngine()
        } catch let error {
            fatalError("Engine Creation Error: \(error)")
        }
        
        // The stopped handler alerts engine stoppage.
        engine.stoppedHandler = { reason in
            print("Stop Handler: The engine stopped for reason: \(reason.rawValue)")
            switch reason {
            case .audioSessionInterrupt:
                print("Audio session interrupt.")
            case .applicationSuspended:
                print("Application suspended.")
            case .idleTimeout:
                print("Idle timeout.")
            case .notifyWhenFinished:
                print("Finished.")
            case .systemError:
                print("System error.")
            case .engineDestroyed:
                print("Engine destroyed.")
            case .gameControllerDisconnect:
                print("Controller disconnected.")
            @unknown default:
                print("Unknown error")
            }
            
            // Indicate that the next time the app requires a haptic, the app must call engine.start().
            self.engineNeedsStart = true
        }
        
        // The reset handler notifies the app that it must reload all its content.
        // If necessary, it recreates all players and restarts the engine in response to a server restart.
        engine.resetHandler = {
            print("The engine reset --> Restarting now!")
            
            // Tell the rest of the app to start the engine the next time a haptic is necessary.
            self.engineNeedsStart = true
        }
        
        // Start haptic engine to prepare for use.
        do {
            try engine.start()
            
            // Indicate that the next time the app requires a haptic, the app doesn't need to call engine.start().
            engineNeedsStart = false
        } catch let error {
            print("The engine failed to start with error: \(error)")
        }
    }
    
    private func initializeSphere() {
        
        // Place sphere at the center of the screen to start.
        let sphereSize = kSphereRadius
        let xStart = floor((windowWidth - sphereSize) / 2)
        let yStart = floor((windowHeight - sphereSize) / 2)
        let frame = CGRect(x: xStart, y: yStart, width: sphereSize, height: sphereSize)
        
        sphereView = UIView(frame: frame)
        sphereView.layer.cornerRadius = sphereSize / 2
        sphereView.layer.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
        view.addSubview(sphereView)
    }
    
    /// - Tag: DefineWalls
    private func initializeWalls() {
        wallCollisions = UICollisionBehavior(items: [sphereView])
        wallCollisions.collisionDelegate = self
        
        // Express walls using vertices.
        let upperLeft = CGPoint(x: -1, y: -1)
        let upperRight = CGPoint(x: windowWidth + 1, y: -1)
        let lowerRight = CGPoint(x: windowWidth + 1, y: windowHeight + 1)
        let lowerLeft = CGPoint(x: -1, y: windowHeight + 1)
        
        // Each wall is a straight line shifted one pixel offscreen, to give an impression of existing at the boundary.
        
        // Left edge of the screen:
        wallCollisions.addBoundary(withIdentifier: NSString("leftWall"),
                                   from: upperLeft,
                                   to: lowerLeft)
        
        // Right edge of the screen:
        wallCollisions.addBoundary(withIdentifier: NSString("rightWall"),
                                   from: upperRight,
                                   to: lowerRight)
        
        // Top edge of the screen:
        wallCollisions.addBoundary(withIdentifier: NSString("topWall"),
                                   from: upperLeft,
                                   to: upperRight)
        
        // Bottom edge of the screen:
        wallCollisions.addBoundary(withIdentifier: NSString("bottomWall"),
                                   from: lowerRight,
                                   to: lowerLeft)
        
    }
    
    // Each bounce against the wall is a dynamic item behavior, which lets you tweak the elasticity to match the haptic effect.
    private func initializeBounce() {
        bounce = UIDynamicItemBehavior(items: [sphereView])
        
        // Increase the elasticity to make the sphere bounce higher.
        bounce.elasticity = 0.5
    }
    
    // Represent gravity as a behavior in UIKit Dynamics:
    private func initializeGravity() {
        gravity = UIGravityBehavior(items: [sphereView])
    }
    
    /// - Tag: DefineAnimator
    // The animator ties together the gravity, sphere, and wall, so the dynamics framework is aware of all the components.
    private func initializeAnimator() {
        animator = UIDynamicAnimator(referenceView: view)
        
        // Add bounce, gravity, and collision behavior.
        animator.addBehavior(bounce)
        animator.addBehavior(gravity)
        animator.addBehavior(wallCollisions)
    }
    
    /// - Tag: ActivateAccelerometer
    private func activateAccelerometer() {
        // Manage motion events in a separate queue off the main thread.
        motionQueue = OperationQueue()
        motionData = CMAccelerometerData()
        motionManager = CMMotionManager()
        
        guard let manager = motionManager else { return }
        
        manager.startDeviceMotionUpdates(to: motionQueue) { deviceMotion, error in
            guard let motion = deviceMotion else { return }
            
            let gravity = motion.gravity
            
            // Dispatch gravity updates to main queue, since they affect UI.
            DispatchQueue.main.async {
                self.gravity.gravityDirection = CGVector(dx: gravity.x * 3.5,
                                                         dy: -gravity.y * 3.5)
            }
        }
    }
    
    private func addObservers() {

        backgroundToken = NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification,
                                                                 object: nil,
                                                                 queue: nil) { [weak self] _ in
            guard let self = self, self.supportsHaptics else { return }
            
            // Stop the haptic engine.
            self.engine.stop { error in
                if let error = error {
                    print("Haptic Engine Shutdown Error: \(error)")
                    return
                }
                self.engineNeedsStart = true
            }

        }

        foregroundToken = NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification,
                                                                 object: nil,
                                                                 queue: nil) { [weak self] _ in
            guard let self = self, self.supportsHaptics else { return }
                                                                    
            // Restart the haptic engine.
            self.engine.start { error in
                if let error = error {
                    print("Haptic Engine Startup Error: \(error)")
                    return
                }
                self.engineNeedsStart = false
            }
        }
    }
    
    // pragma mark - UICollisionBehaviorDelegate
    
    /// - Tag: MapVelocity
    func collisionBehavior(_ behavior: UICollisionBehavior,
                           beganContactFor item: UIDynamicItem,
                           withBoundaryIdentifier identifier: NSCopying?,
                           at point: CGPoint) {
        // Play collision haptic for supported devices.
        guard supportsHaptics else { return }
        
        // Play haptic here.
        do {
            // Start the engine if necessary.
            if engineNeedsStart {
                try engine.start()
                engineNeedsStart = false
            }
            
            // Map the bounce velocity to intensity & sharpness.
            let velocity = bounce.linearVelocity(for: item)
            let xVelocity = Float(velocity.x)
            let yVelocity = Float(velocity.y)
            
            // Normalize magnitude to map one number to haptic parameters:
            let magnitude = sqrtf(xVelocity * xVelocity + yVelocity * yVelocity)
            let normalizedMagnitude = min(max(Float(magnitude) / kMaxVelocity, 0.0), 1.0)
            
            // Create a haptic pattern player from normalized magnitude.
            let hapticPlayer = try playerForMagnitude(normalizedMagnitude)
            
            // Start player, fire and forget
            try hapticPlayer?.start(atTime: CHHapticTimeImmediate)
        } catch let error {
            print("Haptic Playback Error: \(error)")
        }
    }
    
    private func playerForMagnitude(_ magnitude: Float) throws -> CHHapticPatternPlayer? {
        let volume = linearInterpolation(alpha: magnitude, min: 0.1, max: 0.4)
        let decay: Float = linearInterpolation(alpha: magnitude, min: 0.0, max: 0.1)
        let audioEvent = CHHapticEvent(eventType: .audioContinuous, parameters: [
            CHHapticEventParameter(parameterID: .audioPitch, value: -0.15),
            CHHapticEventParameter(parameterID: .audioVolume, value: volume),
            CHHapticEventParameter(parameterID: .decayTime, value: decay),
            CHHapticEventParameter(parameterID: .sustained, value: 0)
        ], relativeTime: 0)
        
        let sharpness = linearInterpolation(alpha: magnitude, min: 0.9, max: 0.5)
        let intensity = linearInterpolation(alpha: magnitude, min: 0.375, max: 1.0)
        let hapticEvent = CHHapticEvent(eventType: .hapticTransient, parameters: [
            CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness),
            CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity)
        ], relativeTime: 0)
        
        let pattern = try CHHapticPattern(events: [audioEvent, hapticEvent], parameters: [])
        return try engine.makePlayer(with: pattern)
    }
    
    private func linearInterpolation(alpha: Float, min: Float, max: Float) -> Float {
        return min + alpha * (max - min)
    }
}
