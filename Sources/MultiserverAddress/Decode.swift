//
// This source file is part of the MultiserverAddress open source project.
//
// Copyright (c) 2021 project authors licensed under Mozilla Public License, v.2.0.
// If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
// See LICENSE for license information.
// See AUTHORS for the list of the project authors.
//

///
/// Parse a multiserver address string.
///
/// ## Format
///
/// - **name:** Name may contain lower case, digits, and `-`. must start with lower case. <br> `[a-z] [a-z0-9\-]+`
/// - **escaped:** Special characters `!:;~` may be escaped with `!`. <br> `![!:;~]`
/// - **data:** Data field may contain any non-space character, but special characters must be escaped. <br> `["-9] | [<-}] | escaped`
/// - **prototype:** A protocol is a name and zero or more data elements. <br> `name (:data)*`
/// - **address:** An address is 1 or more protocols. <br> `protocol (~ protocol )*`
/// - **multi:** A multiaddress is 1 or more addresses. <br> `address (; address )*`
///
/// ## Examples
/// ```
/// net:wx.larpa.net:8008~shs:DTNmX+4SjsgZ7xyDh5xxmNtFqa6pWi5Qtw7cE8aR9TQ=
/// ws://wx.larpa.net~shs:DTNmX+4SjsgZ7xyDh5xxmNtFqa6pWi5Qtw7cE8aR9TQ=
/// ```
/// _Notice how both_ `ws://` _and_ `ws:` _are valid multiserver addresses._
///
/// - Parameter data:   Multiserver address string.
/// - Returns:          Decoded multiserver address.
/// - Throws:           Throws invalidMultiserverAddressString error if the string is not a valid multiserver address.
///
public func decode(data: String) throws -> [[Address]] {
  guard check(data: data) else {
    throw MultiserverAddressError.invalidMultiserverAddressString
  }

  return data.split(separator: ";").map { x -> [Address] in
    return x.split(separator: "~").map { getAddress(url: String($0)) }
  }
}

func getAddress(url: String) -> Address {
  let fields = url.split(separator: ":", omittingEmptySubsequences: false)
  return Address(name: fields.first!, data: Array(fields.dropFirst()))
}
