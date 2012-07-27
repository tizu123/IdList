//
//  DetailViewController.h
//  IdList
//
//  Created by パパ on 2012/07/27.
//  Copyright (c) 2012年 パパ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
