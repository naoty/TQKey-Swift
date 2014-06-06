//
//  GravatarImage.m
//  TQKey
//
//  Created by naoty on 2014/06/07.
//  Copyright (c) 2014年 Naoto Kaneko. All rights reserved.
//

#import "GravatarImage.h"
#import "NSString+MD5.h"

@implementation GravatarImage

- (instancetype)initWithEmail:(NSString *)email
{
    NSString *hash = [email MD5Hash];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.gravatar.com/avatar/%@?s=40", hash]];
    return [super initWithData:[NSData dataWithContentsOfURL:url]];
}

@end
