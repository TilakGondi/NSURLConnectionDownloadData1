//
//  MyWebViewController.h
//  DownloadData1
//
//  Created by tilakkumar gondi on 12/02/15.
//  Copyright (c) 2015 Tilak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyWebViewController : UIViewController<UIWebViewDelegate,NSURLConnectionDataDelegate>


@property(strong, nonatomic)NSURL *urlToLoad;
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;

@end
