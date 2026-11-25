
import SwiftUI

struct JobListView: View {

    @ObservedObject var viewModel: JobViewModel
    @State private var showPendingOnly = false

    var displayedJobs: [Job] {
        if showPendingOnly {
            return viewModel.pendingJobs()
        }
        return viewModel.jobs
    }

    var body: some View {
        NavigationStack {
            VStack {

                HStack {
                    Text("Wednesday, 25 November")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Spacer()

                    Text("\(viewModel.pendingJobs().count) pending")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                .padding(.horizontal)

                Toggle(
                    "Show pending jobs only",
                    isOn: $showPendingOnly
                )
                .padding(.horizontal)

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }

                List(displayedJobs) { job in

                    NavigationLink {
                        JobDetailView(
                            job: job,
                            viewModel: viewModel
                        )
                    } label: {

                        HStack {

                            VStack(alignment: .leading, spacing: 6) {

                                Text(job.customer_name ?? "Unknown customer")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(
                                        job.customer_name == nil
                                        ? .secondary
                                        : .primary
                                    )

                                Text(
                                    job.address.isEmpty
                                    ? "No address yet"
                                    : job.address
                                )
                                .font(.system(size: 14))
                                .foregroundColor(.secondary)
                                .lineLimit(1)
                            }

                            Spacer()

                            VStack(alignment: .trailing, spacing: 8) {

                                Text(String(job.scheduled_at.suffix(5)))
                                    .font(.system(size: 15, weight: .medium))
                                    .monospacedDigit()

                                Text(
                                    job.status
                                        .replacingOccurrences(
                                            of: "_",
                                            with: " "
                                        )
                                        .capitalized
                                )
                                .font(.system(size: 12, weight: .semibold))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(
                                    statusColor(job.status).opacity(0.15)
                                )
                                .foregroundColor(statusColor(job.status))
                                .clipShape(Capsule())
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                .listStyle(.insetGrouped)
            }
            .navigationTitle("Today's Jobs")
        }
    }

    func statusColor(_ status: String) -> Color {
        switch status {
        case "pending":
            return .orange
        case "in_progress":
            return .blue
        case "completed":
            return .green
        default:
            return .gray
        }
    }
}

