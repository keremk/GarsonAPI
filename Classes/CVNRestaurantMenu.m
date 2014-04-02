//
//  CVNRestaurantMenu.m
//  Pods
//
//  Created by Kerem Karatal on 3/30/14.
//
//

#import "CVNRestaurantMenu.h"
#import "CVNMenuSection.h"

static NSString * const kTitle = @"title";
static NSString * const kTimeInterval = @"time_interval";
static NSString * const kSections = @"sections";

@implementation CVNRestaurantMenu

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"timeInterval": kTimeInterval
           };
}

+ (NSValueTransformer *) sectionsJSONTransformer {
  return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:CVNMenuSection.class];
}

@end
