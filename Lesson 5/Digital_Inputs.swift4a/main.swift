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
// from lesson 5: Digital_Inputs.ino
//
// NOTE: Modifications to the "Libraries:" comment line below will affect the build.
// Libraries:
//------------------------------------------------------------------------------

import AVR

struct LED
{
    let pin: Pin
    
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


struct MomentaryDigitalSwitch
{
    let switchPin: Pin
    
    init( switchPin: Pin )
    {
        self.switchPin = switchPin
        pinMode( pin: self.switchPin, mode: INPUT )
    }
    
    func isActivated() -> Bool
    {
        if digitalRead( pin: switchPin ) == LOW    // Momentary digital switches output HIGH unless activated whereupon they connect with the GND and output LOW
        {
            digitalWrite( pin: switchPin, value: HIGH )
            return true
        }
        else
        {
            digitalWrite( pin: switchPin, value: HIGH )
            return false
        }
    }
}

let light = LED( pin: 9 )
let onSwitch = MomentaryDigitalSwitch( switchPin: 11 )
let offSwitch = MomentaryDigitalSwitch( switchPin: 10 )

// Main Loop

while( true ) 
{
    if onSwitch.isActivated()
    {
        light.turnOn()
    }
    
    if offSwitch.isActivated()
    {
        light.turnOff()
    }
}