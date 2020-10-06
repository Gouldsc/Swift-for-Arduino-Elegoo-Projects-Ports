//------------------------------------------------------------------------------
//
// Digital_Inputs.swift4a
// Swift For Arduino
//
// Created by Scott Gould on 09/26/2020.
// Copyright © 2020 Scott Gould. All rights reserved.
//
// This is a port of Elegoo's 2560 most complete starter kit code:
// https://www.elegoo.com/tutorial/Elegoo%20The%20Most%20Complete%20Starter%20Kit%20for%20MEGA%20V1.0.2020.3.11.zip
// from lesson 8: Ball_Switch.ino
//
// This is an alternate version of the project that lights an LED on a breadboard on pin 7 with a resistor in line
//
// NOTE: Modifications to the "Libraries:" comment line below will affect the build.
// Libraries:
//------------------------------------------------------------------------------

import AVR

struct LED
{
    private let pin: Pin

    init( pin: Pin )
    {
        self.pin = pin
        pinMode( pin: self.pin, mode: OUTPUT )
    }

    func turnOn()
    {
        digitalWrite( pin: pin, value: HIGH )
    }

    func turnOff()
    {
        digitalWrite( pin: pin, value: LOW )
    }
}


struct BallSwitch
{
    private let switchPin: Pin

    init( switchPin: Pin )
    {
        self.switchPin = switchPin
        pinMode( pin: self.switchPin, mode: INPUT )
    }

    func isActivated() -> Bool
    {
        return digitalRead( pin: switchPin )
    }
}

let light = LED( pin: 7 )
let ballSwitch = BallSwitch( switchPin: 8 )

// Main Loop

while( true )
{
    if ballSwitch.isActivated()
    {
        light.turnOn()
    }
    else
    {
        light.turnOff()
    }
}
