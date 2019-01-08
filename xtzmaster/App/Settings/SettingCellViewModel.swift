import Foundation

enum SettingCellAction {
  case webpage
  case mail
}

struct SettingCellModel {
  let title: String
  let imageName: String
  let url: URL
  let action: SettingCellAction
  
  init(imageName: String, title: String, url: URL, action: SettingCellAction = SettingCellAction.webpage) {
    self.title = title
    self.imageName = imageName
    self.url = url
    self.action = action
  }
}
