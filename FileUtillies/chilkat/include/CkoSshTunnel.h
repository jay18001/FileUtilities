// Chilkat Objective-C header.
// This is a generated header file for Chilkat version 9.5.0.45

// Generic/internal class name =  SshTunnel
// Wrapped Chilkat C++ class name =  CkSshTunnel

@class CkoSshKey;


@interface CkoSshTunnel : NSObject {

	@private
		void *m_obj;

}

- (id)init;
- (void)dealloc;
- (void)dispose;
- (NSString *)stringWithUtf8: (const char *)s;
- (void *)CppImplObj;
- (void)setCppImplObj: (void *)pObj;

@property (nonatomic, copy) NSString *AcceptThreadSessionLogPath;

@property (nonatomic, copy) NSString *ConnectLog;

@property (nonatomic, copy) NSNumber *ConnectTimeoutMs;

@property (nonatomic, copy) NSString *DebugLogFilePath;

@property (nonatomic, copy) NSString *DestHostname;

@property (nonatomic, copy) NSNumber *DestPort;

@property (nonatomic, copy) NSString *HttpProxyAuthMethod;

@property (nonatomic, copy) NSString *HttpProxyDomain;

@property (nonatomic, copy) NSString *HttpProxyHostname;

@property (nonatomic, copy) NSString *HttpProxyPassword;

@property (nonatomic, copy) NSNumber *HttpProxyPort;

@property (nonatomic, copy) NSString *HttpProxyUsername;

@property (nonatomic, copy) NSNumber *IdleTimeoutMs;

@property (nonatomic, readonly) BOOL IsAccepting;
@property (nonatomic) BOOL KeepConnectLog;

@property (nonatomic, readonly, copy) NSString *LastErrorHtml;
@property (nonatomic, readonly, copy) NSString *LastErrorText;
@property (nonatomic, readonly, copy) NSString *LastErrorXml;
@property (nonatomic, copy) NSString *ListenBindIpAddress;

@property (nonatomic, readonly, copy) NSNumber *ListenPort;
@property (nonatomic, copy) NSNumber *MaxPacketSize;

@property (nonatomic, copy) NSString *OutboundBindIpAddress;

@property (nonatomic, copy) NSNumber *OutboundBindPort;

@property (nonatomic, copy) NSNumber *SoRcvBuf;

@property (nonatomic, copy) NSNumber *SoSndBuf;

@property (nonatomic, copy) NSString *SocksHostname;

@property (nonatomic, copy) NSString *SocksPassword;

@property (nonatomic, copy) NSNumber *SocksPort;

@property (nonatomic, copy) NSString *SocksUsername;

@property (nonatomic, copy) NSNumber *SocksVersion;

@property (nonatomic, copy) NSString *SshHostname;

@property (nonatomic, copy) NSString *SshLogin;

@property (nonatomic, copy) NSString *SshPassword;

@property (nonatomic, copy) NSNumber *SshPort;

@property (nonatomic) BOOL TcpNoDelay;

@property (nonatomic, readonly, copy) NSString *TunnelErrors;
@property (nonatomic, copy) NSString *TunnelThreadSessionLogPath;

@property (nonatomic) BOOL VerboseLogging;

@property (nonatomic, readonly, copy) NSString *Version;
// method: BeginAccepting
- (BOOL)BeginAccepting: (NSNumber *)listenPort;
// method: ClearTunnelErrors
- (void)ClearTunnelErrors;
// method: GetTunnelsXml
- (NSString *)GetTunnelsXml;
// method: SaveLastError
- (BOOL)SaveLastError: (NSString *)path;
// method: SetSshAuthenticationKey
- (BOOL)SetSshAuthenticationKey: (CkoSshKey *)key;
// method: StopAccepting
- (BOOL)StopAccepting;
// method: StopAllTunnels
- (BOOL)StopAllTunnels: (NSNumber *)maxWaitMs;
// method: UnlockComponent
- (BOOL)UnlockComponent: (NSString *)unlockCode;

@end
