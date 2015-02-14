//
//  MyWebViewController.m
//  DownloadData1
//
//  Created by tilakkumar gondi on 12/02/15.
//  Copyright (c) 2015 Tilak. All rights reserved.
//

#import "MyWebViewController.h"
#define SOME_FILE_SIZE_IN_BYTES 0

@interface MyWebViewController ()
{
    NSMutableData *webData;
    UIProgressView *progress;
    NSUInteger statusCode,contentLength;
    NSUInteger bytesSum;
    float percent;
    UIActivityIndicatorView *activityIndicator;
    UILabel *progressLbl;
}
@end

@implementation MyWebViewController
@synthesize urlToLoad;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //To Download Data Using NSURLConnection
    [self downloadFileWithURLConnection:urlToLoad];
    
    
    
    _myWebView.delegate=self;
    
    progress=[[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    progress.frame=CGRectMake(0, 65, 320, 2);
    [self.view addSubview:progress];
    
    [progress setProgressTintColor:[UIColor blueColor]];
    [self.view bringSubviewToFront:progress];
    
    activityIndicator=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.frame=CGRectMake((self.view.frame.size.width/2)-50, (self.view.frame.size.height/2)-50, 100, 100);
    [self.view addSubview:activityIndicator];
    
    
    progressLbl=[[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2)-40, 70, 80, 60)];
    progressLbl.layer.cornerRadius=10;
    progressLbl.clipsToBounds=YES;
    progressLbl.backgroundColor=[UIColor grayColor];
    progressLbl.alpha=0.6f;
    progressLbl.text=@"Loading...";
    progressLbl.font=[UIFont systemFontOfSize:14];
    progressLbl.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:progressLbl];
    
}



//Method To Download Data Using NSURLConnection
-(void) downloadFileWithURLConnection:(id) sender {
    NSURL *reqURL =  sender;
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:reqURL];
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if (theConnection) {
        webData = [NSMutableData data] ;
        [theConnection start];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error !" message:@"Error has occured, please verify internet connection"  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [alert show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- webviewDelegates
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Error:%@",error);
    [activityIndicator stopAnimating];
}


-(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"Start Loading:");
    [activityIndicator startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"Finished Loading:");
    [_myWebView setScalesPageToFit:YES];
    [activityIndicator stopAnimating];
    if (progress.progress == 1.0) {
        [progress removeFromSuperview];
        [progressLbl removeFromSuperview];
    }
}



#pragma mark- NSURLConnectionDelegates

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"%@",response);
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    statusCode = [httpResponse statusCode];
    
    if ((statusCode/100) == 2)
    {
        contentLength =(NSInteger) [httpResponse expectedContentLength];
        if (contentLength == (NSInteger)NSURLResponseUnknownLength)
            NSLog(@"unknown content length %ld", (long)contentLength);
    }
}



- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    //To Calculate the percentage of data downloaded
    bytesSum += [data length];
    percent = (float)bytesSum / (float)contentLength;
    
    [progress setProgress:percent animated:YES];
    progressLbl.text=[NSString stringWithFormat:@"%d%%\nDone",(NSInteger)round(percent*100) ];
    
    //Append  all the bytes of recieved data
    [webData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *fileName = [[urlToLoad path] lastPathComponent];
    NSArray *pathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *folder = [pathArr objectAtIndex:0];
    
    [self.navigationItem setTitle:@""];
    [self.navigationItem setTitle:fileName];
    
    NSString *filePath = [folder stringByAppendingPathComponent:fileName];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    NSError *writeError = nil;
    
    [webData writeToURL: fileURL options:0 error:&writeError];
    
    if( writeError) {
        NSLog(@" Error in writing file %@' : \n %@ ", filePath , writeError );
        return;
    }
    NSLog(@"fileURL----%@",fileURL);
    
    NSString *path = filePath;
    NSURL *targetURL = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [_myWebView loadRequest:request];
    [activityIndicator startAnimating];
    
}


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error !" message:@"Error has occured, please verify internet connection.."  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [alert show];
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
