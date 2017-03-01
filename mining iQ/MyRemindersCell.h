//
//  MyRemindersCell.h
//  mining iQ
//
//  Created by Admin on 08/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyRemindersCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *projectLbl;
@property (weak, nonatomic) IBOutlet UILabel *dateLbl;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *markAsCompletedbtn;


@end
