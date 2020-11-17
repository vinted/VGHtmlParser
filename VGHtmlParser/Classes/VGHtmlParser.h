#import <UIKit/UIKit.h>
#import <VGHtmlParser/VGHtmlTagTransform.h>
#import <VGHtmlParser/HtmlATagTransform.h>
#import <VGHtmlParser/HtmlITagTransform.h>
#import <VGHtmlParser/HtmlBTagTransform.h>
#import <VGHtmlParser/XPathQuery.h>

extern NSString * __nonnull const VGHtmlParserMissingTagNameException;

@interface VGHtmlParser : NSObject

+ (instancetype __nonnull)defaultParserWithHtmlData:(NSData * __nonnull)htmlData linkAttributes:(NSDictionary * __nullable)linkAttributes;

/**
 *  Html data
 */
@property (nonatomic, strong, readonly, nonnull) NSData *htmlData;

/**
 *  Default attributes for attributed string, which will be generated during parse
 */
@property (nonatomic, strong, nullable) NSDictionary *defaultAttributes;

/**
 *  Designated initialized
 *  By default it has installed 3 html tag transforms: VGHtmlATagTransform, VGHtmlBrTagTransform and VGHtmlPTagTransform
 *  You can easily remove them by invoking -removeAllHtmlTagTransforms.
 *
 *  @param htmlData Html data
 *
 *  @return An Instance type
 */
- (instancetype __nonnull)initWithHtmlData:(NSData * __nonnull)htmlData;

/**
 *  All html tag transforms
 *
 *  @return Array with all existing transforms
 */
- (NSArray * __nonnull)htmlTagTransforms;

/**
 *  Remove all html tag transforms
 */
- (void)removeAllHtmlTagTranforms;

/**
 *  Add or overrides current html tag trasform
 *
 *  @param tagTransform An html tag transform
 */
- (void)addHtmlTagTransform:(id<VGHtmlTagTransform> __nonnull)tagTransform;

/**
 *  Html tag transform for a given tag
 *
 *  @param tagName Tag name of tag transform
 *
 *  @return Transform for a given tag or nil
 */
- (id<VGHtmlTagTransform> __nullable)htmlTagTransformForTagName:(NSString * __nonnull)tagName;

/**
 *  Remove tag transform for a given tag name
 *
 *  @param tagName Tag name e.g. a, br, span and etc.
 */
- (void)removeHtmlTagTransformForTagName:(NSString * __nonnull)tagName;

/**
 *  Html text parsing
 *
 *  @return Html data converted to an NSAttributedString
 */
- (NSAttributedString * __nonnull)parse;

@end
