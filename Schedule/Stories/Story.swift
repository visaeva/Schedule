
import SwiftUI

struct Story: Identifiable, Equatable, Hashable {
    let id = UUID()
    let backgroundImage: UIImage
    let title: String
    let description: String
    let backgroundColor: Color
    
    static let story1 = Story(
        backgroundImage: .story1,
        title: "Text Text Text Text Text Text Text Text Text Text",
        description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text", 
        backgroundColor: .storyBackground
    )
    
    static let story2 = Story(  backgroundImage: .story2,
                              title: "Text Text Text Text Text Text Text Text Text",
                                description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
                                backgroundColor: .storyBackground
    )
    
    static let story3 = Story(  backgroundImage: .story3,
                              title: "Text Text Text Text Text Text Text Text Text",
                                description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
                                backgroundColor: .storyBackground
                              )
}
