//
//  NotificationView.h
//  Navlit
//
//  Created by James Lockwood on 6/7/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationView : UIImageView

// Defaults to YES, will show no matter what the string
@property (assign) BOOL showsOnBlankString;

- (id)initWithText:(NSString*)text;
- (void)setText:(NSString*)text;

@end
