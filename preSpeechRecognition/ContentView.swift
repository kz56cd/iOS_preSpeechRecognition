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
    
    @State private var button01Text = "record"
    @State private var isEnabledButton01 = true
    @State private var button01Color: Color = .blue
    @State private var button02Text = "stop"
    @State private var button02Color: Color = .blue
    @State private var isShowAlert = false

    /// 音声認識により文字起こししたテキスト
    @State private var speachText = "-"
    
    // MARK: - for Speech
    private let speechRecgnizer = SFSpeechRecognizer(locale: .init(identifier: "ja_JP"))!
    private let audioEngine = AVAudioEngine()
    @State private var recognitionReq: SFSpeechAudioBufferRecognitionRequest?
    @State private var recognitionTask: SFSpeechRecognitionTask?
    
    var body: some View {
        VStack(spacing: 50) {
            Spacer()
            Text(speachText)
            Spacer()
            
            Button {
                print("hoge")
            } label: {
                Text("(sandbox)")
                    .font(.largeTitle)
                    .foregroundColor(button01Color)
            }
            
            Spacer()
            
            // 録音スタートボタン
            Button(
                action: {
                    button01Text = "recording..."
                    button01Color = .red
                    do {
                        try startLiveTranscription()
                    } catch {
                        isShowAlert = true
                    }
                },
                label: {
                    Text(button01Text)
                        .font(.largeTitle)
                        .foregroundColor(button01Color)
                }
            ).alert(isPresented: $isShowAlert) {
                isShowAlert = false
                return cannotLiveTranscriptionAlert
            }
            
            Spacer()
            
            // 録音ストップボタン
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
            SFSpeechRecognizer.requestAuthorization { authorizeSpeechRecognizer(with: $0) }
        }
    }
}
    
// MARK: - private
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
                    if !speachText.isEmpty {}
                    
                    // NOTE: formattedStringは翻訳文をひとまとめにして返却する（単語ごとに分かれてはいない）
                    // speachText = result?.bestTranscription.formattedString ?? "<<< Fail to transcription >>>"
                    
                    // NOTE: 単語ごとに分かれて対応したい場合、segmentを使う
                    speachText = result?.bestTranscription.segments
                        .map { $0.substring }
                        .joined(separator: "\n") ?? "<<< Fail to transcription >>>"
                }
            }
        )
    }
    
    private func stopLiveTranscription() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionReq?.endAudio()
    }
    
    private var cannotLiveTranscriptionAlert: Alert {
        Alert(
            title: Text("音声認識を開始できませんでした"),
            message: Text("やり直してください"),
            dismissButton: .cancel()
        )
    }
    
    private func authorizeSpeechRecognizer(with status: SFSpeechRecognizerAuthorizationStatus) {
        guard status != SFSpeechRecognizerAuthorizationStatus.authorized else { return }
        // TODO:
        // ref: https://swift-ios.keicode.com/ios/speechrecognition-live.php
        
        // 許可の状態に応じて UI を更新する
        OperationQueue.main.addOperation {
            switch status {
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

// MARK: - PreviewProvider
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
