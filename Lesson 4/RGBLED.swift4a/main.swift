//------------------------------------------------------------------------------
//
// RGBLED.swift4a
// Swift For Arduino
//
// Created by Scott Gould on 09/24/2020.
// Copyright © 2020 Scott Gould. All rights reserved.
//
// This is a port of Elegoo's 2560 most complete starter kit code: 
// https://www.elegoo.com/tutorial/Elegoo%20The%20Most%20Complete%20Starter%20Kit%20for%20MEGA%20V1.0.2020.3.11.zip
// from lesson 4: RGB_LED.ino
// NOTE: Modifications to the "Libraries:" comment line below will affect the 
build.
// Libraries:
//------------------------------------------------------------------------------



import AVR

typealias RGBColorValue = UInt8    //  Between 0 and 255

enum PWMPin: Pin
{
    case D3 = 3
    case D5 = 5
    case D6 = 6
    case D9 = 9
    case D10 = 10
    case D11 = 11
}

struct Color
{
    var red: RGBColorValue
    var green: RGBColorValue
    var blue: RGBColorValue
}

//    This is a RGB LED with R, G, B, inputs connected to PWM pins. The color will be determined by the values of each respective variable between 0 and 255
struct RGBLED
{
    let redPin: PWMPin
    let greenPin: PWMPin
    let bluePin: PWMPin

    var color: Color

    init( color: Color, redPin: PWMPin, greenPin: PWMPin, bluePin: PWMPin )
    {
        self.redPin = redPin
        self.greenPin = greenPin
        self.bluePin = bluePin

        self.color = color

        pinMode( pin: redPin.rawValue, mode: OUTPUT )
        pinMode( pin: greenPin.rawValue, mode: OUTPUT )
        pinMode( pin: bluePin.rawValue, mode: OUTPUT )
    }

    func updateColor()
    {
        analogWrite( pin: redPin.rawValue, value: self.color.red )
        analogWrite( pin: greenPin.rawValue, value: self.color.green )
        analogWrite( pin: bluePin.rawValue, value: self.color.blue )
    }

}

let color = Color( red: 255, green: 0, blue: 0 )
var coloredLED = RGBLED( color: color, redPin: .D6, greenPin: .D5, bluePin: .D3 )
let delayTime: Milliseconds = 10

// Main Loop

while( true )
{
    for _ in 0...255
    {
        coloredLED.color.red -= 1
        coloredLED.color.green += 1

        coloredLED.updateColor()
        delay( milliseconds: delayTime )
    }

    for _ in 0...255
    {
        coloredLED.color.green -= 1
        coloredLED.color.blue += 1

        coloredLED.updateColor()
        delay( milliseconds: delayTime )
    }

    for _ in 0...255
    {
        coloredLED.color.blue -= 1
        coloredLED.color.red += 1

        coloredLED.updateColor()
        delay( milliseconds: delayTime )
    }
}
