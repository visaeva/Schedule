import SwiftUI

struct StoriesCellView: View {
    let stories: [Story] = [.story1, .story2, .story3, .story3]
    let imageHeight: CGFloat = 140
    let imageWidth: CGFloat = 92
    let images = ["1", "2", "3", "4"]
    
    @State private var viewedStories: Set<Int> = []
    
    var body: some View {
        NavigationStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(0..<stories.count) { index in
                        let story = stories[index]
                        NavigationLink(destination: StoriesAllView(stories: stories, selectedStory: story, viewedStories: $viewedStories)) {
                            ZStack(alignment: .bottomLeading) {
                                Image(images[index])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: imageWidth, height: imageHeight)
                                    .cornerRadius(16)
                                    .opacity(viewedStories.contains(index) ? 0.5 : 1.0)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color("blueUniversal"), lineWidth: viewedStories.contains(index) ? 0 : 4)
                                    )
                                Text("Text Text\nText Text\nText Text Text")
                                    .font(.system(size: 12, weight: .regular))
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.white)
                                    .lineLimit(3)
                                    .padding(8)
                            }
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            viewedStories.insert(index)
                        })
                    }
                }
            }
        }
    }
}


#Preview {
    StoriesCellView()
}
