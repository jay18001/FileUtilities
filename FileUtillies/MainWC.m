//
//  MainWC.m
//  FileUtillies
//
//  Created by Justin Anderson on 4/28/15.
//  Copyright (c) 2015 Justin Anderson. All rights reserved.
//

#import "MainWC.h"
#import "EncryptionWC.h"
#import "HashCompareWC.h"

@interface MainWC ()
@property (nonatomic, strong) EncryptionWC *encryptionWC;
@property (nonatomic, strong) HashCompareWC *hashCompareWC;
@end

@implementation MainWC

- (void)windowDidLoad {
    [super windowDidLoad];
}
- (IBAction)encrytionPressed:(id)sender {
    self.encryptionWC = [[EncryptionWC alloc] initWithWindowNibName:@"EncryptionWC"];
    [self.encryptionWC showWindow:self];
}

- (IBAction)hashComparePressed:(id)sender {
    self.hashCompareWC = [[HashCompareWC alloc] initWithWindowNibName:@"HashCompareWC"];
    [self.hashCompareWC showWindow:self];
}

@end
