//
//  VGHtmlParser.h
//  
//
//  Created by Vytautas Galaunia on 11/3/14.
//
//

#import <UIKit/UIKit.h>
#import "VGHtmlTagTransform.h"

extern NSString * const VGHtmlParserMissingTagNameException;

@interface VGHtmlParser : NSObject

@property (nonatomic, strong, readonly) NSData *htmlData;

/**
 *  Designated initialized
 *  By default it has installed 3 html tag transforms: VGHtmlATagTransform, VGHtmlBrTagTransform and VGHtmlPTagTransform
 *  You can easily remove them by invoking -removeAllHtmlTagTransforms.
 *
 *  @param htmlData Html data
 *
 *  @return An Instance type
 */
- (instancetype)initWithHtmlData:(NSData *)htmlData;

/**
 *  All html tag transforms
 *
 *  @return Array with all existing transforms
 */
- (NSArray *)htmlTagTransforms;

/**
 *  Remove all html tag transforms
 */
- (void)removeAllHtmlTagTranforms;

/**
 *  Add or overrides current html tag trasform
 *
 *  @param tagTransformer An html tag transform
 */
- (void)addHtmlTagTransform:(id<VGHtmlTagTransform>)tagTransform;

/**
 *  Html tag transform for a given tag
 *
 *  @param tagName Tag name of tag transform
 *
 *  @return Transform for a given tag or nil
 */
- (id<VGHtmlTagTransform>)htmlTagTransformForTagName:(NSString *)tagName;

/**
 *  Remove tag transform for a given tag name
 *
 *  @param tagName Tag name e.g. a, br, span and etc.
 */
- (void)removeHtmlTagTransformForTagName:(NSString *)tagName;

/**
 *  Html text parsing
 *
 *  @return Html data converted to an NSAttributedString
 */
- (NSAttributedString *)parse;

@end
