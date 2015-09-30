//
//  ViewController.m
//  PushViewWithScrollView
//
//  Created by SBouchard on 2015-09-30.
//  Copyright © 2015 Solutions Waizu inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate, UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView* scrollView;
@property (weak, nonatomic) IBOutlet UIWebView* webView;
@property (weak, nonatomic) IBOutlet UIView* topView;
@property (nonatomic,retain) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    self.scrollView.delegate = self;

    // Provide the space to correctly display the top view
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, self.topView.frame.size.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    
    // Load the web view
    self.webView.delegate = self;
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.scrollView.bounces = NO;
    NSURL *url = [NSURL URLWithString:@"http://news.yahoo.com/"];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicator.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    self.activityIndicator.hidden = YES;
    [self.view addSubview: self.activityIndicator];
    
    
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // Enable webview scroll
    if(scrollView.contentOffset.y == self.topView.frame.size.height){
        self.webView.scrollView.scrollEnabled = YES;
        
    }
    
    if(scrollView.contentOffset.y == 0){
        self.webView.scrollView.scrollEnabled = NO;
        
    }
}

#pragma mark - SegmentedControl action

- (IBAction)segmentedControlIndexChanged:(id)sender {
    
    
    switch (self.segmentedControl.selectedSegmentIndex)
    {
        case 0:{
            NSURL *url = [NSURL URLWithString:@"http://news.yahoo.com/"];
            NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
            [self.webView loadRequest:requestObj];
            break;}
        case 1:{
            NSURL *url = [NSURL URLWithString:@"http://cnn.com/"];
            NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
            [self.webView loadRequest:requestObj];
            break;}
        default:
            break;
    }
}


#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView{
    self.webView.hidden = YES;
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.activityIndicator.hidden = YES;
    [self.activityIndicator stopAnimating];
    self.webView.hidden = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    self.activityIndicator.hidden = YES;
    [self.activityIndicator stopAnimating];
    self.webView.hidden = NO;
}


-(void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(scrollView.contentOffset.y >= 100 && scrollView.contentOffset.y < self.topView.frame.size.height){
        [scrollView setContentOffset:CGPointMake(0, self.topView.frame.size.height) animated:YES];
        
    }else{
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}


@end
