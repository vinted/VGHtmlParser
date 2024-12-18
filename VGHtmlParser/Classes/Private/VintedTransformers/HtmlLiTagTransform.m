#import <UIKit/UIKit.h>
#import "HtmlLiTagTransform.h"
#import "VGHtmlParser.h"

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
    
    NSMutableAttributedString *newAttrString = [[NSMutableAttributedString alloc] initWithString:listBulletSymbol];
    [newAttrString appendAttributedString:[attrString mutableCopy]];
    [newAttrString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    
    NSDictionary *attributes = @{@"TextAttributeHeadIndentEnabled":@true};
    [newAttrString addAttributes:attributes range:NSMakeRange(0, newAttrString.length)];

    return [newAttrString copy];
}

@end

