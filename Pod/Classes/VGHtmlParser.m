//
//  VGHtmlParser.m
//  
//
//  Created by Vytautas Galaunia on 11/3/14.
//
//

#import "VGHtmlParser.h"
#import <TFHpple.h>
#import "VGHtmlATagTransfom.h"
#import "VGHtmlBrTagTransform.h"
#import "VGHtmlPTagTransform.h"

NSString * const VGHtmlParserMissingTagNameException = @"VGHtmlParserMissingTagNameException";

@interface VGHtmlParser ()

@property (nonatomic, strong) NSData *htmlData;
@property (nonatomic, strong) NSMutableDictionary *transformersMap;

@end

@implementation VGHtmlParser

- (instancetype)initWithHtmlData:(NSData *)htmlData
{
    self = [super init];
    if (self) {
        _transformersMap = [[NSMutableDictionary alloc] init];
        _htmlData = htmlData;
        [self addHtmlTagTransform:[[VGHtmlATagTransfom alloc] init]];
        [self addHtmlTagTransform:[[VGHtmlBrTagTransform alloc] init]];
        [self addHtmlTagTransform:[[VGHtmlPTagTransform alloc] init]];
    }
    return self;
}

- (NSAttributedString *)parse
{
    if (!self.htmlData.length) {
        return [[NSAttributedString alloc] init];
    }
    
    TFHpple *doc = [[TFHpple alloc] initWithHTMLData:self.htmlData];
    NSArray *elements = [doc searchWithXPathQuery:@"/"];
    TFHppleElement * element = [elements firstObject];
    NSAttributedString *attrString = [self attrStringForElement:element];
    return [self trimWhitespaceAndNewLine:attrString];
}


- (NSAttributedString *)attrStringForElement:(TFHppleElement *)element
{
    NSMutableAttributedString *attrString = [NSMutableAttributedString new];
    if (element.hasChildren) {
        for (TFHppleElement *child in element.children) {
            NSAttributedString *output = [self attrStringForElement:child];
            output = [self transformAttributedString:output forElement:child];
            if (output) {
                [attrString appendAttributedString:output];
            }
        }
    } else if (element.isTextNode && element.content.length) {
        NSDictionary *attrs = self.defaultAttributes ?: @{};
        NSAttributedString *output = [[NSAttributedString alloc] initWithString:element.content
                                                                     attributes:attrs];
        [attrString appendAttributedString:output];
    }
    return [attrString copy];
}

- (NSAttributedString *)transformAttributedString:(NSAttributedString *)attrString forElement:(TFHppleElement *)element
{
    if (!attrString.length || !element.tagName.length) {
        return attrString;
    }
    id<VGHtmlTagTransform> tagTransformer = [self htmlTagTransformForTagName:element.tagName];
    
    if (tagTransformer) {
        attrString = [tagTransformer transformAttributedString:attrString element:element];
    }
    
    return attrString;
}

#pragma mark - Trimming

- (NSAttributedString *)trimWhitespaceAndNewLine:(NSAttributedString *)attrString
{
    NSMutableAttributedString *newAttrString = [attrString mutableCopy];

    NSCharacterSet *charSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSRange range           = [newAttrString.string rangeOfCharacterFromSet:charSet];
    while (range.length != 0 && range.location == 0) {
        [newAttrString replaceCharactersInRange:range withString:@""];
        range = [newAttrString.string rangeOfCharacterFromSet:charSet];
    }
    
    range = [newAttrString.string rangeOfCharacterFromSet:charSet options:NSBackwardsSearch];
    while (range.length != 0 && NSMaxRange(range) == newAttrString.length)
    {
        [newAttrString replaceCharactersInRange:range withString:@""];
        range = [newAttrString.string rangeOfCharacterFromSet:charSet options:NSBackwardsSearch];
    }
    return [newAttrString copy];
}

#pragma mark -

- (NSArray *)htmlTagTransforms
{
    return [[self.transformersMap allValues] copy];
}

- (void)removeAllHtmlTagTranforms
{
    [self.transformersMap removeAllObjects];
}

- (id<VGHtmlTagTransform>)htmlTagTransformForTagName:(NSString *)tagName
{
    if (!tagName) {
        @throw [NSException exceptionWithName:VGHtmlParserMissingTagNameException
                                       reason:@"Tag name can not be nil."
                                     userInfo:nil];
    }
    if (!tagName.length) {
        @throw [NSException exceptionWithName:VGHtmlParserMissingTagNameException
                                       reason:@"Tag name can not be an empty string."
                                     userInfo:nil];
    }
    return tagName.length ? self.transformersMap[tagName.lowercaseString] : nil;
}

- (void)addHtmlTagTransform:(id<VGHtmlTagTransform>)tagTransform
{
    if (!tagTransform.tagName) {
        @throw [NSException exceptionWithName:VGHtmlParserMissingTagNameException
                                       reason:@"Given tag tranform name can not be nil."
                                     userInfo:nil];
    }
    if (!tagTransform.tagName.length) {
        @throw [NSException exceptionWithName:VGHtmlParserMissingTagNameException
                                       reason:@"Given tag tranform name can not be an empty string."
                                     userInfo:nil];
    }
    
    self.transformersMap[tagTransform.tagName.lowercaseString] = tagTransform;
}

- (void)removeHtmlTagTransformForTagName:(NSString *)tagName
{
    if (!tagName) {
        @throw [NSException exceptionWithName:VGHtmlParserMissingTagNameException
                                       reason:@"Tag name can not be nil."
                                     userInfo:nil];
    }
    if (!tagName.length) {
        @throw [NSException exceptionWithName:VGHtmlParserMissingTagNameException
                                       reason:@"Tag name can not be an empty string."
                                     userInfo:nil];
    }
    
    [self.transformersMap removeObjectForKey:tagName.lowercaseString];
}


@end
