//
//  EditNameViewController.h
//  KVOLabel
//
//  Created by jinzhenghua on 16/2/2016.
//  Copyright © 2016 jinzhenghua. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NKMainWidth [[UIScreen mainScreen] bounds].size.width

@interface Person : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *likeCount;

+(instancetype)personWithName:(NSString*)name;

@end




@interface EditNameViewController : UIViewController

@property (nonatomic, strong) Person *person;

@end
