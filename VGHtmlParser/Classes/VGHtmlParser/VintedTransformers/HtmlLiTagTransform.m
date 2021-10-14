@import UIKit;
#import "HtmlLiTagTransform.h"

@implementation HtmlLiTagTransform

- (NSString *)tagName
{
    return @"li";
}

- (NSAttributedString *)transformAttributedString:(NSAttributedString *)attrString element:(TFHppleElement *)element
{
    if (!attrString.length) {
        return attrString;
    }
    
    NSMutableAttributedString *newAttrString = [[NSMutableAttributedString alloc] initWithString:@"\n\t• "];
    [newAttrString appendAttributedString:[attrString mutableCopy]];
    [newAttrString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    return [newAttrString copy];
}

@end

