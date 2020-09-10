import Foundation

/* 將資料儲存在Caches目錄 */
func fileInCaches(fileName: String) -> URL {
    let fileManager = FileManager()
    let urls = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
    let fileUrl = urls.first!.appendingPathComponent(fileName)
    return fileUrl
}
