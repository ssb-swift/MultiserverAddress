//
// This source file is part of the MultiserverAddress open source project.
//
// Copyright (c) 2021 project authors licensed under Mozilla Public License, v.2.0.
// If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
// See LICENSE for license information.
// See AUTHORS for the list of the project authors.
//

import MultiserverAddress
import XCTest

final class EncodeTests: XCTestCase {
  func testEncodeOne() {
    let address = "net:host.com:8008"

    do {
      let decoded = try MultiserverAddress.decode(data: address)
      XCTAssertEqual(MultiserverAddress.encode(data: decoded), address)
    } catch {
      XCTFail("Invalid multiserver address: \(error)")
    }
  }

  func testEncodeTwo() {
    let address = "net:host.com:8008~shs:oaercuhroaecuh"

    do {
      let decoded = try MultiserverAddress.decode(data: address)
      XCTAssertEqual(MultiserverAddress.encode(data: decoded), address)
    } catch {
      XCTFail("Invalid multiserver address: \(error)")
    }
  }

  func testEncodeThree() {
    let address = "net:host.com:8008~shs:oaercuhroaecuh~gzip"

    do {
      let decoded = try MultiserverAddress.decode(data: address)
      XCTAssertEqual(MultiserverAddress.encode(data: decoded), address)
    } catch {
      XCTFail("Invalid multiserver address: \(error)")
    }
  }

  func testEncodeFour() {
    let address = "ws://host.com:8008~shs:oaercuhroaecuh~gzip"

    do {
      let decoded = try MultiserverAddress.decode(data: address)
      XCTAssertEqual(MultiserverAddress.encode(data: decoded), address)
    } catch {
      XCTFail("Invalid multiserver address: \(error)")
    }
  }

  func testEncodeFive() {
    let address =
      "ws://host.com:8008~shs:oaercuhroaecuh~gzip;net:host.com:8008~shs:oaercuhroaecuh~gzip"

    do {
      let decoded = try MultiserverAddress.decode(data: address)
      XCTAssertEqual(MultiserverAddress.encode(data: decoded), address)
    } catch {
      XCTFail("Invalid multiserver address: \(error)")
    }
  }

  func testEncodeSix() {
    let address = "shs:::"

    do {
      let decoded = try MultiserverAddress.decode(data: address)
      XCTAssertEqual(MultiserverAddress.encode(data: decoded), address)
    } catch {
      XCTFail("Invalid multiserver address: \(error)")
    }
  }

  static let allTests = [
    ("testEncodeOne", testEncodeOne),
    ("testEncodeTwo", testEncodeTwo),
    ("testEncodeThree", testEncodeThree),
    ("testEncodeFour", testEncodeFour),
    ("testEncodeFive", testEncodeFive),
    ("testEncodeSix", testEncodeSix),
  ]
}
