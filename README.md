# GoogleVisionKit
 a custom swifty way to request and parse data from Google Vision API

It works quite well, however the API Model does not account for all properties. Remember to sign in for a Google Cloud account, activate the Vision API, generate an apiKey, then insert it in the VisionClient class. In the ViewController class, there is an example on how to make a request and how to parse data from the Vision API.

Bonus: an extension of the Response struct is present in VisionAPIModel.swift, the variable "parseText" returns an array of strings of each "Block"
