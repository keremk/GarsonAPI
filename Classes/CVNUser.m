//
//  CVNUser.m
//  Pods
//
//  Created by Kerem Karatal on 3/26/14.
//
//

#import "CVNUser.h"
#import "CVNSession.h"

static NSString * const kUniqueId = @"unique_id";
static NSString * const kGuest = @"guest";
static NSString * const kPrimaryAccount = @"primary_account";
static NSString * const kAccountId = @"account_id";
static NSString * const kCredentials = @"credentials";
static NSString * const kCredentialsConfirmation = @"credentials_confirmation";
static NSString * const kDisplayName = @"display_name";
static NSString * const kName = @"name";
static NSString * const kImage = @"image";
static NSString * const kEmail = @"email";
static NSString * const kGender = @"gender";
static NSString * const kDateOfBirth = @"date_of_birth";
static NSString * const kAge = @"age";
static NSString * const kCity = @"city";
static NSString * const kState = @"state";
static NSString * const kCountry = @"country";
static NSString * const kLocale = @"locale";

@implementation CVNUser

#pragma mark - User Info Serialization

+ (NSDateFormatter *) dateFormatter {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
  formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZZZ";
  return formatter;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"imageURL": kImage,
           @"userId": kUniqueId,
           @"primaryAccount": kPrimaryAccount,
           @"accountId": kAccountId,
           @"displayName": kDisplayName,
           @"dateOfBirth": kDateOfBirth
           };
}

+ (NSValueTransformer *) imageURLJSONTransformer {
  return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSString *str) {
    if (![str isKindOfClass:NSString.class] || str == nil) return nil;
    NSRange range = [str rangeOfString:@"http"];
    NSString *imageURL = nil;
    if (range.location == NSNotFound) {
      CVNSession *session = [CVNSession sharedInstance];
      imageURL = [NSString stringWithFormat:@"%@%@", [session imageBaseURL], str];
    } else {
      imageURL = str;
    }
    return [NSURL URLWithString:imageURL];
  } reverseBlock:^(NSURL *imageURL) {
    return [imageURL absoluteString];
  }];
}

+ (NSValueTransformer *) dateOfBirthJSONTransformer {
  return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
    return [self.dateFormatter dateFromString:str];
  } reverseBlock:^(NSDate *date) {
    return [self.dateFormatter stringFromDate:date];
  }];
}

@end
