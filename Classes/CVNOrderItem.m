//
//  CVNOrderItem.m
//  Pods
//
//  Created by Kerem Karatal on 3/30/14.
//
//

#import "CVNOrderItem.h"
#import "CVNSession.h"
#import "MTLValueTransformer.h"

static NSString * const kName = @"name";
static NSString * const kDescription = @"description";
static NSString * const kImage = @"image";
static NSString * const kPrice = @"price";
static NSString * const kItemCount = @"item_count";
static NSString * const kOrderType = @"order_type";

@implementation CVNOrderItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"imageURL": kImage,
           @"itemCount": kItemCount
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

+ (NSValueTransformer *) orderTypeJSONTransformer {
  return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
                                                                         @"food": @(CVNOrderTypeFoodOrder),
                                                                         @"bar": @(CVNOrderTypeBarOrder)
                                                                         }];
}


- (NSString *) formattedItemCount {
  NSString *formattedItemCount;
  if (self.itemCount > 1) {
    formattedItemCount = [NSString stringWithFormat:@"%lu items", (unsigned long)self.itemCount];
  } else {
    formattedItemCount = [NSString stringWithFormat:@"%lu item", (unsigned long)self.itemCount];
  }
  return formattedItemCount;
}

- (NSString *) formattedPrice {
  return [NSString stringWithFormat:@"$%.2f", self.price];
}

@end
