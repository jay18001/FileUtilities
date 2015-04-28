//
//  FileUtillies.h
//  FileUtillies
//
//  Created by Justin Anderson on 4/28/15.
//  Copyright (c) 2015 Justin Anderson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileUtillies : NSObject

- (NSData*)compressFiles:(NSArray*)files;
- (NSString*)decompressFiles:(NSData*)file;

- (NSData *)encryptFile:(NSData*)file password:(NSString*)password;
- (NSData *)decryptFile:(NSData*)file password:(NSString*)password;

- (NSString*)applicationSupportDirectory;

- (NSInteger)findNextFileNumberAtPath:(NSString*)path fileName:(NSString*)fileName;

- (NSString *)hashFile:(NSString*)path;
@end
