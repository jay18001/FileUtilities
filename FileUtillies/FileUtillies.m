//
//  FileUtillies.m
//  FileUtillies
//
//  Created by Justin Anderson on 4/28/15.
//  Copyright (c) 2015 Justin Anderson. All rights reserved.
//

#define CHILKATUNLOCK @"Ha, You think I would tell you my unlock"

#import "FileUtillies.h"
#import <CkoZip.h>
#import <CkoCrypt2.h>


@implementation FileUtillies

- (NSData*)compressFiles:(NSArray*)files {
    CkoZip *zip = [[CkoZip alloc] init];
    
    BOOL success;
    
    NSString *filePath = [self applicationSupportDirectory];
    filePath = [filePath stringByAppendingPathComponent:@"temp.zip"];
    
    //  Any string unlocks the component for the 1st 30-days.
    success = [zip UnlockComponent:CHILKATUNLOCK];
    if (success != YES) {
        NSLog(@"%@",zip.LastErrorText);
        return nil;
    }
    
    success = [zip NewZip:filePath];
    if (success != YES) {
        NSLog(@"%@",zip.LastErrorText);
        return nil;
    }
    
    //  To zip using utf-8 filenames, set the OemCodePage = 65001
    zip.OemCodePage = [NSNumber numberWithInt:65001];
    
    for (NSString *path in files) {
        [zip AppendFiles:path recurse:NO];
    }
    
    success = [zip WriteZipAndClose];
    if (success != YES) {
        NSLog(@"%@",zip.LastErrorText);
        return nil;
    }
    NSData *file = [NSData dataWithContentsOfFile:filePath];
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    
    return file;
}

- (NSString*)decompressFiles:(NSData*)file {
    CkoZip *zip = [[CkoZip alloc] init];
    
    BOOL success;
    
    //  Any string unlocks the component for the 1st 30-days.
    success = [zip UnlockComponent:CHILKATUNLOCK];
    if (success != YES) {
        NSLog(@"%@",zip.LastErrorText);
        return nil;
    }
    
    success = [zip OpenFromByteData:file];
    if (success != YES) {
        NSLog(@"%@",zip.LastErrorText);
        return nil;
    }
    
    int unzipCount;
    
    NSString *filePath = [[self applicationSupportDirectory] stringByAppendingPathComponent:@"unencryped"];
    NSInteger fileNumber = [self findNextFileNumberAtPath:filePath fileName:@""];
    filePath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%lu", fileNumber]];
    //  Returns the number of files and directories unzipped.
    //  Unzips to /my_files, re-creating the directory tree
    //  from the .zip.
    unzipCount = [[zip Unzip:filePath] intValue];
    if (unzipCount < 0) {
        NSLog(@"%@",zip.LastErrorText);
    }
    
    return filePath;
}

- (NSData *)encryptFile:(NSData*)file password:(NSString*)password {
    CkoCrypt2 *crypt = [[CkoCrypt2 alloc] init];
    
    BOOL success = [crypt UnlockComponent:CHILKATUNLOCK];
    if (success != YES) {
        NSLog(@"%@",crypt.LastErrorText);
        return nil;
    }
    
    //  AES is also known as Rijndael.
    crypt.CryptAlgorithm = @"aes";
    
    //  CipherMode may be "ecb" or "cbc"
    crypt.CipherMode = @"cbc";
    
    //  KeyLength may be 128, 192, 256
    crypt.KeyLength = [NSNumber numberWithInt:256];
    
    //  The padding scheme determines the contents of the bytes
    //  that are added to pad the result to a multiple of the
    //  encryption algorithm's block size.  AES has a block
    //  size of 16 bytes, so encrypted output is always
    //  a multiple of 16.
    crypt.PaddingScheme = [NSNumber numberWithInt:0];
    
    //  EncodingMode specifies the encoding of the output for
    //  encryption, and the input for decryption.
    //  It may be "hex", "url", "base64", or "quoted-printable".
    crypt.EncodingMode = @"hex";
    
    //  An initialization vector is required if using CBC mode.
    //  ECB mode does not use an IV.
    //  The length of the IV is equal to the algorithm's block size.
    //  It is NOT equal to the length of the key.
    NSString *ivHex = @"000102030405060708090A0B0C0D0E0F";
    [crypt SetEncodedIV: ivHex encoding: @"hex"];
    
    //  The secret key must equal the size of the key.  For
    //  256-bit encryption, the binary secret key is 32 bytes.
    //  For 128-bit encryption, the binary secret key is 16 bytes.
    
    NSString *keyHex = [crypt GenEncodedSecretKey:password encoding:@"hex"];
    [crypt SetEncodedKey: keyHex encoding: @"hex"];
    
    //  Encrypt a string...
    //  The input string is 44 ANSI characters (i.e. 44 bytes), so
    //  the output should be 48 bytes (a multiple of 16).
    //  Because the output is a hex string, it should
    //  be 96 characters long (2 chars per byte).
    NSData *encFile = [crypt EncryptBytes:file];
    
    return encFile;
}

