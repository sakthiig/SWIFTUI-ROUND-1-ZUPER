import Foundation
import SwiftUI
import Combine

class JobViewModel: ObservableObject {

    @Published var jobs: [Job] = []
    @Published var errorMessage: String?

    init() {
        loadJobs()
    }

    func loadJobs() {
        guard let url = Bundle.main.url(
            forResource: "jobs",
            withExtension: "json"
        ) else {
            errorMessage = "jobs.json file not found"
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decodedJobs = try JSONDecoder().decode(
                [Job].self,
                from: data
            )

            jobs = decodedJobs.sorted {
                $0.scheduled_at < $1.scheduled_at
            }

        } catch {
            errorMessage = error.localizedDescription
            print("Error loading jobs: \(error)")
        }
    }

    func completeJob(id: String) {
        if let index = jobs.firstIndex(where: { $0.id == id }) {
            jobs[index].status = "completed"
        }
    }

    func pendingJobs() -> [Job] {
        jobs.filter { $0.status == "pending" }
    }
}
