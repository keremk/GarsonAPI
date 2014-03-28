//
//  CVNUser.m
//  Pods
//
//  Created by Kerem Karatal on 3/26/14.
//
//

#import "CVNUser.h"
#import "CVNSession.h"

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
