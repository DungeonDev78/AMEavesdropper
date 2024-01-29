//
//  Evesdropper.swift
//  Postepay Business
//
//  Created by Alessandro Manilii on 25/01/24.
//  Copyright © 2024 Poste Italiane SPA. All rights reserved.
//

import UIKit

public let Eavesdropper = EavesdropperManager.shared

public class EavesdropperManager {
    
    // MARK: - Initialization
    static let shared = EavesdropperManager()
    
    /// Open a new Pipe to consume the messages on STDOUT and STDERR
    private var inputPipe: Pipe
    /// Open another Pipe to output messages back to STDOUT
    private var outputPipe: Pipe
    private let currentSession: CurrentSessionModel
    
    private var recordingStrategy = RecordingStrategy.volatile
    
    public var shakeToPresentLogs = false
    
    private var logs = [LogModel]()
    
    private init() {
        currentSession = CurrentSessionModel()
        inputPipe = Pipe()
        outputPipe = Pipe()
    }
    
    public func startListening(recordingStrategy: RecordingStrategy = .volatile,
                               shakeToPresent: Bool = true) {
        
        self.recordingStrategy = recordingStrategy
        self.shakeToPresentLogs = shakeToPresent
        
        let pipeReadHandle = inputPipe.fileHandleForReading
        setvbuf(stdout, nil, _IONBF, 0)
        
        // From documentation
        // dup2() makes newfd (new file descriptor) be the copy of oldfd (old file descriptor), closing newfd first if necessary.
        
        // Here we are copying the STDOUT file descriptor into our output pipe's file descriptor
        // this is so we can write the strings back to STDOUT, so it can show up on the xcode console
        dup2(STDOUT_FILENO, outputPipe.fileHandleForWriting.fileDescriptor)
        
        // In this case, the newFileDescriptor is the pipe's file descriptor and the old file descriptor is STDOUT_FILENO and STDERR_FILENO
        
        dup2(inputPipe.fileHandleForWriting.fileDescriptor, STDOUT_FILENO)
        dup2(inputPipe.fileHandleForWriting.fileDescriptor, STDERR_FILENO)
        
        // Listen in to the readHandle notification
        NotificationCenter.default.addObserver(self, selector: #selector(self.handlePipeNotification), name: FileHandle.readCompletionNotification, object: pipeReadHandle)
        
        // State that you want to be notified of any data coming across the pipe
        pipeReadHandle.readInBackgroundAndNotify()
    }
}

// MARK: - Internal
internal extension EavesdropperManager {
    
    func getLogs() -> [LogModel] {
        logs
    }
    
    func presentSessionList() {
        LogsView.present()
    }
    
    func createTextualLog() -> String {
       logs.compactMap{ $0.message }.map{ $0 + "\n" }.joined()
    }
}

// MARK: - Private
private extension EavesdropperManager {
    
    @objc private func handlePipeNotification(notification: Notification) {
        //note you have to continuously call this when you get a message
        //see this from documentation:
        //Note that this method does not cause a continuous stream of notifications to be sent. If you wish to keep getting notified, you’ll also need to call readInBackgroundAndNotify() in your observer method.
        inputPipe.fileHandleForReading.readInBackgroundAndNotify()
        
        if let data = notification.userInfo?[NSFileHandleNotificationDataItem] as? Data,
           let str = String(data: data, encoding: String.Encoding.ascii) {
            
            // Add a log to the array
            let logModel = LogModel(message: str, sessionID: currentSession.sessionID)
            logs.append(logModel)
            
            //write the data back into the output pipe. the output pipe's write file descriptor points to STDOUT. this allows the logs to show up on the xcode console
            outputPipe.fileHandleForWriting.write(data)
            
            // `str` here is the log/contents of the print statement
            //if you would like to route your print statements to the UI: make
            //sure to subscribe to this notification in your VC and update the UITextView.
            //Or if you wanted to send your print statements to the server, then
            //you could do this in your notification handler in the app delegate.
        }
    }
}
