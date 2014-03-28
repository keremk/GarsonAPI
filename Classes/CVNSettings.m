//
//  CVNSettings.m
//  Pods
//
//  Created by Kerem Karatal on 3/26/14.
//
//

#import "CVNSettings.h"

@implementation CVNSettings

+ (NSDictionary *) loadSettings {
  NSString *filePath = [[NSBundle bundleForClass: [CVNSettings class]] pathForResource:@"settings" ofType:@"plist"];
  NSData *pListData = [NSData dataWithContentsOfFile:filePath];
  NSPropertyListFormat format;
  NSString *error;
  NSDictionary *settings = (NSDictionary *) [NSPropertyListSerialization propertyListFromData:pListData
                                                                             mutabilityOption:NSPropertyListImmutable
                                                                                       format:&format
                                                                             errorDescription:&error];
  
  return settings;
}

+ (NSDateFormatter *) dateFormatter {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateStyle:NSDateFormatterShortStyle];
  [formatter setTimeStyle:NSDateFormatterLongStyle];
  [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
  return formatter;
}

@end
