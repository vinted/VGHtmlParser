//
//  VGHtmlPTagTransform.m
//  HtmlParserDemo
//
//  Created by Vytautas Galaunia on 11/4/14.
//  Copyright (c) 2014 Vytautas Galaunia. All rights reserved.
//

#import "VGHtmlPTagTransform.h"

@implementation VGHtmlPTagTransform

- (NSString *)tagName
{
    return @"p";
}

- (NSAttributedString *)transformAttributedString:(NSAttributedString *)attrString element:(TFHppleElement *)element
{
    NSMutableAttributedString *newAttrString = [attrString mutableCopy];
    [newAttrString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    return [newAttrString copy];
}

@end
