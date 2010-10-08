//
//  MouseBatteryAppDelegate.h
//  MouseBattery
//
//  Created by David Reynolds on 18/08/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MouseBatteryAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	IBOutlet NSMenu *batteryMenu;
	NSStatusItem *batteryStatusItem;
}

@property (assign) IBOutlet NSWindow *window;

@end
