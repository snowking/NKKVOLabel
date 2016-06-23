//
//  NKKVOLabel.h
//  FANSZ
//
//  Created by jinzhenghua on 2/12/2015.
//  Copyright © 2015 FANSZ. All rights reserved.
//

#import <UIKit/UIKit.h>


/*
 
 The Render Method should be like
 -(NSString*)stringWithNumber:(NSNumber*)number{
 return [NSString stringWithFormat:@"(%@)", number];
 }
 
 -(NSString*)stringWithValue:(id)value{
 return [NSString stringWithFormat:@"(%@)", value];
 }
 */

@interface NKKVOLabel : UILabel

@property (nonatomic, strong) id        modelObject;
@property (nonatomic, strong) NSString *keyPath;

@property (nonatomic, weak)   id        target;
@property (nonatomic, assign) SEL       renderMethod;
@property (nonatomic, assign) SEL       singleTapped;

@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, assign) BOOL      useAttributedText;

-(void)bindValueOfModel:(id)model forKeyPath:(NSString*)key;

@end
