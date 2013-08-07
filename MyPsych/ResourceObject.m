//
//  ResourceObject.m
//  MyPsych
//
//  Created by James Lockwood on 6/4/12.
//  Copyright (c) 2012 Apps in House. All rights reserved.
//

#import "ResourceObject.h"

@implementation ResourceObject
@synthesize resourceTitle = _resourceTitle;
@synthesize resourceURL = _resourceURL;

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        [self setResourceTitle:[aDecoder decodeObjectForKey:@"resourceTitle"]];
        [self setResourceURL:[aDecoder decodeObjectForKey:@"resourceURL"]];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.resourceTitle forKey:@"resourceTitle"];
    [aCoder encodeObject:self.resourceURL forKey:@"resourceURL"];
}


@end
