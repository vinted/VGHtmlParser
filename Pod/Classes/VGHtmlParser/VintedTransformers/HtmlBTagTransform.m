//
//  HtmlBTagTransform.m
//  Vinted
//
//  Created by Vytautas Galaunia on 11/5/14.
//  Copyright (c) 2014 Vinted. All rights reserved.
//

#import "HtmlBTagTransform.h"

@implementation HtmlBTagTransform

- (NSString *)tagName
{
    return @"b";
}

- (NSAttributedString *)transformAttributedString:(NSAttributedString *)attrString element:(TFHppleElement *)element
{
    if (!attrString.length) {
        return attrString;
    }
    
    UIFont *font = [attrString attribute:NSFontAttributeName atIndex:0 effectiveRange:NULL];
    UIFontDescriptor *boldFontDescriptor = [font.fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold];
    UIFont *boldFont = [UIFont fontWithDescriptor:boldFontDescriptor size:font.pointSize];

    NSMutableAttributedString *result = [attrString mutableCopy];
    NSDictionary *attributes = @{@"VintedBoldTagAttributeName":@""};
    [result addAttributes:attributes range:NSMakeRange(0, result.length)];
    if (boldFont) {
        [result addAttribute:NSFontAttributeName value:boldFont range:NSMakeRange(0, result.length)];
    }
    return [result copy];
}

@end

