# Eavesdropper

`Eavesdropper` is a public struct that provides functionalities for listening to specific events or conditions and initiating a process based on a chosen recording strategy.

## Features

### `startListening`

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
MyListener.startListening(recordingStrategy: .volatile, shakeToPresent: false)
