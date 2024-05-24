import SwiftUI
import Combine

struct StoriesAllView: View {
    private var stories: [Story] = [.story1, .story2, .story3]
    private var currentStory: Story { stories[currentStoryIndex] }
    private var currentStoryIndex: Int { Int(progress * CGFloat(stories.count)) }
    
    @State private var progress: CGFloat = 0
    @State private var timer: Timer.TimerPublisher = Timer.publish(every: 5, on: .main, in: .common)
    @State private var cancellable: Cancellable?
    private let configuration: ConfigurationTimer
    
    
    init(stories: [Story] = [ .story1, .story2, .story3 ]) {
        self.stories = stories
        configuration = ConfigurationTimer(storiesCount: stories.count)
        timer = Self.createTimer(configuration: configuration)
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoryView(story: currentStory)
            ProgressBar(numberOfSections: stories.count, progress: progress)
                .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
            
            CloseButton(action: { print("close story")})
                .padding(.top,30)
                .padding(.trailing, -5)
            
        }
        .onAppear {
            timer = Self.createTimer(configuration: configuration)
            cancellable = timer.connect()
        }
        .onDisappear {
            cancellable?.cancel()
        }
        .onReceive(timer) { _ in
            timerTick()
        }
        .onTapGesture {
            nextStory()
            resetTimer()
        }
    }
    
    private func timerTick() {
        var nextProgress = progress + configuration.progressPerTick
        if nextProgress >= 1 {
            nextProgress = 0
        }
        withAnimation {
            progress = nextProgress
        }
    }
    
    private func nextStory() {
        let storiesCount = stories.count
        let currentStoryIndex = Int(progress * CGFloat(storiesCount))
        let nextStoryIndex = currentStoryIndex + 1 < storiesCount ? currentStoryIndex + 1 : 0
        withAnimation {
            progress = CGFloat(nextStoryIndex) / CGFloat(storiesCount)
        }
    }
    
    private func resetTimer() {
        cancellable?.cancel()
        timer = Self.createTimer(configuration: configuration)
        cancellable = timer.connect()
    }
    
    private static func createTimer(configuration: ConfigurationTimer) -> Timer.TimerPublisher {
        Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
    }
}

#Preview {
    StoriesAllView()
}
