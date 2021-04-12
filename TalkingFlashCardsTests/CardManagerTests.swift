//
//  CardManagerTests.swift
//  TalkingFlashCardsTests
//
//  Created by Andrew Stoddart on 08/04/2021.
//

import XCTest
@testable import TalkingFlashCards

class CardManagerTests: XCTestCase {
  
  var cardManager: CardManager!
  
  override func setUpWithError() throws {
    cardManager = CardManager()
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testPromoteCard_CardInFirstBox_PromoteOne_MovesToNextBox() {
    // Given
    var card = Card()
    card.boxNumber = 0
    
    // When
    cardManager.promoteCard(&card)
    
    // Then
    XCTAssertEqual(card.boxNumber, 1, "Box numbers didn't increment correctly")
  }
  
  func testPromotedCard_CardInFirstBox_PromoteOne_ReviewDateIsIncreased() {
    // Given
    var card = Card()
    card.boxNumber = 2
    
    // When
    cardManager.promoteCard(&card)
    
    // Then
    let nextReviewDate = Calendar.current.date(byAdding: .day, value: 8, to: Date())!
    let daysDiff = Calendar.current.dateComponents([.day], from: card.nextReviewDate!, to: nextReviewDate)
    XCTAssertEqual(daysDiff.day, 0, "Next Review Date is not correct")
  }
  
  func testDemoteCard_CardInMiddleBox_DemoteOne_MovesToPreviousBox() {
    // Given
    var card = Card()
    card.boxNumber = 3
    
    // When
    cardManager.demoteCard(&card)
    
    // Then
    XCTAssertEqual(card.boxNumber, 2, "Box number didn't decrement correctly")
  }
  
  func testDemoteCard_CardInLastBox_DemoteOne_ReviewDateIsDecreased() {
    // Given
    var card = Card()
    card.boxNumber = 5
    
    // When
    cardManager.demoteCard(&card)
    
    // Then
    let nextReviewDate = Calendar.current.date(byAdding: .day, value: 16, to: Date())!
    let daysDiff = Calendar.current.dateComponents([.day], from: card.nextReviewDate!, to: nextReviewDate)
    XCTAssertEqual(daysDiff.day, 0, "Next review date is incorrect")
  }
}
