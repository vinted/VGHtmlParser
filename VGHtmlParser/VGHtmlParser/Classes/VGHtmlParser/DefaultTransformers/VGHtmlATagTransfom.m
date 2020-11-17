//
//  VGATagTransfomer.m
//  HtmlParserDemo
//
//  Created by Vytautas Galaunia on 11/3/14.
//  Copyright (c) 2014 Vytautas Galaunia. All rights reserved.
//

#import "VGHtmlATagTransfom.h"

@implementation VGHtmlATagTransfom

- (NSString *)tagName
{
    return @"a";
}

- (NSAttributedString *)transformAttributedString:(NSAttributedString *)attrString
                                          element:(TFHppleElement *)element
{
    NSString *href = [element objectForKey:@"href"];
    NSURL *hrefUrl = [NSURL URLWithString:href];
    if (hrefUrl) {
        NSMutableAttributedString *newAttrString = [attrString mutableCopy];
        [newAttrString addAttribute:NSLinkAttributeName value:hrefUrl range:NSMakeRange(0, newAttrString.length)];
        return [newAttrString copy];
    } else {
        return attrString;
    }
}

@end
