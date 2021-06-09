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

final class CheckTests: XCTestCase {
  func testCheckValid() {
    let validAddresses = [
      "net:host.com:8008",
      "net:host.com:8008~shs:oaercuhroaecuh",
      "net:host.com:8008~shs:oaercuhroaecuh~gzip",
      "ws://host.com:8008~shs:oaercuhroaecuh~gzip",
      "ws://host.com:8008~shs:oaercuhroaecuh~gzip;net:host.com:8008~shs:oaercuhroaecuh~gzip",
      "shs:::",  //data fields may be empty
    ]

    for address in validAddresses {
      XCTAssertTrue(MultiserverAddress.check(data: address))
    }
  }

  func testCheckInvalid() {
    let invalidAddresses = [
      "",  //empty
      ":host.com:8008",  //missing name
      "1a:host.com:8008",  //missing name starting with number
      "ABC:host.com:8008",  //capitals in name
      "a.b:host.com:8008",  //punctuation in name
      "~:host.com:8008",  //protocol separator in name
      ";:host.com:8008",  //address separator in name
      "!:host.com:8008",  //escape in name
      "net:host.com:8008~",  //empty protocol
      "net:host.com:8008~~gzip",  //empty protocol
    ]

    for address in invalidAddresses {
      XCTAssertFalse(MultiserverAddress.check(data: address))
    }
  }

  static let allTests = [
    ("testCheckValid", testCheckValid),
    ("testCheckInvalid", testCheckInvalid),
  ]
}
