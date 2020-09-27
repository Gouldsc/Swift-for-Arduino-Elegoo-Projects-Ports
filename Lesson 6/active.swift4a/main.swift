//------------------------------------------------------------------------------
//
// active.swift4a
// Swift For Arduino
//
// Created by Scott Gould on 09/26/2020.
// Copyright © 2020 Scott Gould. All rights reserved.
//
// This is a port of Elegoo's 2560 most complete starter kit code:
// https://www.elegoo.com/tutorial/Elegoo%20The%20Most%20Complete%20Starter%20Kit%20for%20MEGA%20V1.0.2020.3.11.zip
// from lesson 6: active.ino
// NOTE: Modifications to the "Libraries:" comment line below will affect the build.
// Libraries:
//------------------------------------------------------------------------------

import AVR

// WARNING: active buzzers sound horrible, you might want earplugs when working on this project
struct ActiveBuzzer
{
    let pin: Pin
    
    init( pin: Pin )
    {
        self.pin = pin
        pinMode( pin: self.pin, mode: OUTPUT )
    }
    
    func playNoise( withDelay frequencyDelay: Milliseconds )
    {
        digitalWrite( pin: pin, value: HIGH )
        delay( milliseconds: frequencyDelay )
        digitalWrite( pin: pin, value: LOW )
        delay( milliseconds: frequencyDelay )
    }
}

let horribleNoiseGenerator = ActiveBuzzer( pin: 11 )

// Main Loop

while( true ) 
{
    for _ in 0...80
    {
        horribleNoiseGenerator.playNoise( withDelay: 1 )
    }
    for _ in 0...100
    {
        horribleNoiseGenerator.playNoise( withDelay: 2 )
    }
}