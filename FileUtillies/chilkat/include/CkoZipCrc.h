// Chilkat Objective-C header.
// This is a generated header file for Chilkat version 9.5.0.45

// Generic/internal class name =  ZipCrc
// Wrapped Chilkat C++ class name =  CkZipCrc



@class CkoBaseProgress;

@interface CkoZipCrc : NSObject {

	@private
		void *m_eventCallback;
		void *m_obj;

}

- (id)init;
- (void)dealloc;
- (void)dispose;
- (NSString *)stringWithUtf8: (const char *)s;
- (void *)CppImplObj;
- (void)setCppImplObj: (void *)pObj;

// property setter: EventCallbackObject
- (void)setEventCallbackObject: (CkoBaseProgress *)eventObj;

@property (nonatomic, copy) NSString *DebugLogFilePath;

@property (nonatomic, readonly, copy) NSString *LastErrorHtml;
@property (nonatomic, readonly, copy) NSString *LastErrorText;
@property (nonatomic, readonly, copy) NSString *LastErrorXml;
@property (nonatomic) BOOL VerboseLogging;

@property (nonatomic, readonly, copy) NSString *Version;
// method: BeginStream
- (void)BeginStream;
// method: CalculateCrc
- (NSNumber *)CalculateCrc: (NSData *)data;
// method: EndStream
- (NSNumber *)EndStream;
// method: FileCrc
- (NSNumber *)FileCrc: (NSString *)path;
// method: MoreData
- (void)MoreData: (NSData *)data;
// method: SaveLastError
- (BOOL)SaveLastError: (NSString *)path;
// method: ToHex
- (NSString *)ToHex: (NSNumber *)crc;

@end
