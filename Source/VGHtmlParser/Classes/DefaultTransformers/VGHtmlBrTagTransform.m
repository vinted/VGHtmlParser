//
//  VGBrTagTransformer.m
//  HtmlParserDemo
//
//  Created by Vytautas Galaunia on 11/3/14.
//  Copyright (c) 2014 Vytautas Galaunia. All rights reserved.
//

#import "VGHtmlBrTagTransform.h"

@implementation VGHtmlBrTagTransform

- (NSString *)tagName
{
    return @"br";
}

- (NSAttributedString *)transformAttributedString:(NSAttributedString *)attrString
                                          element:(TFHppleElement *)element
{
    return [[NSAttributedString alloc] initWithString:@"\n"];
}

@end
