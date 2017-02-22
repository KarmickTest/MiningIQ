//
//  NewsFeedViewController.h
//  mining iQ
//
//  Created by Somnath on 07/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsFeedTableViewCell.h"

@interface NewsFeedViewController : UIViewController
{
    NewsFeedTableViewCell *cell;
}

@property (weak, nonatomic) IBOutlet UITableView *newsListTableView;

@end
