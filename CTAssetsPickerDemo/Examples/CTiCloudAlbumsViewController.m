/*
 
 MIT License (MIT)
 
 Copyright (c) 2013 Clement CN Tsang
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 */

#import "CTiCloudAlbumsViewController.h"


@implementation CTiCloudAlbumsViewController

- (void)pickAssets:(id)sender
{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // init picker
            CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
            
            // set delegate
            picker.delegate = self;
            
            // only show certain albums (iCloud shared photo stream)
            picker.assetCollectionSubtypes =
            @[[NSNumber numberWithInt:PHAssetCollectionSubtypeAlbumCloudShared]];
            
            // create options for fetching asset collection (sort by asset count)
            PHFetchOptions *fetchOptions = [PHFetchOptions new];
            fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"estimatedAssetCount" ascending:NO]];
            
            // assign options
            picker.assetCollectionFetchOptions = fetchOptions;
            
            // to present picker as a form sheet in iPad
            picker.modalPresentationStyle = UIModalPresentationFormSheet;

            // present picker
            [self presentViewController:picker animated:YES completion:nil];
            
        });
    }];
}

@end
