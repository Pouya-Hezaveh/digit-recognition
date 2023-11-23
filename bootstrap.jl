(pwd() != @__DIR__) && cd(@__DIR__) # allow starting app from bin/ dir

using DigitRecognition
const UserApp = DigitRecognition
DigitRecognition.main()
