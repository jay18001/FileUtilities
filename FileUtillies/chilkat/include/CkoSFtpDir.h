// Chilkat Objective-C header.
// This is a generated header file for Chilkat version 9.5.0.45

// Generic/internal class name =  SFtpDir
// Wrapped Chilkat C++ class name =  CkSFtpDir

@class CkoSFtpFile;


@interface CkoSFtpDir : NSObject {

	@private
		void *m_obj;

}

- (id)init;
- (void)dealloc;
- (void)dispose;
- (NSString *)stringWithUtf8: (const char *)s;
- (void *)CppImplObj;
- (void)setCppImplObj: (void *)pObj;

@property (nonatomic, copy) NSString *DebugLogFilePath;

@property (nonatomic, readonly, copy) NSString *LastErrorHtml;
@property (nonatomic, readonly, copy) NSString *LastErrorText;
@property (nonatomic, readonly, copy) NSString *LastErrorXml;
@property (nonatomic, readonly, copy) NSNumber *NumFilesAndDirs;
@property (nonatomic, readonly, copy) NSString *OriginalPath;
@property (nonatomic) BOOL VerboseLogging;

@property (nonatomic, readonly, copy) NSString *Version;
// method: GetFileObject
- (CkoSFtpFile *)GetFileObject: (NSNumber *)index;
// method: GetFilename
- (NSString *)GetFilename: (NSNumber *)index;
// method: SaveLastError
- (BOOL)SaveLastError: (NSString *)path;

@end
