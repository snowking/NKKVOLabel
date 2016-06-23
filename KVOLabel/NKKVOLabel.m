//
//  NKKVOLabel.m
//  FANSZ
//
//  Created by jinzhenghua on 2/12/2015.
//  Copyright © 2015 FANSZ. All rights reserved.
//

#import "NKKVOLabel.h"


#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

@implementation NKKVOLabel

-(void)dealloc{
    
    [_modelObject removeObserver:self forKeyPath:_keyPath];
    
}

-(void)bindValueOfModel:(id)model forKeyPath:(NSString*)key{
    [_modelObject removeObserver:self forKeyPath:_keyPath];
    
    self.modelObject = model;
    self.keyPath = key;
    
    [self bindText];
    
    [_modelObject addObserver:self forKeyPath:_keyPath options:NSKeyValueObservingOptionNew context:nil];
    
}

-(void)bindText{
    
    id value = [_modelObject valueForKeyPath:_keyPath];
    
    if (_target&&_renderMethod&&[_target respondsToSelector:_renderMethod]) {
        SuppressPerformSelectorLeakWarning(
                                           if (self.useAttributedText){
                                               self.attributedText = [_target performSelector:_renderMethod withObject:value];
                                           }
                                           else{
                                               self.text = [_target performSelector:_renderMethod withObject:value];
                                           }
                                           );
    }
    else {
        if (self.useAttributedText) {
            self.attributedText = value?value:nil;
        } else {
            self.text = value?[NSString stringWithFormat:@"%@", value]:nil;
        }
        
    }
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    [self bindText];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)setSingleTapped:(SEL)singleTapped{
    
    _singleTapped = singleTapped;
    
    self.userInteractionEnabled = YES;
    
    if (!self.tap) {
        self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [self addGestureRecognizer:_tap];
        
    }
    
}

-(void)tapped:(UITapGestureRecognizer*)gesture{
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        if ([_target respondsToSelector:_singleTapped]) {
            SuppressPerformSelectorLeakWarning(
                                               [_target performSelector:_singleTapped withObject:gesture];
                                               );
        }
    }
    
}




@end
