//
//  CVNErrorResponseSerializer.m
//  Pods
//
//  Created by Kerem Karatal on 3/26/14.
//
//

#import "CVNErrorResponseSerializer.h"

@implementation CVNErrorResponseSerializer

static NSString * const kStatus = @"status";
static NSString * const kCode = @"code";
static NSString * const kMessage = @"message";
static NSString * const kNSLocalizedDescription = @"NSLocalizedDescription";

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error {
  id JSONObject = [super responseObjectForResponse:response data:data error:error]; // may mutate `error`
  
  if (*error != nil) {
    NSMutableDictionary *userInfo = [(*error).userInfo mutableCopy];
    if (nil == data) {
      [userInfo setValue:[NSData data] forKey:kCVNOriginalErrorResponseBody];
      NSLog(@"Failure: (no response body) %@", [userInfo valueForKey:kNSLocalizedDescription]);
    } else {
      NSDictionary *errorInfo = [self errorInfoFromResponseBody:data];
      [userInfo setValue:data forKey:kCVNOriginalErrorResponseBody];
      [userInfo setValue:[errorInfo valueForKey:kCVNFailureCode] forKey:kCVNFailureCode];
      [userInfo setValue:[errorInfo valueForKey:kCVNUserFriendlyErrorMessage] forKey:kCVNUserFriendlyErrorMessage];
    }
    NSError *newError = [NSError errorWithDomain:(*error).domain code:(*error).code userInfo:userInfo];
    (*error) = newError;
  }
  
  return JSONObject;
}

- (NSDictionary *) errorInfoFromResponseBody:(NSData *) bodyData {
  NSError *jsonError;
  NSDictionary *response = [NSJSONSerialization JSONObjectWithData:bodyData
                                                           options:kNilOptions
                                                             error:&jsonError];
  
  NSDictionary *status = [response objectForKey:kStatus];
  NSNumber *failureCode = [status objectForKey:kCode];
  if (nil == failureCode) {
    failureCode = [NSNumber numberWithInteger:0];
  }
  NSString *message = [status objectForKey:kMessage];
  if (nil == message) {
    message = @"Unknown error.";
  }
  
  NSDictionary *userInfo = @{kCVNFailureCode: failureCode,
                             kCVNUserFriendlyErrorMessage: message
                             };
  
  NSLog(@"Failure Code: %@", failureCode);
  NSLog(@"Failure Message: %@", message);
  
  return userInfo;
}
@end
