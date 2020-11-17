//
//  HtmlATagTransform.m
//  Vinted
//
//  Created by Vytautas Galaunia on 11/5/14.
//  Copyright (c) 2014 Vinted. All rights reserved.
//

#import "HtmlATagTransform.h"
#import "TFHpple.h"

NSString * const VintedLinkAttributeName = @"VintedLinkAttributeName";

@implementation HtmlATagTransform

- (NSString *)tagName
{
    return @"a";
}

- (NSAttributedString *)transformAttributedString:(NSAttributedString *)attrString element:(TFHppleElement *)element
{
    NSString *href = [element objectForKey:@"href"];
    NSURL *hrefUrl = [NSURL URLWithString:href];
    if (hrefUrl) {
        NSMutableAttributedString *newAttrString = [attrString mutableCopy];
        [newAttrString addAttributes:[self attributesForLinkWithURL:hrefUrl]
                               range:NSMakeRange(0, newAttrString.length)];
        return [newAttrString copy];
    } else {
        return attrString;
    }
}

#pragma mark -

- (NSDictionary *)attributesForLinkWithURL:(NSURL *)url
{
    NSMutableDictionary *attrs = self.linkAttributes ? [self.linkAttributes mutableCopy] : [NSMutableDictionary new];
    [attrs addEntriesFromDictionary:attrs];
    attrs[VintedLinkAttributeName] = url;
    return attrs;
}

@end
