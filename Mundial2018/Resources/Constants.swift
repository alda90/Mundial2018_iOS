//
//  Constants.swift
//  Mundial2018
//
//  Created by Aldair Carrillo on 29/05/21.
//  Copyright © 2021 Aldair. All rights reserved.
//

import Foundation

struct Constants {
    static let access_token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI2MGIwMDZkOTYyNmE2NTFmNzZiNmNkNmUiLCJpYXQiOjE2MjI1ODY0MjcsImV4cCI6MTY1NDEyMjQyN30.iFyk5rPGE2fhXOzYe5NIzZkYSaLYQS79LWPGnFmSBjg"
    
    struct URL {
        //// PRODUCTION
        static let main = "https://mundial-4dev.herokuapp.com/"
        //// DEVELOPMENT
        
    }
    
    struct Endpoints {
        static let login = "api-login"
        static let logout = "api-logout"
        
        static let fixtures = "api/fixtures/"
        static let groups = "api/standings/"
        static let stadiums = "api/stadium/"
        
    }
    
   
}
