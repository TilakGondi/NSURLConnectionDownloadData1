//
//  ViewController.h
//  DownloadData1
//
//  Created by tilakkumar gondi on 12/02/15.
//  Copyright (c) 2015 Tilak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyWebViewController.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSURL *docURL;
}
@property (weak, nonatomic) IBOutlet UITableView *docListTable;


@end
