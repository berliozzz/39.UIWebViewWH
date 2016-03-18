//
//  WebViewController.m
//  WebViewWH39
//
//  Created by Nikolay Berlioz on 15.03.16.
//  Copyright © 2016 Nikolay Berlioz. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () 

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.webView loadRequest:self.request];
}

#pragma mark - Actions

- (IBAction) actionBack:(id)sender
{
    if ([self.webView canGoBack])
    {
        [self.webView stopLoading];
        [self.webView goBack];
    }
}

- (IBAction) actionForward:(id)sender
{
    if ([self.webView canGoForward])
    {
        [self.webView stopLoading];
        [self.webView goForward];
    }
}

- (IBAction) actionRefresh:(id)sender
{
    [self.webView stopLoading];
    [self.webView reload];
}

#pragma mark - Private Methods

- (void) refreshButtons
{
    self.backButtonItem.enabled = [self.webView canGoBack];
    self.forwardButtonItem.enabled = [self.webView canGoForward];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"shouldStartLoadWithRequest %@", [request debugDescription]);
    
    
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad");
    
    [self.indicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
    
    [self.indicator stopAnimating];
    
    [self refreshButtons];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    NSLog(@"didFailLoadWithError %@", [error localizedDescription]);
    
    [self.indicator stopAnimating];
    
    [self refreshButtons];
}


@end
