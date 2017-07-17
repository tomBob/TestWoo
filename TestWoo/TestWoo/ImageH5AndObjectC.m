//
//  ImageH5AndObjectC.m
//  TestWoo
//
//  Created by 吴远锋 on 2017/5/27.
//  Copyright © 2017年 Wuyuanfeng. All rights reserved.
//

#import "ImageH5AndObjectC.h"
#import "WebViewJavascriptBridge.h"
#import "SaveImage_Util.h"

@interface ImageH5AndObjectC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)UIWebView *webView;
@property WebViewJavascriptBridge* bridge;




@end

@implementation ImageH5AndObjectC
{
    int indextNumb;// 交替图片名字

}
- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"ImageH5AndObjectC";
    
    UIWebView *webview              = [[UIWebView alloc]init];
    webview.frame                   = self.view.bounds;
    webview.backgroundColor         = [UIColor whiteColor];
    
    webview.multipleTouchEnabled    = YES;
    webview.autoresizingMask        = YES;
    [self.view addSubview:webview];
    
    
    self.webView = webview;
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    
    NSURL *baseURL  = [NSURL fileURLWithPath:path];
    NSString *htmlPath = [[NSBundle mainBundle]pathForResource:@"testJS" ofType:@"html"];
    NSString *htmlCont = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    
    [self.webView loadHTMLString:htmlCont baseURL:baseURL];
    
    
    
    //开启日志
    [WebViewJavascriptBridge enableLogging];
    _bridge = [WebViewJavascriptBridge bridgeForWebView:webview];
    [_bridge setWebViewDelegate:self];
    
    
    
    //链接h5的方法 getImage
    
    [self.bridge registerHandler:@"getImage" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        
        [self openImage];
        
        
    }];
    
    
    
    
    
    
    
    
    
    
    
    
    

}

-(void)openImage
{
    
    UIImagePickerController *pickerVC = [[UIImagePickerController alloc]init];
    pickerVC.allowsEditing      = YES;
    pickerVC.delegate           = self;
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"选择图片或者打开相机" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *a1 = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        pickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        
        [self presentViewController:pickerVC animated:YES completion:nil];

    }];
    
    UIAlertAction *a2 = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

        [self presentViewController:pickerVC animated:YES completion:nil];

    }];
    
    UIAlertAction *a3= [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    [alertC addAction:a1];
    [alertC addAction:a2];
    [alertC addAction:a3];
    
    [self presentViewController:alertC animated:YES completion:nil];
    
    

}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    UIImage *img = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    
    indextNumb = indextNumb == 1?2:1;

    NSString *nameStr = [NSString stringWithFormat:@"haochi%d.jpg",indextNumb];
    
    [SaveImage_Util saveImage:img ImageName:nameStr back:^(NSString *imageName) {
        
        [_bridge callHandler:@"registerAction" data:imageName responseCallback:^(id responseData) {
           
            NSLog(@"oc 请求的回调 ：%@",responseData);
            
            
        }];
        
    }];
    
    
    
    
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
