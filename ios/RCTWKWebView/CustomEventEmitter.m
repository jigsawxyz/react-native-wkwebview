//
//  EventEmitter.m
//  RCTWKWebView
//
//  Created by Michael Georgescu on 8/17/17.
//
//

#import <Foundation/Foundation.h>
#import "CustomEventEmitter.h"

@implementation CustomEventEmitter : RCTEventEmitter

RCT_EXPORT_MODULE();

- (NSArray<NSString *> *)supportedEvents {
    return @[@"leaveWebView"];
}

- (void)startObserving
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(emitEventInternal:)
                                                 name:@"event-emitted"
                                               object:nil];
}

// This will stop listening if we require it
- (void)stopObserving
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// This will actually throw the event out to our Javascript
- (void)emitEventInternal:(NSNotification *)notification
{
    // We will receive the dictionary here - we now need to extract the name
    // and payload and throw the event
    NSArray *eventDetails = [notification.userInfo valueForKey:@"detail"];
    NSString *eventName = [eventDetails objectAtIndex:0];
    NSDictionary *eventData = [eventDetails objectAtIndex:1];
    
    [self sendEventWithName:eventName
                       body:eventData];
}

// This is our static function that we call from our code
+ (void)emitEvent:(NSString *)name data:(NSDictionary *)data
{
    // userInfo requires a dictionary so we wrap out name and payload into an array and stick
    // that into the dictionary with a key of 'detail'
    NSDictionary *eventDetail = @{@"detail":@[name,data]};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"event-emitted"
                                                        object:self
                                                      userInfo:eventDetail];
}
@end
