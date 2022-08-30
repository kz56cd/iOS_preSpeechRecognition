//
//  ContentView.swift
//  preSpeechRecognition
//
//  Created by Masakazu Sano on 2022/07/29.
//

import SwiftUI
import Speech
import AVFoundation

struct ContentView: View {
    
    @State var button01Text = "record"
    @State var isEnabledButton01 = true
    @State var button01Color: Color = .blue
    @State var button02Text = "stop"
    @State var button02Color: Color = .blue

    @State var speachText = "-"
    
    // MARK: - for Speech
    let speechRecgnizer = SFSpeechRecognizer(locale: .init(identifier: "ja_JP"))!
    let audioEngine = AVAudioEngine()
    @State var recognitionReq: SFSpeechAudioBufferRecognitionRequest?
    @State var recognitionTask: SFSpeechRecognitionTask?
    
    var body: some View {
        VStack {
            Spacer()
            Text(speachText)
            Spacer()
            Button(
                action: {
                    button01Text = "recording..."
                    button01Color = .red
                },
                label: {
                    Text(button01Text)
                        .font(.largeTitle)
                        .foregroundColor(button01Color)
                }
            )
            Spacer()
                .frame(height: 50)
            Button(
                action: {
                    button01Text = "record"
                    button01Color = .blue
                    self.stopLiveTranscription()
                },
                label: {
                    Text(button02Text)
                        .font(.largeTitle)
                        .foregroundColor(button02Color)
                }
            )
        }
        .onAppear {
            SFSpeechRecognizer.requestAuthorization { authStatus in
                DispatchQueue.main.async {
                    if authStatus != SFSpeechRecognizerAuthorizationStatus.authorized {
                        // TODO:
                        // ref: https://swift-ios.keicode.com/ios/speechrecognition-live.php
                        
                        
                        
                        
                        // 許可の状態に応じて UI を更新する
                        OperationQueue.main.addOperation {
                            switch authStatus {
                            case .authorized:
                                print("authorized")
                                // 「発話してください」アラートを出すなどの処理
                                isEnabledButton01 = true
                                return
                            case .denied:
                                print("denied")
                                // 拒否された時の処理
                            case .restricted:
                                print("denied")
                                // 制限を知らせるアラートを出すなどの処理
                            case .notDetermined:
                                print("notDetermined")
                                // 許可を求めるアラートを出すなどの処理
                            default:
                                break
                            }
                            isEnabledButton01 = false
                            
                        }
                    }
                }
            }
        }
    }
}
    
extension ContentView {
    private func startLiveTranscription() throws {
        // 前回の音声認識タスクが実行中ならキャンセルする
        if let recognitionTask = recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }
        speachText = "-"
        
        recognitionReq = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionReq = recognitionReq else { return }
        recognitionReq.shouldReportPartialResults = true
    
        // オーディオセッションを設定
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers) // TODO: 引数要確認
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputMode = audioEngine.inputNode
        
        // マイク入力を設定
        let recordingFormat = inputMode.outputFormat(forBus: 0)
        inputMode.installTap(
            onBus: 0,
            bufferSize: 2048,
            format: recordingFormat
        ) { buffer, _ in
            recognitionReq.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
        
        recognitionTask = speechRecgnizer.recognitionTask(
            with: recognitionReq,
            resultHandler: { result, error in
                if let error = error {
                    print("[recognitionTask result] error: ", error)
                    return
                }
                DispatchQueue.main.async {
                    speachText = result?.bestTranscription.formattedString ?? "<<< Fail to transcription >>>"
                }
            }
        )
    }
    
    private func stopLiveTranscription() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionReq?.endAudio()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
