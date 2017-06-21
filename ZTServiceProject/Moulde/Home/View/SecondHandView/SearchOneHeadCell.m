//
//  SearchHeadCell.m
//  SearchTable
//
//  Created by ZT on 2017/6/21.
//  Copyright © 2017年 张圆圆. All rights reserved.
//

#import "SearchOneHeadCell.h"

@interface SearchOneHeadCell ()

@property (weak, nonatomic) IBOutlet UITextField *keyTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIView *keyView;

@property (nonatomic,strong) NSMutableArray *tagAry;
@property (nonatomic,assign) float maxHeight;

@end
@implementation SearchOneHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _keyView.layer.borderWidth = 1.0;
    _keyView.layer.borderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0].CGColor;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)searchButtonAction:(id)sender {
    
    if (_keyTextField.text.length > 0) {
        if (![_tagAry containsObject:_keyTextField.text]) {
            [_tagAry addObject:_keyTextField.text];
            
//            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//            [userDefaults setObject:_tagAry forKey:@"tagAry"];
//            [userDefaults synchronize];
            
            NSLog(@"====%@", _keyTextField.text);
        }
    }

}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"searchBarTextDidBeginEditing");
    
}
@end
