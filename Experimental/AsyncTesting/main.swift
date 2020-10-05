//------------------------------------------------------------------------------
//
// AsyncTest.swift4a
// Swift For Arduino
//
// Created by Scott Gould on 10/05/2020.
// Copyright © 2020 Scott Gould. All rights reserved.
//
// NOTE: Modifications to the "Libraries:" comment line below will affect the build.
// Libraries:
//------------------------------------------------------------------------------

import AVR

private func foo( onPin pin: UInt8 )
{
    executeAsync( after: 20, repeats: true )
    {
        digitalWrite( pin: pin, value: HIGH )
        delay( us: 2000 )
        digitalWrite( pin: pin, value: LOW )
    }
}

// Main Loop
while( true ) 
{
    foo( onPin: 3 )
}