# Eavesdropper


`Eavesdropper` is a lightweight library that provides functionalities for listening to specific events of your app. It will record and present all the logs shown usually in the Xcode console. You can browse them, select and export. Just shake your device to present the log screen.

## Installation
Requirements:
 - .iOS(.v13)

### Swift Package Manager 
1. In Xcode, open your project and navigate to File → Swift Packages → Add Package Dependency.
2. Paste the repository URL (https://github.com/DungeonDev78/AMEavesdropper.git) and click Next.
3. For Rules, select version.
4. Click Finish.

### Swift Package
```swift
.package(url: "https://github.com/DungeonDev78/AMEavesdropper.git", .upToNextMajor(from: "0.9.4"))
```

![Example](https://github.com/DungeonDev78/AMEavesdropper/blob/main/IMG/img002.jpeg?raw=true)

![Example](https://github.com/DungeonDev78/AMEavesdropper/blob/main/IMG/img001.jpg?raw=true)

#### What's new
- 0.9.4: Added present(on:) API.
- 0.9.3: Improved search with highlights on text. Better positioning of search text area.
- 0.9.2: added search/filter option for logs
- 0.9.1: Fixed bug for very large logs

## Usage

Once installed import the framework where needed, for example in the AppDelegate
```swift
#import AMEavesdropper
```
Then simply launch it using:
```swift
 Eavesdropper.startListening()
```

## APIs

### func `startListening(recordingStrategy: _, shakeToPresent: _)`
Starts the listening process for specific events or conditions.

#### Usage

This method configures and initiates a listening process that can be triggered by various events or conditions, such as a shake gesture. The behavior of the listening process is determined by the `recordingStrategy` parameter.

#### Parameters

- `recordingStrategy`: The strategy to use for recording events. Options are `.volatile` and `.persistent`. The default value is `.volatile`.
  - `.volatile`: Indicates that events are stored temporarily and not saved persistently.
  - `.persistent`: Indicates that events are stored and saved persistently, allowing for retrieval at a later time.
  - **Note**: `RecordingStrategy` is not currently used but is listed here for future development.
- `shakeToPresent`: A Boolean value that determines whether shaking the device will trigger the presentation of a specific UI or action. The default value is `true`, meaning that shaking the device will initiate the process. If set to `false`, the shake gesture will not trigger the process.

#### Example

```swift
Eavesdropper.startListening(recordingStrategy: .volatile, shakeToPresent: false)
```

### func `present(on:)`
Presents the Log list controller in on a specific UIViewController.

#### Usage
This method presents the logs controller modelly over another controller. It can be used to show the logs if you do not want to use the shake gesture or if that gesture is already used for another funcionality in your app.

#### Example

At the start of your app:
```swift
Eavesdropper.startListening(shakeToPresent: false)
```

In a specific view controller:
```swift
Eavesdropper.present(on self)
```

## License

AMEavesdropper is released under the MIT License.
