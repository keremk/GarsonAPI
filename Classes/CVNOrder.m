//
//  CVNOrder.m
//  Pods
//
//  Created by Kerem Karatal on 3/30/14.
//
//

#import "CVNOrder.h"
#import "MTLJSONAdapter.h"

@interface CVNOrder()
@property(nonatomic, strong) NSMutableDictionary *orderDictionary;
@end

@implementation CVNOrder
//+ (CVNOrder *) currentOrder {
//  CVNOrder *currentOrder = [[CVNOrder alloc] init];
//  
//  return currentOrder;
//}

- (instancetype) init
{
  self = [super init];
  if (self) {
    _orderDictionary = [NSMutableDictionary dictionary];
  }
  return self;
}

- (NSArray *) orderItems {
//  NSArray *mockItems = @[@{@"name": @"Brussel Sprouts",
//                           @"description": @"Brussels Sprouts w/ Pineapple Chili Glaze & Crispy Shallots",
//                           @"image": @"https://s3-us-west-2.amazonaws.com/garson-menu-items/sample_restaurant/brussels-sprouts-with-bacon.jpg",
//                           @"price": @(12.0),
//                           @"item_count": @(1)
//                           },
//                         @{@"name": @"Pork Ribs",
//                           @"description": @"Hi Lo chili rub",
//                           @"image": @"https://s3-us-west-2.amazonaws.com/garson-menu-items/sample_restaurant/rib_tips.jpg",
//                           @"price": @(20.0),
//                           @"item_count": @(2)
//                           }
//                         ];
//  NSMutableArray *orderItems = [NSMutableArray array];
//  [mockItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//    NSDictionary *dict = (NSDictionary *) obj;
//    NSError *error;
//    CVNOrderItem *orderItem = [MTLJSONAdapter modelOfClass:CVNOrderItem.class fromJSONDictionary:dict error:&error];
//    [orderItems addObject:orderItem];
//  }];
//
//  return orderItems;
  
  return [self.orderDictionary allValues];
}

- (void) addMenuItem:(CVNMenuItem *)menuItem forItemCount:(NSInteger) itemCount {
  if (itemCount == 0) {
    // Remove Item
    [self removeMenuItem:menuItem];
  } else if (itemCount == 1) {
    CVNOrderItem *orderItem = [self orderItemFromMenuItem:menuItem];
    orderItem.itemCount = 1;
    [self.orderDictionary setObject:orderItem forKey:menuItem.name];
  } else {
    CVNOrderItem *orderItem = [self.orderDictionary objectForKey:menuItem.name];
    if (orderItem != nil) {
      orderItem.itemCount = itemCount;
    }
  }
}

- (void) removeMenuItem:(CVNMenuItem *)menuItem {
  [self.orderDictionary removeObjectForKey:menuItem.name];
}

- (CVNOrderItem *) orderItemFromMenuItem:(CVNMenuItem *) menuItem {
  CVNOrderItem *orderItem = [[CVNOrderItem alloc] init];
  orderItem.name = menuItem.name;
  orderItem.description = menuItem.description;
  orderItem.imageURL = menuItem.imageURL;
  orderItem.price = menuItem.price;
  orderItem.itemCount = 0;
  return orderItem;
}

- (NSInteger) itemCountForMenuItem:(CVNMenuItem *) menuItem {
  NSInteger itemCount = 0;
  CVNOrderItem *orderItem = [self.orderDictionary objectForKey:menuItem.name];
  if (orderItem != nil) {
    itemCount = orderItem.itemCount;
  }
  return itemCount;
}

@end
