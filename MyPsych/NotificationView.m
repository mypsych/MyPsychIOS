//
//  NotificationView.m
//  Navlit
//
//  Created by James Lockwood on 6/7/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "NotificationView.h"
#import <QuartzCore/QuartzCore.h>

#define NOTIFICATION_FONT_SIZE 18.0f
#define NOTIFICATION_MIN_WIDTH 32.0f
#define NOTIFICATION_MIN_HEIGHT 32.0f

@interface NotificationView ()

@property (strong) UILabel* textLabel;
@end

@implementation NotificationView
@synthesize showsOnBlankString = _showsOnBlankString;
@synthesize textLabel = _textLabel;

- (void)awakeFromNib {
    NSString* text = @"";
    CGPoint oldCenter = self.center;
    UIImage* notiImage = [[UIImage imageNamed:@"Notification"] resizableImageWithCapInsets:UIEdgeInsetsMake(16, 16, 16, 16)];
    [self setImage:notiImage];
    self.showsOnBlankString = YES;
    CGSize size = [text sizeWithFont:[UIFont boldSystemFontOfSize:NOTIFICATION_FONT_SIZE]
                   constrainedToSize:CGSizeMake(128, NOTIFICATION_MIN_HEIGHT) lineBreakMode:UILineBreakModeTailTruncation];
    [self setFrame:CGRectMake(0, 0,
                              MAX(size.width + 14, NOTIFICATION_MIN_WIDTH),
                              MAX(size.height + 8, NOTIFICATION_MIN_HEIGHT))];
    self.textLabel = [[UILabel alloc]
                      initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [self.textLabel setTextAlignment:UITextAlignmentCenter];
    [self.textLabel setFont:[UIFont boldSystemFontOfSize:NOTIFICATION_FONT_SIZE]];
    [self.textLabel setText:text];
    [self.textLabel setTextColor:[UIColor whiteColor]];
    [self.textLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.textLabel];
    [self.textLabel setCenter:self.center];
    [self setCenter:oldCenter];
    
    self.layer.shadowOpacity = 0.3f;
    self.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    self.layer.shadowRadius = 1.0f;
}

- (id)initWithText:(NSString*)text {
    UIImage* notiImage = [[UIImage imageNamed:@"notification"] resizableImageWithCapInsets:UIEdgeInsetsMake(16, 16, 16, 16)];
    self = [super initWithImage:notiImage];
    if (self) {
        self.showsOnBlankString = YES;
        CGSize size = [text sizeWithFont:[UIFont boldSystemFontOfSize:NOTIFICATION_FONT_SIZE]
                       constrainedToSize:CGSizeMake(128, NOTIFICATION_MIN_HEIGHT) lineBreakMode:UILineBreakModeTailTruncation];
        [self setFrame:CGRectMake(0, 0,
                                  MAX(size.width + 14, NOTIFICATION_MIN_WIDTH),
                                  MAX(size.height + 8, NOTIFICATION_MIN_HEIGHT))];
        self.textLabel = [[UILabel alloc]
                          initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        [self.textLabel setTextAlignment:UITextAlignmentCenter];
        [self.textLabel setFont:[UIFont boldSystemFontOfSize:NOTIFICATION_FONT_SIZE]];
        [self.textLabel setText:text];
        [self.textLabel setTextColor:[UIColor whiteColor]];
        [self.textLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.textLabel];
        [self.textLabel setCenter:self.center];
    }
    return self;
}

- (void)setText:(NSString*)text {
    CGPoint oldCenter = self.center;
    CGSize size = [text sizeWithFont:[UIFont boldSystemFontOfSize:NOTIFICATION_FONT_SIZE]
                   constrainedToSize:CGSizeMake(128, NOTIFICATION_MIN_HEIGHT) lineBreakMode:UILineBreakModeTailTruncation];
    [self setFrame:CGRectMake(0, 0,
                              MAX(size.width + 14, NOTIFICATION_MIN_WIDTH),
                              MAX(size.height + 8, NOTIFICATION_MIN_HEIGHT))];
    [self.textLabel setFrame:CGRectMake(0, 0, size.width, size.height)];
    [self.textLabel setText:text];
    [self.textLabel setCenter:self.center];
    [self setCenter:oldCenter];
    if (!self.showsOnBlankString) {
        if ([text caseInsensitiveCompare:@""] == NSOrderedSame) {
            self.hidden = YES;
        } else {
            self.hidden = NO;
        }
    }
}

@end
