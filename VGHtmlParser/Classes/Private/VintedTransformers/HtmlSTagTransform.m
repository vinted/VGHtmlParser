#import <UIKit/UIKit.h>
#import "HtmlSTagTransform.h"

@implementation HtmlSTagTransform

- (NSString *)tagName
{
    return @"s";
}

- (NSAttributedString *)transformAttributedString:(NSAttributedString *)attrString element:(TFHppleElement *)element
{
    if (!attrString.length) {
        return attrString;
    }
    
    NSMutableAttributedString *result = [attrString mutableCopy];
    NSDictionary *attributes = @{@"TextAttributeStrikethrough":true};
    [result addAttributes:attributes range:NSMakeRange(0, result.length)];
    return [result copy];
}

@end

