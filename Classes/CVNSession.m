//
//  CVNSession.m
//  Pods
//
//  Created by Kerem Karatal on 3/26/14.
//
//

#import "CVNSession.h"
#import "CVNSettings.h"
#import "CVNErrorResponseSerializer.h"

#import <SSKeychain/SSKeychain.h>

@implementation CVNSession

#pragma mark - Initialization

+ (id)sharedInstance {
  static dispatch_once_t once;
  static id sharedInstance;
  dispatch_once(&once, ^{
    NSDictionary *settings = [CVNSettings loadSettings];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sharedInstance = [[self alloc] initWithBaseURL:nil sessionConfiguration:configuration settings:settings];
  });
  return sharedInstance;
  
}

- (id) initWithBaseURL:(NSURL *) baseURL
  sessionConfiguration:(NSURLSessionConfiguration *) configuration
              settings:(NSDictionary *) settings {
  // Initialize from plist file which contains the API Secret.
  // Do not checkin the API secrets to Github
  
  self = [super initWithBaseURL:baseURL sessionConfiguration: configuration];
	if (self != nil) {
    _accessToken = nil;
    _refreshToken = nil;
    _expiresAt = nil;
    _user = nil;
    _isGuest = NO;
//    _delegate = nil;
    
    if (settings) {
      _keychainServiceName = [settings valueForKey:@"keychainServiceName"];
      _userServiceBaseURL = [settings valueForKey:@"userServiceBaseURL"];
      _gameServiceBaseURL = [settings valueForKey:@"gameServiceBaseURL"];
      _imageBaseURL = [settings valueForKey:@"imageBaseURL"];
    }
    self.responseSerializer = [CVNErrorResponseSerializer serializer];
    [self readTokensFromKeyChain];
    [self configureClient];
  }
  return self;
}

- (void) readTokensFromKeyChain {
  NSDateFormatter *formatter = [CVNSettings dateFormatter];
  _expiresAt = [formatter dateFromString:[SSKeychain passwordForService:kExpiresAtService account:_keychainServiceName]];
  NSDate *today = [NSDate dateWithTimeIntervalSinceNow:0];
  if (_expiresAt && ([_expiresAt compare:today] == NSOrderedDescending)) {
    _accessToken = [SSKeychain passwordForService:kAccessTokenService account:_keychainServiceName];
    if (_accessToken) {
      [self setAuthorizationHTTPField:_accessToken];
    }
    _refreshToken = [SSKeychain passwordForService:kRefreshTokenService account:_keychainServiceName];
  }
  
  NSString *isGuestString = [SSKeychain passwordForService:kIsGuestService account:_keychainServiceName];
  if (isGuestString == nil || [isGuestString isEqualToString:@"NO"]) {
    _isGuest = NO;
  } else {
    _isGuest = YES;
  }
}

- (void) configureClient {
  AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
  
  [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
  [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  self.requestSerializer = requestSerializer;
  if (_accessToken) {
    [self setAuthorizationHTTPField:_accessToken];
  }
}

- (void) setAuthorizationHTTPField:(NSString *)accessToken {
  [self.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", accessToken] forHTTPHeaderField:@"Authorization"];
}

@end
