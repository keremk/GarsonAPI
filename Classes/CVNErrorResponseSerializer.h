//
//  CVNErrorResponseSerializer.h
//  Pods
//
//  Created by Kerem Karatal on 3/26/14.
//
//

#import "AFURLResponseSerialization.h"

// Error Info
static NSString * const kCVNOriginalErrorResponseBody = @"CVNOriginalErrorResponseBody";
static NSString * const kCVNUserFriendlyErrorMessage = @"CVNUserFriendlyErrorMessage";
static NSString * const kCVNFailureCode = @"CVNFailureCode";

static const NSInteger kCVNUnauthorizedAccessError = 1000;
static const NSInteger kCVNRecordNotFoundError = 1001;
static const NSInteger kCVNDuplicateRegistrationError = 1005;
static const NSInteger kCVNFacebookAuthenticationError = 5000;

@interface CVNErrorResponseSerializer : AFJSONResponseSerializer

@end
