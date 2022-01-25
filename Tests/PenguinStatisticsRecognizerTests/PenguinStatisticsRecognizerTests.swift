import XCTest
@testable import PenguinStatisticsRecognizer

final class PenguinStatisticsRecognizerTests: XCTestCase {
    func data(forResource resourceName: String, withExtension extensionName: String) -> Data {
        return try! Data(contentsOf: Bundle.module.url(forResource: resourceName, withExtension: extensionName)!)
    }
    
    func testExample() throws {
        let recognizer = try PenguinStatisticsRecognizer("CN")
        let result = try recognizer.recognize(data(forResource: "templ", withExtension: "png"), fallback: false)
        print(String(data: try JSONSerialization.data(withJSONObject: result, options: [.prettyPrinted, .sortedKeys]), encoding: .utf8)!)
    }
}
