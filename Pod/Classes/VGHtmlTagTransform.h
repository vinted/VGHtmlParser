//
//  VGHtmlNodeTransformer.h
//  HtmlParserDemo
//
//  Created by Vytautas Galaunia on 11/3/14.
//  Copyright (c) 2014 Vytautas Galaunia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TFHpple.h>

@protocol VGHtmlTagTransform <NSObject>

@required
/**
 *  Tag Name
 *
 *  @return NSString with a tag name e.g. a, br, div, span and etc.
 */
- (NSString *)tagName;

/**
 *  Attributed string transformation according to the tag context
 *
 *  @param attrString Base attributed string
 *  @param element    HTML element node
 *
 *  @return Transformed attributed string
 */
- (NSAttributedString *)transformAttributedString:(NSAttributedString *)attrString
                                          element:(TFHppleElement *)element;

@end
