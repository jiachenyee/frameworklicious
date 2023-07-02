//
//  ContentView.swift
//  Rainbows
//
//  Created by Rizaldi Septian Fauzi on 25/06/23.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    
    @State private var showAlert = false
    @State private var showResult = false
    
    @State private var warna = ["abu-abu", "coklat",
//                                "merah", "oranye",
                                "kuning", "hijau", "biru", "ping", "ungu"]
    @State private var answer = ["abu-abu" : "gray", "coklat" : "brown", "merah" : "red", "oranye" : "orange", "kuning" : "yellow", "hijau" : "green", "biru" : "blue", "ping" : "pink", "ungu" : "purple"]
    @State private var colors = ["gray", "brown", "red", "orange", "yellow", "green", "blue", "pink", "purple"]
    
    @State private var score = 0
    
    @State private var color = "red"
    @State private var bgColor = "white"
    @State private var fontColor = "black"
    
    @StateObject var sttManager = SpeechToTextManager()
    
    let synthesizer = AVSpeechSynthesizer()
    
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var counter: Double = 0
    
   
    
    func getRandomString(array : [String]) -> String {
        let randomIndex = Int.random(in: 0..<array.count)
        return array[randomIndex]
    }
    
    func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "id-ID") // Atur sesuai dengan bahasa yang diinginkan
        synthesizer.speak(utterance)
    }
    
    var body: some View {
        ZStack{
            Color(bgColor).ignoresSafeArea()
            VStack {
                Text(self.color).font(.system(.largeTitle)).fontWeight(.black).hidden()
                Spacer()
                Text("You said : \(sttManager.text)")
                Text("Score : \(self.score)")
                Text("Time  : \(Int(self.counter)) seconds")
            }.font(.system(.title3)).fontWeight(.bold).foregroundColor(Color(fontColor))
                .padding()
        }.alert("Terjemahkan warna yang disebutkan!", isPresented: $showAlert) {
            Button("Mulai", role: .cancel){
                color = getRandomString(array: warna)
                speak(text: color)
                bgColor = getRandomString(array: colors)
                fontColor = getRandomString(array: colors)
                while bgColor == fontColor {
                    fontColor = getRandomString(array: colors)
                }
                sttManager.reset()
                sttManager.recordAndRecognizeSpeech()
            }
        }.onChange(of: sttManager.text, perform: { newValue in
            if colors.contains(sttManager.text){
                if sttManager.text == answer[color]{
                    self.score += 1
                    color = getRandomString(array: warna)
                    speak(text: color)
                    bgColor = getRandomString(array: colors)
                    fontColor = getRandomString(array: colors)
                    while bgColor == fontColor {
                        fontColor = getRandomString(array: colors)
                    }
                    sttManager.reset()
                    sttManager.recordAndRecognizeSpeech()
                } else {
                    showResult.toggle()

                }
            }
        }).alert("""
                Final Score  : \(self.score) colors
                Time Consume : \(Int(self.counter)) seconds
                """, isPresented: $showResult) {
            Button("Selesai", role: .cancel){
                sttManager.reset()
            }
        }
                .onAppear{
                    showAlert.toggle()
                    sttManager.requestAuth()
                }.onReceive(timer) { input in
                    counter += 1
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
