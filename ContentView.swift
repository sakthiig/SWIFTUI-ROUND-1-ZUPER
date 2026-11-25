
import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = JobViewModel()

    var body: some View {
        JobListView(viewModel: viewModel)
    }
}

#Preview {
    ContentView()
}

