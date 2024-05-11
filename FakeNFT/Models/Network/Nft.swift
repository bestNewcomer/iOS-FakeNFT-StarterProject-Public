import Foundation

struct Nft: Decodable {
  let name: String
  let images: [URL]
  let rating: Int
  let description: String
  let price: Double
  let author: String
  let id: String
  let createdAt: String
}
