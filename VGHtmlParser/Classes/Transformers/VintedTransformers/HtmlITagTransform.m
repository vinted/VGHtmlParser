//
//  HtmlITagTransform.m
//  Vinted
//
//  Created by Vytautas Galaunia on 11/5/14.
//  Copyright (c) 2014 Vinted. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HtmlITagTransform.h"

@implementation HtmlITagTransform

- (NSString *)tagName
{
    return @"i";
}

- (NSAttributedString *)transformAttributedString:(NSAttributedString *)attrString element:(TFHppleElement *)element
{
    if (!attrString.length) {
        return attrString;
    }
    
    UIFont *font = [attrString attribute:NSFontAttributeName atIndex:0 effectiveRange:NULL];
    UIFontDescriptor *italicFontDescriptor = [font.fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitItalic];
    UIFont *italicFont = [UIFont fontWithDescriptor:italicFontDescriptor size:font.pointSize];
    
    NSMutableAttributedString *result = [attrString mutableCopy];
    if (italicFont) {
        [result addAttribute:NSFontAttributeName value:italicFont range:NSMakeRange(0, result.length)];
    }
    return [result copy];
}

@end
