//
//  MouseBatteryAppDelegate.m
//  MouseBattery
//
//  Created by David Reynolds on 18/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MouseBatteryAppDelegate.h"


@implementation MouseBatteryAppDelegate

@synthesize window;

-(void)updatePercentage {
    DLog(@"Update percentage");
    NSString *file = [[NSBundle mainBundle] pathForResource:@"get_stuff" ofType:@"sh" inDirectory:@""];
    NSTask *pyScript = [[NSTask alloc] init];
    [pyScript setLaunchPath:@"/bin/bash"];
    
    NSArray *arguments;
    arguments = [NSArray arrayWithObjects: file, nil];
    [pyScript setArguments:arguments];
    
    NSPipe *stdOutPath = [NSPipe pipe];
    [pyScript setStandardOutput:stdOutPath];
	[pyScript setStandardError:stdOutPath];
    
    NSFileHandle *fileHandle;
    fileHandle = [stdOutPath fileHandleForReading];
    
    [pyScript launch];
    [pyScript waitUntilExit];
    
    NSData *data;
    data = [fileHandle readDataToEndOfFile];
    
    NSString *string;
    string = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
    [string autorelease];
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    [pyScript release];
	DLog(@"%@", string);
    [batteryStatusItem setTitle:string];
}

- (void)awakeFromNib {
    NSDate *start_time = [NSDate date];	
    batteryStatusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
    [batteryStatusItem setHighlightMode:YES];
    
    batteryMenu = [[NSMenu alloc] init];
    NSMenuItem *menuItem = [[NSMenuItem alloc] initWithTitle:@"Quit" action:@selector(terminate:) keyEquivalent:@""];
    [batteryMenu addItem:menuItem];
    [menuItem release];
    [batteryStatusItem setMenu:batteryMenu];
    [batteryMenu release];
    
    NSTimer *timer = [[NSTimer alloc] initWithFireDate:start_time 
                                              interval:10.0 
                                                target:self 
                                              selector:@selector(updatePercentage) 
                                              userInfo:nil
                                               repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [timer fire];
    [timer release];
}

@end
