import Foundation

enum BakingDetailCellType {
  case singleRow
  case twoRows
}

struct BakingDetailCellViewModel {
  let title: String
  let value: String
  let url: URL?
}
