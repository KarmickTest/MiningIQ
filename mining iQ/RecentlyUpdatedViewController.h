//
//  RecentlyUpdatedViewController.h
//  mining iQ
//
//  Created by Admin on 10/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecentlyUpdatedCell.h"


@interface RecentlyUpdatedViewController : UIViewController
{
    RecentlyUpdatedCell *cell;
    NSMutableArray*arr_ProjectDetails;
}
@property (weak, nonatomic) IBOutlet UIButton *viewMrBtn;
@property (weak, nonatomic) IBOutlet UITableView *recentlyUpdateTbl;
- (IBAction)btnBack:(id)sender;

@end
