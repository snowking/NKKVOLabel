//
//  ViewController.m
//  KVOLabel
//
//  Created by jinzhenghua on 16/2/2016.
//  Copyright © 2016 jinzhenghua. All rights reserved.
//

#import "ViewController.h"
#import "NKKVOLabel.h"
#import "EditNameViewController.h"




@interface Cell : UITableViewCell

@property (nonatomic, strong) Person *person;

@property (nonatomic, strong) NKKVOLabel *nameLabel;
@property (nonatomic, strong) NKKVOLabel *likeCountLabel;

@end


@implementation Cell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.nameLabel = [[NKKVOLabel alloc] initWithFrame:CGRectMake(10, 0, 300, 200)];
        [self.contentView addSubview:_nameLabel];
        
        
        self.likeCountLabel = [[NKKVOLabel alloc] initWithFrame:CGRectMake(NKMainWidth-40, 170, 30, 20)];
        [self.contentView addSubview:_likeCountLabel];
        
        _likeCountLabel.target = self;
        _likeCountLabel.renderMethod = @selector(stringWithNumber:);
        _likeCountLabel.singleTapped = @selector(like:);
        
        
    }
    
    return self;
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
    
    NSString *finalString = [NSString stringWithFormat:@"Like:%@", number];
    NSDictionary *attribute = @{NSFontAttributeName: _likeCountLabel.font};
    
    CGFloat width = [finalString boundingRectWithSize:CGSizeMake(200, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size.width;
    
    self.likeCountLabel.frame = CGRectMake(NKMainWidth-width-10, 170, width, 20);
    
    return finalString;
}

@end

@interface ViewController ()

@property (nonatomic, strong) NSArray *peopleArray;

@end


@implementation ViewController



-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.title = @"NKKVOLabel";
    
    
    self.peopleArray = [NSArray arrayWithObjects:
                        [Person personWithName:@"King"],
                        [Person personWithName:@"Damien"],
                        [Person personWithName:@"Summer"],
                        [Person personWithName:@"Rose"],
                         nil];
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.peopleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellid = @"cellid";
    Cell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        
    }
 
    Person *person = self.peopleArray[indexPath.row];
    cell.person = person;
    [cell.nameLabel bindValueOfModel:person forKeyPath:@"name"];
    [cell.likeCountLabel bindValueOfModel:person forKeyPath:@"likeCount"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EditNameViewController *editName = [[EditNameViewController alloc] init];
    editName.person = self.peopleArray[indexPath.row];
    
    [self.navigationController pushViewController:editName animated:YES];
}

@end
