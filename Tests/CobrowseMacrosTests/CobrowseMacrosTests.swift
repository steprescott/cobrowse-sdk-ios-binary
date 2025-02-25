
import Foundation
#if canImport(CobrowseRedaction)
import CobrowseRedaction
#endif
#if canImport(CobrowseMacros)
/// Macros targets can't be imported when the package is ran in systems other than macOS
@testable import CobrowseMacros
#endif

import SwiftSyntaxMacrosTestSupport
import XCTest

final class MacroTests: XCTestCase {
    
    let testMacros = ["CobrowseRedaction" : CobrowseRedaction.self]
    
    func test_macro() {
        assertMacroExpansion(
"""
@CobrowseRedaction
struct MyView: View {
    var body: some View {
        VStack {
            Text("Text 1")
                .textCase(.uppercase)
                .cobrowseRedacted()
            HStack(spacing: 10) {
                Text("Text 2")
                Text("Text 3")
            }
        }
    }
}
""",
        expandedSource:
"""
struct MyView: View {
    var body: some View {
        VStack {
            Text("Text 1")
                .textCase(.uppercase)
                .cobrowseRedacted()
            HStack(spacing: 10) {
                Text("Text 2")
                Text("Text 3")
            }
        }
    }

    var redactedBody: some View {
            VStack {
                Text("Text 1")
                    .textCase(.uppercase)
                    .cobrowseRedacted()
                    .cobrowseComputeRedactionState()
                HStack(spacing: 10) {
                    Text("Text 2")
                        .cobrowseComputeRedactionState()
                    Text("Text 3")
                        .cobrowseComputeRedactionState()
                }
                .cobrowseComputeRedactionState()
            }
            .cobrowseComputeRedactionState()
        }
}
""",
        macros: testMacros)
    }
}
