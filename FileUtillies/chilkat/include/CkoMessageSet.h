// Chilkat Objective-C header.
// This is a generated header file for Chilkat version 9.5.0.45

// Generic/internal class name =  MessageSet
// Wrapped Chilkat C++ class name =  CkMessageSet



@interface CkoMessageSet : NSObject {

	@private
		void *m_obj;

}

- (id)init;
- (void)dealloc;
- (void)dispose;
- (NSString *)stringWithUtf8: (const char *)s;
- (void *)CppImplObj;
- (void)setCppImplObj: (void *)pObj;

@property (nonatomic, readonly, copy) NSNumber *Count;
@property (nonatomic, copy) NSString *DebugLogFilePath;

@property (nonatomic) BOOL HasUids;

@property (nonatomic, readonly, copy) NSString *LastErrorHtml;
@property (nonatomic, readonly, copy) NSString *LastErrorText;
@property (nonatomic, readonly, copy) NSString *LastErrorXml;
@property (nonatomic) BOOL VerboseLogging;

@property (nonatomic, readonly, copy) NSString *Version;
// method: ContainsId
- (BOOL)ContainsId: (NSNumber *)id;
// method: FromCompactString
- (BOOL)FromCompactString: (NSString *)str;
// method: GetId
- (NSNumber *)GetId: (NSNumber *)index;
// method: InsertId
- (void)InsertId: (NSNumber *)id;
// method: RemoveId
- (void)RemoveId: (NSNumber *)id;
// method: SaveLastError
- (BOOL)SaveLastError: (NSString *)path;
// method: ToCommaSeparatedStr
- (NSString *)ToCommaSeparatedStr;
// method: ToCompactString
- (NSString *)ToCompactString;

@end
