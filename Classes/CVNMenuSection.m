//
//  CVNMenuSection.m
//  Pods
//
//  Created by Kerem Karatal on 4/1/14.
//
//

#import "CVNMenuSection.h"
#import "CVNMenuItem.h"
#import "CVNSession.h"

static NSString * const kSectionId = @"id";
static NSString * const kTitle = @"title";
static NSString * const kDescription = @"description";
static NSString * const kImage = @"image";
static NSString * const kItems = @"items";

@implementation CVNMenuSection

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"imageURL": kImage,
           @"sectionId": kSectionId
           };
}

+ (NSValueTransformer *) imageURLJSONTransformer {
  return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSString *str) {
    if (![str isKindOfClass:NSString.class] || str == nil) return nil;
    NSRange range = [str rangeOfString:@"http"];
    NSString *imageURL = nil;
    if (range.location == NSNotFound) {
      CVNSession *session = [CVNSession sharedInstance];
      imageURL = [NSString stringWithFormat:@"%@%@@2x.jpg", [session imageBaseURL], str];
    } else {
      imageURL = str;
    }
    return [NSURL URLWithString:imageURL];
  } reverseBlock:^(NSURL *imageURL) {
    return [imageURL absoluteString];
  }];
}

+ (NSValueTransformer *) itemsJSONTransformer {
  return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:CVNMenuItem.class];
}

@end
