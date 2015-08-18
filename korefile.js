var project = new Project('iap_kha');

if (platform === Platform.iOS) {
	project.addLib('StoreKit');
	project.addFile('ios/iapkore/**');
	project.addIncludeDir('ios/iapkore');
}

return project;
