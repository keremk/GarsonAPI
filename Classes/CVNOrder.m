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
@property(nonatomic, assign) BOOL totalsInvalid;
@end

static const float kTaxPercentage = 0.0875f;
static const float kSFHCPercentage = 0.03f;

@implementation CVNOrder {
  double _foodSubtotal;
  double _barSubtotal;
}

- (instancetype) init
{
  self = [super init];
  if (self) {
    _orderDictionary = [NSMutableDictionary dictionary];
    _totalsInvalid = YES;
  }
  return self;
}

- (NSArray *) orderItems {
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
  self.totalsInvalid = YES;
}

- (void) removeItemByName:(NSString *) itemName {
  [self.orderDictionary removeObjectForKey:itemName];
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
  orderItem.orderType = CVNOrderTypeFoodOrder; // TODO: For now, everything is food
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

- (NSDictionary *) calculateOrderSummary {
  NSDictionary *orderSummary = [NSDictionary dictionary];
  
  
  return orderSummary;
}

#pragma mark - Calculations

- (double) barSubtotal {
  if (self.totalsInvalid) {
    [self calculateTotals];
  }
  return _barSubtotal;
}

- (double) foodSubtotal {
  if (self.totalsInvalid) {
    [self calculateTotals];
  }
  return _foodSubtotal;
}

- (double) taxTotal {
  NSLog(@"Tax Percentage %f", kTaxPercentage);
  return (self.foodSubtotal + self.barSubtotal) * kTaxPercentage;
}

- (double) sfhcTaxTotal {
  return (self.foodSubtotal + self.barSubtotal) * kSFHCPercentage;
}

- (double) total {
  return (self.foodSubtotal + self.barSubtotal + self.sfhcTaxTotal + self.taxTotal);
}

- (void) calculateTotals {
  _barSubtotal = [self calculateSubtotalForOrderType:CVNOrderTypeBarOrder];
  _foodSubtotal = [self calculateSubtotalForOrderType:CVNOrderTypeFoodOrder];
  self.totalsInvalid = NO;
}

- (double) calculateSubtotalForOrderType:(CVNOrderType) orderType {
  __block double subtotal = 0.0;
  [self.orderItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    CVNOrderItem *orderItem = (CVNOrderItem *) obj;
    if (orderItem.orderType == orderType) {
      subtotal += (orderItem.price * orderItem.itemCount);
    }
  }];
  return subtotal;
}
@end
