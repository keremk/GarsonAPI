//
//  CVNSession.h
//  Pods
//
//  Created by Kerem Karatal on 3/26/14.
//
//

#import "MTLModel.h"
#import <AFNetworking/AFNetworking.h>
#import "CVNUser.h"

static NSString * const kAccessTokenService = @"accessTokenService";
static NSString * const kRefreshTokenService = @"refreshTokenService";
static NSString * const kExpiresAtService = @"expiresAtService";
static NSString * const kIsGuestService = @"isGuestService";
static NSString * const kGuestUserIdService = @"guestUserIdService";

@interface CVNSession : AFHTTPSessionManager

@property(nonatomic, copy) NSString *accessToken;
@property(nonatomic, readonly) NSString *keychainServiceName;
@property(nonatomic, readonly) NSString *userServiceBaseURL;
@property(nonatomic, readonly) NSString *gameServiceBaseURL;
@property(nonatomic, readonly) NSString *imageBaseURL;

@property(nonatomic, copy) NSString *refreshToken;
@property(nonatomic, strong) NSDate *expiresAt;
@property(nonatomic, strong) CVNUser *user;
@property(nonatomic, assign) BOOL isGuest;
@property(nonatomic, copy) NSString *cachedUserId;
//@property(nonatomic, assign) id<CVNSessionServiceDelegate> delegate;

+ (id)sharedInstance;

- (id) initWithBaseURL:(NSURL *) baseURL
  sessionConfiguration:(NSURLSessionConfiguration *) configuration
              settings:(NSDictionary *) settings;

@end
