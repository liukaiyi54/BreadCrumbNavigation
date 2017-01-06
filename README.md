# BreadCrumbNavigation

A bread crumb like navigation. Looks like this.

![123](https://cloud.githubusercontent.com/assets/3932207/21706153/dc3d87b6-d3ff-11e6-9378-a24a3d0b55c7.png)

# Usage

1. Copy the DTNavigationController file to your project.

2. Override these methods in your navigation controller: `pushViewController:(UIViewController *)viewController animated:(BOOL)animated`, `popViewControllerAnimated:(BOOL)animated`, `popToRootViewControllerAnimated:(BOOL)animated`, like I did in DemoNavigationController.

3. Implement the method `tapFolderItem:(DTFolderItem *)sender`.


4. You are good to go.

