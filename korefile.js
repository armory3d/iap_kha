var project = new Project('iap_kha');

if (platform === Platform.iOS) {
	project.addLib('StoreKit');
	project.addFile('ios/iapkore/**');
	project.addIncludeDir('ios/iapkore');
}
else if (platform === Platform.Android) {
	project.addFile('android/iapkore/**');
	project.addIncludeDir('android/iapkore');
	project.addJavaDir('android/java');
}

return project;
