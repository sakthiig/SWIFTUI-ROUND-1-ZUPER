
import SwiftUI

struct JobDetailView: View {

    let job: Job
    @ObservedObject var viewModel: JobViewModel

    var currentJob: Job {
        viewModel.jobs.first(where: { $0.id == job.id }) ?? job
    }

    var body: some View {

        VStack(alignment: .leading, spacing: 20) {

            Text(currentJob.customer_name ?? "Unknown customer")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Job ID: \(currentJob.id)")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Divider()

            Text("Job Information")
                .font(.headline)

            VStack(alignment: .leading, spacing: 15) {

                Label {
                    Text(
                        currentJob.address.isEmpty
                        ? "No address yet"
                        : currentJob.address
                    )
                } icon: {
                    Image(systemName: "mappin.and.ellipse")
                }

                Label {
                    Text(currentJob.scheduled_at)
                } icon: {
                    Image(systemName: "clock")
                }

                Label {
                    Text(
                        currentJob.status
                            .replacingOccurrences(of: "_", with: " ")
                            .capitalized
                    )
                } icon: {
                    Image(systemName: "checkmark.circle")
                }
            }

            Divider()

            Text("Job Notes")
                .font(.headline)

            Text(
                currentJob.notes?.isEmpty == false
                ? currentJob.notes!
                : "No notes available"
            )
            .foregroundColor(.secondary)

            Spacer()

            Button(action: {
                viewModel.completeJob(id: currentJob.id)
            }) {

                Text(
                    currentJob.status == "completed"
                    ? "Job Completed"
                    : "Mark as Completed"
                )
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    currentJob.status == "completed"
                    ? Color.gray
                    : Color.green
                )
                .cornerRadius(12)
            }
            .disabled(currentJob.status == "completed")
        }
        .padding()
        .navigationTitle("Job Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

