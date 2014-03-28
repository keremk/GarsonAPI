//
//  CVNSettings.h
//  Pods
//
//  Created by Kerem Karatal on 3/26/14.
//
//

#import <Foundation/Foundation.h>

@interface CVNSettings : NSObject
+ (NSDictionary *) loadSettings;
+ (NSDateFormatter *) dateFormatter;
@end
