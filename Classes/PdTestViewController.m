//
//  PdTestViewController.m
//  PdTest02
//
//  Created by Richard Lawler on 11/22/10.
/**
 * This software is copyrighted by Richard Lawler. 
 * The following terms (the "Standard Improved BSD License") apply to 
 * all files associated with the software unless explicitly disclaimed 
 * in individual files:
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 * notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above  
 * copyright notice, this list of conditions and the following 
 * disclaimer in the documentation and/or other materials provided
 * with the distribution.
 * 3. The name of the author may not be used to endorse or promote
 * products derived from this software without specific prior 
 * written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR
 * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,   
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
 * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
 * THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "PdTestViewController.h"
#import "PdTestAppDelegate.h"
#import "PdBase.h"
#import "SampleListener.h"

@implementation PdTestViewController

// outlets
@synthesize outputLeftToggle;
@synthesize outputRightToggle;
@synthesize playToggle;
@synthesize frequencySlider;


- (void) viewWillAppear:(BOOL)animated {
	[self playStateChanged];
    
//    frequencySlider = [[[UISlider alloc] initWithFrame:CGRectMake(45, 0, 230, 55)] autorelease];
//    frequencySlider.minimumValue = 1;
//    frequencySlider.maximumValue = 50;
//    frequencySlider.value = 5;
//    [frequencySlider setContinuous:YES];
    
    PdDispatcher *dispatcher = (PdDispatcher *)[PdBase delegate];
    SampleListener *listener = [[SampleListener alloc] initWithLabel:frequencySlider];
    [dispatcher addListener:listener forSource:@"freq"];
    [listener release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)dealloc {
	[outputLeftToggle release];
	[outputRightToggle release];
	[playToggle release];
    [frequencySlider release];
    [super dealloc];
}

- (IBAction)outputLeftChanged {
	[PdBase sendFloat:(outputLeftToggle.on ? 1. : 0.) toReceiver: @"left" ];
}

- (IBAction)outputRightChanged {
	[PdBase sendFloat:(outputRightToggle.on ? 1. : 0.) toReceiver: @"right" ];
}

- (IBAction)playStateChanged {
	PdTestAppDelegate *appDelegate = (PdTestAppDelegate *) [[UIApplication sharedApplication] delegate];
	BOOL active = playToggle.on;
	[appDelegate setAudioActive:active];
}

@end
