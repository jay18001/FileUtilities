//
//  EncryptionWC.m
//  FileUtillies
//
//  Created by Justin Anderson on 4/28/15.
//  Copyright (c) 2015 Justin Anderson. All rights reserved.
//

#import "EncryptionWC.h"
#import "FileUtillies.h"

@interface EncryptionWC ()
@property (strong) IBOutlet NSSecureTextField *passwordFieldEncrypt1;
@property (strong) IBOutlet NSSecureTextField *passwordFieldEncrypt2;
@property (strong) IBOutlet NSSecureTextField *passwordFieldDecrypt1;
@property (nonatomic, strong) NSData *selectedEncrytFile;
@property (nonatomic, strong) NSData *selectedDecryptFile;
@end

@implementation EncryptionWC

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (IBAction)openEncrytPressed:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseFiles:YES];
    [panel setCanChooseDirectories:NO];
    [panel setAllowsMultipleSelection:YES]; // yes if more than one dir is allowed
    NSInteger clicked = [panel runModal];
    
    if (clicked != NSFileHandlingPanelOKButton) {
        return;
    }
    
    NSMutableArray* filePaths = [[NSMutableArray alloc] init];
    for (int i = 0; i < [[panel URLs] count]; i++) {
        [filePaths addObject:[[[panel URLs] objectAtIndex:i] path]];
    }
    
    FileUtillies *fileutils = [[FileUtillies alloc] init];
    self.selectedEncrytFile = [fileutils compressFiles:filePaths];
}
- (IBAction)encryptButtonPressed:(id)sender {
    if (self.selectedEncrytFile == nil){
        return;
    }
    
    NSString *password1 = [self.passwordFieldEncrypt1 stringValue];
    NSString *password2 = [self.passwordFieldEncrypt2 stringValue];
    
    if (![password1 isEqualToString:password2] || [password1 isEqualToString:@""]) {
        return;
    }
    
    FileUtillies *fileutils = [[FileUtillies alloc] init];
    NSData *data = [fileutils encryptFile:self.selectedEncrytFile password:password1];
    NSInteger fileNumber = [fileutils findNextFileNumberAtPath:[fileutils applicationSupportDirectory] fileName:@"EncryptedFile.enc"];
    NSString *filePath = [[fileutils applicationSupportDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"EncryptedFile%lu.enc", fileNumber]];
    [data writeToFile:filePath atomically:YES];
    
    [[NSWorkspace sharedWorkspace] selectFile:filePath inFileViewerRootedAtPath:[filePath stringByDeletingLastPathComponent]];
    
}


- (IBAction)openDecryptPressed:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseFiles:YES];
    [panel setCanChooseDirectories:NO];
    [panel setAllowsMultipleSelection:NO]; // yes if more than one dir is allowed
    NSInteger clicked = [panel runModal];
    
    if (clicked != NSFileHandlingPanelOKButton) {
        return;
    }
    
    self.selectedDecryptFile = [NSData dataWithContentsOfURL:[[panel URLs] objectAtIndex:0]];
}

- (IBAction)decryptButtonPressed:(id)sender {
    if (self.selectedDecryptFile == nil){
        return;
    }
    NSString *password1 = [self.passwordFieldDecrypt1 stringValue];
    if ([password1 isEqualToString:@""]) {
        return;
    }

    FileUtillies *fileutils = [[FileUtillies alloc] init];
    NSData *file = [fileutils decryptFile:self.selectedDecryptFile password:password1];
    NSString *filePath = [fileutils decompressFiles:file];
    
    [[NSWorkspace sharedWorkspace] selectFile:filePath inFileViewerRootedAtPath:[filePath stringByDeletingLastPathComponent]];
}



@end
