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

final class DecodeTests: XCTestCase {
  func testDecodeOne() {
    do {
      let decoded = try MultiserverAddress.decode(data: "net:host.com:8008")

      XCTAssertEqual(decoded.count, 1)
      XCTAssertEqual(decoded[0].count, 1)
      XCTAssertEqual(decoded[0][0].name, "net")
      XCTAssertEqual(decoded[0][0].data.count, 2)
      XCTAssertEqual(decoded[0][0].data[0], "host.com")
      XCTAssertEqual(decoded[0][0].data[1], "8008")
    } catch {
      XCTFail("Invalid multiserver address: \(error)")
    }
  }

  func testDecodeTwo() {
    do {
      let decoded = try MultiserverAddress.decode(data: "net:host.com:8008~shs:oaercuhroaecuh")

      XCTAssertEqual(decoded.count, 1)
      XCTAssertEqual(decoded[0].count, 2)
      XCTAssertEqual(decoded[0][0].name, "net")
      XCTAssertEqual(decoded[0][0].data.count, 2)
      XCTAssertEqual(decoded[0][0].data[0], "host.com")
      XCTAssertEqual(decoded[0][0].data[1], "8008")
      XCTAssertEqual(decoded[0][1].name, "shs")
      XCTAssertEqual(decoded[0][1].data.count, 1)
      XCTAssertEqual(decoded[0][1].data[0], "oaercuhroaecuh")
    } catch {
      XCTFail("Invalid multiserver address: \(error)")
    }
  }

  func testDecodeThree() {
    do {
      let decoded = try MultiserverAddress.decode(data: "net:host.com:8008~shs:oaercuhroaecuh~gzip")

      XCTAssertEqual(decoded.count, 1)
      XCTAssertEqual(decoded[0].count, 3)
      XCTAssertEqual(decoded[0][0].name, "net")
      XCTAssertEqual(decoded[0][0].data.count, 2)
      XCTAssertEqual(decoded[0][0].data[0], "host.com")
      XCTAssertEqual(decoded[0][0].data[1], "8008")
      XCTAssertEqual(decoded[0][1].name, "shs")
      XCTAssertEqual(decoded[0][1].data.count, 1)
      XCTAssertEqual(decoded[0][1].data[0], "oaercuhroaecuh")
      XCTAssertEqual(decoded[0][2].name, "gzip")
      XCTAssertEqual(decoded[0][2].data.count, 0)
    } catch {
      XCTFail("Invalid multiserver address: \(error)")
    }
  }

  func testDecodeFour() {
    do {
      let decoded = try MultiserverAddress.decode(
        data: "ws://host.com:8008~shs:oaercuhroaecuh~gzip")

      XCTAssertEqual(decoded.count, 1)
      XCTAssertEqual(decoded[0].count, 3)
      XCTAssertEqual(decoded[0][0].name, "ws")
      XCTAssertEqual(decoded[0][0].data.count, 2)
      XCTAssertEqual(decoded[0][0].data[0], "//host.com")
      XCTAssertEqual(decoded[0][0].data[1], "8008")
      XCTAssertEqual(decoded[0][1].name, "shs")
      XCTAssertEqual(decoded[0][1].data.count, 1)
      XCTAssertEqual(decoded[0][1].data[0], "oaercuhroaecuh")
      XCTAssertEqual(decoded[0][2].name, "gzip")
      XCTAssertEqual(decoded[0][2].data.count, 0)
    } catch {
      XCTFail("Invalid multiserver address: \(error)")
    }
  }

  func testDecodeFive() {
    do {
      let decoded = try MultiserverAddress.decode(
        data: "ws://host.com:8008~shs:oaercuhroaecuh~gzip;net:host.com:8008~shs:oaercuhroaecuh~gzip"
      )

      XCTAssertEqual(decoded.count, 2)
      XCTAssertEqual(decoded[0].count, 3)
      XCTAssertEqual(decoded[0][0].name, "ws")
      XCTAssertEqual(decoded[0][0].data.count, 2)
      XCTAssertEqual(decoded[0][0].data[0], "//host.com")
      XCTAssertEqual(decoded[0][0].data[1], "8008")
      XCTAssertEqual(decoded[0][1].name, "shs")
      XCTAssertEqual(decoded[0][1].data.count, 1)
      XCTAssertEqual(decoded[0][1].data[0], "oaercuhroaecuh")
      XCTAssertEqual(decoded[0][2].name, "gzip")
      XCTAssertEqual(decoded[0][2].data.count, 0)
      XCTAssertEqual(decoded[1].count, 3)
      XCTAssertEqual(decoded[1][0].name, "net")
      XCTAssertEqual(decoded[1][0].data.count, 2)
      XCTAssertEqual(decoded[1][0].data[0], "host.com")
      XCTAssertEqual(decoded[1][0].data[1], "8008")
      XCTAssertEqual(decoded[1][1].name, "shs")
      XCTAssertEqual(decoded[1][1].data.count, 1)
      XCTAssertEqual(decoded[1][1].data[0], "oaercuhroaecuh")
      XCTAssertEqual(decoded[1][2].name, "gzip")
      XCTAssertEqual(decoded[1][2].data.count, 0)
    } catch {
      XCTFail("Invalid multiserver address: \(error)")
    }
  }

  func testDecodeSix() {
    do {
      // Data fields may be empty
      let decoded = try MultiserverAddress.decode(data: "shs:::")

      XCTAssertEqual(decoded.count, 1)
      XCTAssertEqual(decoded[0].count, 1)
      XCTAssertEqual(decoded[0][0].name, "shs")
      XCTAssertEqual(decoded[0][0].data.count, 3)
      XCTAssertEqual(decoded[0][0].data[0], "")
      XCTAssertEqual(decoded[0][0].data[1], "")
      XCTAssertEqual(decoded[0][0].data[2], "")
    } catch {
      XCTFail("Invalid multiserver address: \(error)")
    }
  }

  static let allTests = [
    ("testDecodeOne", testDecodeOne),
    ("testDecodeTwo", testDecodeTwo),
    ("testDecodeThree", testDecodeThree),
    ("testDecodeFour", testDecodeFour),
    ("testDecodeFive", testDecodeFive),
    ("testDecodeSix", testDecodeSix),
  ]
}
