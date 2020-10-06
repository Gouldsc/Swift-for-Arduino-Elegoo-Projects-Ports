//------------------------------------------------------------------------------
//
// Servo.swift4a
// Swift For Arduino
//
// Created by Scott Gould on 10/05/2020.
// Copyright © 2020 Scott Gould. All rights reserved.
//
// This is a port of Elegoo's 2560 most complete starter kit code:
// https://www.elegoo.com/tutorial/Elegoo%20The%20Most%20Complete%20Starter%20Kit%20for%20MEGA%20V1.0.2020.3.11.zip
// from lesson 9: servo.ino
//
//    Servo code is adapted from Carl's servo library: https://github.com/swiftforarduino/community/blob/master/contributed%20libraries/servo.swift
//
// NOTE: Modifications to the "Libraries:" comment line below will affect the build.
// Libraries:
//------------------------------------------------------------------------------
import AVR

enum PWMPin: Pin
{
    case D3 = 3
    case D5 = 5
    case D6 = 6
    case D9 = 9
    case D10 = 10
    case D11 = 11
}
typealias Hertz = UInt8
typealias Angle = UInt16

//------------------------------------------------------------------------------
//    Global scope is required here as a workaround related to a limitation of executeAsync() which cannot pass a Swift closure with state
//------------------------------------------------------------------------------
private var servoPin: Pin = 0
private var servoPulseDuration: Microseconds = 0

private func pulse() 
{
    digitalWrite( pin: servoPin, value: HIGH )
    delay( us: servoPulseDuration )
    digitalWrite( pin: servoPin, value: LOW )
}

private func transmitPulseSignal( onPin pin: PWMPin, forDuration duration: Microseconds, atFrequency frequency: Hertz )
{
    let period: Milliseconds = 1000 / UInt16( frequency )

    servoPin = pin.rawValue
    servoPulseDuration = duration
    
    executeAsync( after: period, repeats: true )
    {
        pulse()
    }
}
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

struct Servo
{
    private let servoControlPin: PWMPin
    let maximumAngle: Angle
    var angle: Angle    //    Not sure if this would be more approprate to implemented as a func or if property accessors are better. This is a design decision that should probably be made library-wide and remain consistent for when we set state in code that is then updated in the actual component.
    {
        set
        {
            self._angle = (newValue > maximumAngle) ? maximumAngle : newValue
            self.updateAngle( to: _angle )
        }
        get
        {
            return self._angle
        }
    }
    private var _angle: Angle = 0
    private let frequency: Hertz
    private let scaleFactor: UInt16

    init( servoControlPin: PWMPin, maximumAngle: Angle = 180, frequency: Hertz = 50 )
    {
        self.servoControlPin = servoControlPin
        guard maximumAngle != 0
        else
        {
            fatalError()    //    maximumAngle cannot be 0
        }

        self.maximumAngle = (maximumAngle > 360) ? 360 : maximumAngle
        //  TODO: Need to add code to handle continuous rotation servo motors or specifically exclude them and create a separate struct
        self.scaleFactor = 1000 / maximumAngle
        self.frequency = frequency

        pinMode( pin: servoControlPin.rawValue, mode: OUTPUT )
    }

    private func updateAngle( to angle: Angle )
    {
        let pulseDuration = Microseconds( _angle * scaleFactor + 1000 )    //  Servos will have a minimum pulse duration of 1000 and a maximum of 2000 Microseconds of HIGH output followed by LOW output for the remainder of the period. The desired angle will correspond to a value in that range between 0 and the maximumAngle
        transmitPulseSignal( onPin: servoControlPin, forDuration: pulseDuration, atFrequency: frequency )
   }
}

var servo = Servo( servoControlPin: .D9 )

// Main Loop
while( true )
{
    servo.angle = 90
    delay( milliseconds: 500 )

    servo.angle = 60
    delay( milliseconds: 500 )

    servo.angle = 90
    delay( milliseconds: 500 )

    servo.angle = 120
    delay( milliseconds: 500 )
}