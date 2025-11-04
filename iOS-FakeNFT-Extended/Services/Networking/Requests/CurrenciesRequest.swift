//
//  CurrenciesRequest.swift
//  iOS-FakeNFT-Extended
//
//  Created by Симонов Иван Дмитриевич on 14.10.2025.
//  Copyright © 2025 com.example. All rights reserved.
//

import Foundation

struct CurrenciesRequest: NetworkRequest {
	var endpoint: URL? {
		URL(string: "\(RequestConstants.baseURL)/api/v1/currencies")
	}
}
