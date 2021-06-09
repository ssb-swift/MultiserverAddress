//
// This source file is part of the MultiserverAddress open source project.
//
// Copyright (c) 2021 project authors licensed under Mozilla Public License, v.2.0.
// If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
// See LICENSE for license information.
// See AUTHORS for the list of the project authors.
//

import Regex

///
/// Check for valid multiserver addresses using the following regular expresion:
///
/// **name:** `"[a-z][a-z\\-0-9]+"`
///
/// **data:** `"(?:["-9]|[<-}]|![!~:;])*"`
///
/// **prototype:** `"\(name)(?::\(data))*"` | `"[a-z][a-z\\-0-9]+(?::(?:["-9]|[<-}]|![!~:;])*)*"`
///
/// **address:** `"\(prototype)(?:~\(prototype))*"` | `"[a-z][a-z\\-0-9]+(?::(?:["-9]|[<-}]|![!~:;])*)*(?:~[a-z][a-z\\-0-9]+(?::(?:["-9]|[<-}]|![!~:;])*)*)*"`
/// 
/// **multi:** `"\(address)(?:;\(address))*"` | `"[a-z][a-z\\-0-9]+(?::(?:["-9]|[<-}]|![!~:;])*)*(?:~[a-z][a-z\\-0-9]+(?::(?:["-9]|[<-}]|![!~:;])*)*)*(?:;[a-z][a-z\\-0-9]+(?::(?:["-9]|[<-}]|![!~:;])*)*(?:~[a-z][a-z\\-0-9]+(?::(?:["-9]|[<-}]|![!~:;])*)*)*)*"`
///
/// - Parameter data: Multiserver address to check.
/// - Returns:        Is a valid multiserver address.
///
public func check(data: String) -> Bool {
  let multiRegExp = Regex(
    #"^[a-z][a-z\-0-9]+(?::(?:["-9]|[<-}]|![!~:;])*)*(?:~[a-z][a-z\-0-9]+(?::(?:["-9]|[<-}]|![!~:;])*)*)*(?:;[a-z][a-z\-0-9]+(?::(?:["-9]|[<-}]|![!~:;])*)*(?:~[a-z][a-z\-0-9]+(?::(?:["-9]|[<-}]|![!~:;])*)*)*)*$"#
  )

  return multiRegExp.isMatched(by: data)
}
