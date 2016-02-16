//
//  EditNameViewController.m
//  KVOLabel
//
//  Created by jinzhenghua on 16/2/2016.
//  Copyright © 2016 jinzhenghua. All rights reserved.
//

#import "EditNameViewController.h"

#import "NKKVOLabel.h"

@implementation Person

+(instancetype)personWithName:(NSString*)name{
    
    Person *person = [[self alloc] init];
    person.name = name;
    return person;
    
}

@end


@interface EditNameViewController ()

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NKKVOLabel *likeCountLabel;

@end


@implementation EditNameViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 60, self.view.bounds.size.width-20, 100)];
    [self.view addSubview:_textField];
    _textField.text = self.person.name;
    [_textField becomeFirstResponder];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = right;
    
    
    self.likeCountLabel = [[NKKVOLabel alloc] initWithFrame:CGRectMake(NKMainWidth-40, 170, 50, 20)];
    [self.view addSubview:_likeCountLabel];
    //_likeCountLabel.backgroundColor = [UIColor redColor];
    
    _likeCountLabel.target = self;
    _likeCountLabel.renderMethod = @selector(stringWithNumber:);
    _likeCountLabel.singleTapped = @selector(like:);
    
    [_likeCountLabel bindValueOfModel:self.person forKeyPath:@"likeCount"];
    
    
}

-(void)like:(id)sender{
    
    NSInteger count = [self.person.likeCount integerValue];
    count++;
    
    self.person.likeCount = [NSNumber numberWithInteger:count];
    
    
}

-(NSString*)stringWithNumber:(NSNumber*)number{
    
    if (!number) {
        number = @0;
    }
    
    NSString *finalString = [NSString stringWithFormat:@"%@", number];
    
    return finalString;
}


-(void)save:(id)sender{
    
    self.person.name = _textField.text;
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
