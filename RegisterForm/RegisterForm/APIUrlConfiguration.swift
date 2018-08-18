//
//  APIUrlConfiguration.swift
//  RegisterForm
//
//  Created by Ahmed Elbasha on 8/18/18.
//  Copyright © 2018 Ahmed Elbasha. All rights reserved.
//

import Foundation

var countryId = 0

func generateGetCountriesApiUrl() -> String {
    return "http://souq.hardtask.co/app/app.asmx/GetCountries"
}

func generateGetCitiesApiUrl(countryId: Int32) -> String {
    return "http://souq.hardtask.co/app/app.asmx/GetCities?CountryId=\(countryId)"
}
