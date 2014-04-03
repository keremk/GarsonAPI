//
//  CVNMenuItem.m
//  Pods
//
//  Created by Kerem Karatal on 3/30/14.
//
//

#import "CVNMenuItem.h"
#import "CVNSession.h"

static NSString * const kName = @"name";
static NSString * const kDescription = @"description";
static NSString * const kImage = @"image";
static NSString * const kPrice = @"price";
@implementation CVNMenuItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"imageURL": kImage
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

- (NSString *) formattedPrice {
  return [NSString stringWithFormat:@"$%.2f", self.price];
}

@end
