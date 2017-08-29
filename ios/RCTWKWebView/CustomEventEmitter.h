//
//  EventEmitter.h
//  RCTWKWebView
//
//  Created by Michael Georgescu on 8/17/17.
//
//

#import <React/RCTEventEmitter.h>
#import <React/RCTBridgeModule.h>

@interface CustomEventEmitter : RCTEventEmitter <RCTBridgeModule>

+ (void)emitEvent:(NSString *)name data:(NSDictionary *)data;

@end
