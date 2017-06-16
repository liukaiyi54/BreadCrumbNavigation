# BreadCrumbNavigation

A bread crumb like navigation. Looks like this.

![jun-16-2017 22-54-47](https://user-images.githubusercontent.com/3932207/27232238-ddef399e-52e7-11e7-8ec5-61a3bb8b77a8.gif)

# Usage

1. Copy the DTNavigationController file to your project.

2. Override these methods in your navigation controller: `pushViewController:(UIViewController *)viewController animated:(BOOL)animated`, `popViewControllerAnimated:(BOOL)animated`, `popToRootViewControllerAnimated:(BOOL)animated`, like I did in DemoNavigationController.

3. Implement the method `tapFolderItem:(DTFolderItem *)sender`.


4. You are good to go.

