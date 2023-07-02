
# Speech

Perform speech recognition on live or prerecorded audio, and receive transcriptions, alternative interpretations, and confidence levels of the results.

## Overview

Use the Speech framework to recognize spoken words in recorded or live audio. The keyboard’s dictation support uses speech recognition to translate audio content into text. This framework provides a similar behavior, except that you can use it without the presence of the keyboard. For example, you might use speech recognition to recognize verbal commands or to handle text dictation in other parts of your app.

You can perform speech recognition in many languages, but each SFSpeechRecognizer object operates on a single language. On-device speech recognition is available for some languages, but the framework also relies on Apple’s servers for speech recognition. Always assume that performing speech recognition requires a network connection.

## Official Guiding Resource:

1. [Apple Doc - Speech](https://developer.apple.com/documentation/speech/)
