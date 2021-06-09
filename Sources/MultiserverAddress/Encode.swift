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
/// Reverse a decoded multiserver address to its string form.
///
/// - Parameter data:   Decoded multiserver address.
/// - Returns:          Multiserver address string.
///
public func encode(data: [[Address]]) -> String {
  return data.map({
    $0.map({
      encodeAddress(address: $0)
    }).joined(separator: "~")
  }).joined(separator: ";")
}

func encodeAddress(address: Address) -> String {
  let domain =
    address.data.count > 0
    ? ":\(address.data.joined(separator: ":"))"
    : ""

  return "\(address.name)\(domain)"
}
