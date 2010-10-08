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

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
}

-(NSString *) runScript {
	NSTask *ioreg = [[NSTask alloc] init];
	NSTask *grep = [[NSTask alloc] init];
	
	[ioreg setLaunchPath:@"/usr/sbin/ioreg"];
	[ioreg setArguments:[NSArray arrayWithObject:@"-l"]];
	
	[grep setLaunchPath:@"/usr/bin/grep"];
	[grep setArguments:[NSArray arrayWithObject:@"'BatteryPercent'"]];
	
	NSPipe *pipe = [[NSPipe alloc] init];
	
	[ioreg setStandardError:[NSFileHandle fileHandleWithNullDevice]];
	[grep setStandardError:[NSFileHandle fileHandleWithNullDevice]];
	
	[ioreg setStandardOutput:pipe];
	[grep setStandardInput:pipe];
	
	pipe = [[NSPipe alloc] init];
	
	[grep setStandardOutput:pipe];
	
	[ioreg launch];
	[grep launch];
	
	NSData *data = [[[grep standardOutput] fileHandleForReading] readDataToEndOfFile];
	NSString *string = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
	return string;
}

- (void)awakeFromNib {
	batteryStatusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
	NSString *string = [self runScript];
	[batteryStatusItem setTitle:string];
}

@end
