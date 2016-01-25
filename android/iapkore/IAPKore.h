#pragma once

namespace IAPKore {

	int init();
	void purchaseProduct(const char* productId);
	void restore();

	bool getPurchased();
	bool getError();
}
