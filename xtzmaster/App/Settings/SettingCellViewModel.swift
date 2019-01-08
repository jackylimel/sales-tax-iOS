import Foundation

struct SettingCellModel {
  let title: String
  let imageName: String
  let url: URL?
  
  init(imageName: String, title: String, url: URL?) {
    self.title = title
    self.imageName = imageName
    self.url = url
  }
}
