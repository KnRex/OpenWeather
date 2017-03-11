//
//  OpenWeatherTests.swift
//  OpenWeatherTests
//
//  Created by Karthikeyan Gopal on 3/10/17.
//  Copyright © 2017 Karthikeyan Gopal. All rights reserved.
//

import XCTest
@testable import OpenWeather

class OpenWeatherTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        let weatherService = WeatherService();
        
        let testExpectation = expectation(description: "Got weather info")

        weatherService.getWeatherForCity(city: "norwalk"){
            (result: WeatherDetail?, error:String?) in
            if  error == nil{
                if(result!.cod==200){
                    
                    XCTAssert(true)
                }
            }
            else{
                XCTFail("Error: \(error)")

            }
            testExpectation.fulfill()

        }

        self.waitForExpectations(timeout: 10) { error in
                if let error = error {
                    XCTFail("Service Timeout : \(error)")
                }

            }
        

        }

    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
