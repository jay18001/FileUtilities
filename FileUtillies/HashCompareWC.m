//
//  HashCompareWC.m
//  
//
//  Created by Justin Anderson on 4/28/15.
//
//

#import "HashCompareWC.h"
#import "FileUtillies.h"

@interface HashCompareWC ()
@property (strong) IBOutlet NSTextField *labFile2;
@property (strong) IBOutlet NSTextField *labFile1;
@property (strong) IBOutlet NSTextField *labStatus;

@property (nonatomic, strong) NSString *hash1;
@property (nonatomic, strong) NSString *hash2;

@end

@implementation HashCompareWC

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}
- (IBAction)openFile1Pressed:(id)sender {
    NSString *file = [self openFileBroswer];
    FileUtillies *fileUtils = [[FileUtillies alloc] init];
    self.hash1 = [fileUtils hashFile:file];
    [self.labFile1 setStringValue:file];
}

- (IBAction)openFile2Pressed:(id)sender {
    NSString *file = [self openFileBroswer];
    FileUtillies *fileUtils = [[FileUtillies alloc] init];
    self.hash2 = [fileUtils hashFile:file];
    [self.labFile2 setStringValue:file];
}

- (IBAction)comparePresses:(id)sender {
    [self.labFile1 setStringValue:self.hash1];
    [self.labFile2 setStringValue:self.hash2];
    if ([self.hash1 isEqualToString:self.hash2]) {
        [self.labStatus setStringValue:@"Same"];
    } else {
        [self.labStatus setStringValue:@"Not Same"];
    }
}

- (NSString *)openFileBroswer {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseFiles:YES];
    [panel setCanChooseDirectories:NO];
    [panel setAllowsMultipleSelection:NO]; // yes if more than one dir is allowed
    NSInteger clicked = [panel runModal];
    
    if (clicked != NSFileHandlingPanelOKButton) {
        return nil;
    }
    return [[[panel URLs] objectAtIndex:0] path];
}

@end
