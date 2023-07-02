//
//  SpeechToText.swift
//  Rainbows
//
//  Created by Rizaldi Septian Fauzi on 25/06/23.
//

import Foundation
import SwiftUI
import AVFoundation
import Speech

class SpeechToTextManager: ObservableObject {
    @Published var text: String = ""
    
    var audioEngine = AVAudioEngine()
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    let speechRecognizer = SFSpeechRecognizer()
    
    func stopRecording()  {
        audioEngine.stop()
    }
    
    func reset() {
        audioEngine = AVAudioEngine()
    }
    
    func requestAuth(){
        // Make the authorization request
           SFSpeechRecognizer.requestAuthorization { authStatus in


           // The authorization status results in changes to the
           // app’s interface, so process the results on the app’s
           // main queue.
              OperationQueue.main.addOperation {
                 switch authStatus {
                    case .authorized:
                     print("authorized")
//                       self.recordButton.isEnabled = true


                    case .denied:
                     print("denied")
//                       self.recordButton.isEnabled = false
//                       self.recordButton.setTitle("User denied access
//                                   to speech recognition", for: .disabled)


                    case .restricted:
                     print("restricted")
//                       self.recordButton.isEnabled = false
//                       self.recordButton.setTitle("Speech recognition
//                               restricted on this device", for: .disabled)


                    case .notDetermined:
                     print("notDetermined")
//                       self.recordButton.isEnabled = false
//                       self.recordButton.setTitle("Speech recognition not yet
//                                              authorized", for: .disabled)
                 @unknown default:
                     print("do nothing")
                 }
              }
           }
    }
    
    func recordAndRecognizeSpeech()  {
        audioEngine.stop()
        // setup audio engine and recognition request
        var text = ""
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            
            let inputNode = audioEngine.inputNode
            recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create a recognition request") }
            recognitionRequest.shouldReportPartialResults = true
            
            recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { result, error in
                guard let result = result else {
                    if let error = error {
                        print("Recognition error: \(error)")
                    }
                    return
                }
                
                // update recognized text
                var recognizedText = result.bestTranscription.formattedString
                DispatchQueue.main.async {
                    text = recognizedText
                    print(text)
                    recognizedText = ""
                    let tokens = text.split(separator: " ").map { String($0) }
                    print(tokens)
                    if tokens.count > 0 {
                        print(tokens[tokens.count-1] )
                        self.text = tokens[tokens.count-1].lowercased()
                    }
                    
                }
            })
            
            // start audio engine and recognition task
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
                recognitionRequest.append(buffer)
            }
            audioEngine.prepare()
            try audioEngine.start()
        } catch {
            print("Error setting up audio session: \(error)")
        }
        
        print(self.text)
        //return text
    }
}
