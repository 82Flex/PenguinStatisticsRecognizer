import Foundation
import PenguinStatisticsRecognizerCPP

public struct PenguinStatisticsRecognizer {
    
    internal func createUnsafeMutablePointer<T>(forResource resourceName: String, withExtension extensionName: String) throws -> UnsafeMutableBufferPointer<T> {
        let url = Bundle.module.url(forResource: resourceName, withExtension: extensionName)!
        let data = try Data(contentsOf: url)
        let dataPtr = UnsafeMutableBufferPointer<T>.allocate(capacity: data.count)
        _ = data.copyBytes(to: dataPtr)
        return dataPtr
    }
    
    public init(_ i18n: String) throws {
        let hashPtr: UnsafeMutableBufferPointer<CChar> = try createUnsafeMutablePointer(forResource: "hash_index", withExtension: "json")
        let itemPtr: UnsafeMutableBufferPointer<CChar> = try createUnsafeMutablePointer(forResource: "item_index", withExtension: "json")
        let stagePtr: UnsafeMutableBufferPointer<CChar> = try createUnsafeMutablePointer(forResource: "stage_index", withExtension: "json")
        
        PenguinStatisticsRecognizerCPP.preload_json(stagePtr.baseAddress, itemPtr.baseAddress, hashPtr.baseAddress, i18n)
        
        hashPtr.deallocate()
        itemPtr.deallocate()
        stagePtr.deallocate()
        
        let itemURLs = try FileManager.default.contentsOfDirectory(
            at: Bundle.module.resourceURL!,
            includingPropertiesForKeys: nil,
            options: [.skipsHiddenFiles, .skipsPackageDescendants, .skipsSubdirectoryDescendants]
        )
        for itemURL in itemURLs {
            let itemExt = itemURL.pathExtension.lowercased()
            guard itemExt == "png" || itemExt == "jpg" || itemExt == "jpeg" else {
                continue
            }
            
            let itemId = itemURL.deletingPathExtension().lastPathComponent
            let itemPtr: UnsafeMutableBufferPointer<UInt8> = try createUnsafeMutablePointer(forResource: itemId, withExtension: itemExt)
            
            PenguinStatisticsRecognizerCPP.preload_templ(itemId, itemPtr.baseAddress, itemPtr.count)
            
            itemPtr.deallocate()
        }
    }
    
    public func recognize(_ data: Data, fallback: Bool) throws -> Any {
        let dataPtr = UnsafeMutableBufferPointer<UInt8>.allocate(capacity: data.count)
        _ = data.copyBytes(to: dataPtr)
        let outputPtr = PenguinStatisticsRecognizerCPP.recognize(
            dataPtr.baseAddress,
            data.count,
            fallback ? 1 : 0
        )!
        let outputSize = strlen(outputPtr)
        let outputData = Data(bytesNoCopy: UnsafeMutablePointer(mutating: outputPtr), count: outputSize, deallocator: .free)
        return try JSONSerialization.jsonObject(with: outputData, options: [])
    }
}