- (NSData *)decryptFile:(NSData*)file password:(NSString*)password {
    CkoCrypt2 *crypt = [[CkoCrypt2 alloc] init];
    
    BOOL success = [crypt UnlockComponent:CHILKATUNLOCK];
    if (success != YES) {
        NSLog(@"%@",crypt.LastErrorText);
        return nil;
    }
    
    //  AES is also known as Rijndael.
    crypt.CryptAlgorithm = @"aes";
    
    //  CipherMode may be "ecb" or "cbc"
    crypt.CipherMode = @"cbc";
    
    //  KeyLength may be 128, 192, 256
    crypt.KeyLength = [NSNumber numberWithInt:256];
    
    //  The padding scheme determines the contents of the bytes
    //  that are added to pad the result to a multiple of the
    //  encryption algorithm's block size.  AES has a block
    //  size of 16 bytes, so encrypted output is always
    //  a multiple of 16.
    crypt.PaddingScheme = [NSNumber numberWithInt:0];
    
    //  EncodingMode specifies the encoding of the output for
    //  encryption, and the input for decryption.
    //  It may be "hex", "url", "base64", or "quoted-printable".
    crypt.EncodingMode = @"hex";
    
    //  An initialization vector is required if using CBC mode.
    //  ECB mode does not use an IV.
    //  The length of the IV is equal to the algorithm's block size.
    //  It is NOT equal to the length of the key.
    NSString *ivHex = @"000102030405060708090A0B0C0D0E0F";
    [crypt SetEncodedIV: ivHex encoding: @"hex"];
    
    //  The secret key must equal the size of the key.  For
    //  256-bit encryption, the binary secret key is 32 bytes.
    //  For 128-bit encryption, the binary secret key is 16 bytes.
    
    NSString *keyHex = [crypt GenEncodedSecretKey:password encoding:@"hex"];
    [crypt SetEncodedKey: keyHex encoding: @"hex"];
    
    //  Encrypt a string...
    //  The input string is 44 ANSI characters (i.e. 44 bytes), so
    //  the output should be 48 bytes (a multiple of 16).
    //  Because the output is a hex string, it should
    //  be 96 characters long (2 chars per byte).
    NSData *encFile = [crypt DecryptBytes:file];
    
    return encFile;
}


- (NSString*)applicationSupportDirectory
{
    NSString *executableName = @"FileUtiliesProgram";
    NSError *error;
    
    NSString* supportDirectoryPath = [self findOrCreateDirectory:NSApplicationSupportDirectory
                                                        inDomain:NSUserDomainMask
                                             appendPathComponent:executableName
                                                           error:&error];
    if (error)
    {
        NSLog(@"Unable to find or create application support directory:\n%@", error);
    }
    
    return supportDirectoryPath;
}

- (NSString *)findOrCreateDirectory:(NSSearchPathDirectory)searchPathDirectory
                           inDomain:(NSSearchPathDomainMask)domainMask
                appendPathComponent:(NSString *)appendComponent
                              error:(NSError **)errorOut
{
    // Search for the path
    NSArray* paths = NSSearchPathForDirectoriesInDomains(searchPathDirectory,
                                                         domainMask,
                                                         YES);
    if ([paths count] == 0)
    {
        
        return nil;
    }
    // Normally only need the first path returned
    NSString *resolvedPath = [paths objectAtIndex:0];
    // Append the extra path component
    if (appendComponent)
    {
        resolvedPath = [resolvedPath
                        stringByAppendingPathComponent:appendComponent];
    }
    // Create the path if it doesn't exist
    NSFileManager *fileManager= [[NSFileManager alloc] init];
    if(![fileManager fileExistsAtPath:resolvedPath]){
        if(![fileManager createDirectoryAtPath:resolvedPath withIntermediateDirectories:YES attributes:nil error:NULL]){
            NSLog(@"Error: Create folder failed %@", resolvedPath);
        }
    }
    return resolvedPath;
}

- (NSString *)hashFile:(NSString*)path {
    CkoCrypt2 *crypt = [[CkoCrypt2 alloc] init];
    
    //  Any string argument automatically begins the 30-day trial.
    BOOL success = [crypt UnlockComponent:CHILKATUNLOCK];
    if (success != YES) {
        NSLog(@"%@",crypt.LastErrorText);
        return nil;
    }
    
    //  Any type of file may be hashed.
    //  There is  no size limitation because the file is consumed
    //  in streaming mode internally.
    
    crypt.EncodingMode = @"base64";
    
    //  Hash using SHA-512
    crypt.HashAlgorithm = @"sha512";
    NSString* hash = [crypt HashFileENC:path];
    return hash;
}

- (NSInteger)findNextFileNumberAtPath:(NSString*)path fileName:(NSString*)fileName {
    NSString *extension = [fileName pathExtension];
    fileName = [fileName stringByDeletingPathExtension];
    NSString *savedPath = [path copy];
    path = [path stringByAppendingPathComponent:[fileName stringByAppendingString:@"0"]];
    if (![extension isEqualToString:@""] && extension != nil) {
        path = [path stringByAppendingPathExtension:extension];
    }
    
    NSInteger number = 0;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]){
        for (int i = 1; i <= 1000; i++){
            @autoreleasepool {
                NSString* filePath = [savedPath stringByDeletingPathExtension];
                filePath = [savedPath stringByAppendingPathComponent:[fileName stringByAppendingFormat:@"%i", i]];
                if (![extension isEqualToString:@""] && extension != nil) {
                    filePath = [filePath stringByAppendingPathExtension:extension];
                }
                if (![fileManager fileExistsAtPath:filePath]){
                    number = i;
                    break;
                }
            }
        }
    }
    return number;
}


@end
