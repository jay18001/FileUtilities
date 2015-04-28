//
//  AppDelegate.m
//  FileUtillies
//
//  Created by Justin Anderson on 4/28/15.
//  Copyright (c) 2015 Justin Anderson. All rights reserved.
//

#import "AppDelegate.h"
#import "MainWC.h"


@interface AppDelegate ()
@property (nonatomic, strong) MainWC *mainWC;
@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    self.mainWC = [[MainWC alloc] initWithWindowNibName:@"MainWC"];
    [self.mainWC showWindow:self];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
