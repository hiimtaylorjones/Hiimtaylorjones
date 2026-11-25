require 'rails_helper'

RSpec.describe HerokuWebhookEvent do
	def build_event(action:, status:, sha: "3ad11eb85b179e8254f6104ba83bd2168188736d")
		{
			"resource" => "build",
			"action" => action,
			"data" => { "id" => "build-1", "status" => status, "source_blob" => { "version" => sha } }
		}
	end

	def release_event(action:, status:, description:, previous_data: {})
		{
			"resource" => "release",
			"action" => action,
			"data" => { "version" => 127, "status" => status, "description" => description },
			"previous_data" => previous_data
		}
	end

	describe "build events" do
		it "dispatches a finished build with its id, commit and status" do
			dispatch = described_class.new(build_event(action: "update", status: "succeeded")).dispatch

			expect(dispatch.event_type).to eq("heroku-build")
			expect(dispatch.client_payload).to eq(
				build_id: "build-1", sha: "3ad11eb85b179e8254f6104ba83bd2168188736d", status: "succeeded"
			)
		end

		it "dispatches a failed build too" do
			expect(described_class.new(build_event(action: "update", status: "failed")).dispatch.client_payload[:status]).to eq("failed")
		end

		it "leaves out a commit Heroku did not send" do
			payload = described_class.new(build_event(action: "update", status: "succeeded", sha: nil)).dispatch.client_payload
			expect(payload).not_to have_key(:sha)
		end

		it "ignores a build that has only started" do
			expect(described_class.new(build_event(action: "create", status: "pending")).dispatch).to be_nil
		end
	end

	describe "release events" do
		it "dispatches a rollback, which has no build behind it" do
			event = release_event(action: "create", status: "succeeded", description: "Rollback to v125")
			dispatch = described_class.new(event).dispatch

			expect(dispatch.event_type).to eq("heroku-release")
			expect(dispatch.client_payload).to eq(version: 127, status: "succeeded", description: "Rollback to v125")
		end

		it "dispatches a config change once its release phase finishes" do
			event = release_event(action: "update", status: "failed", description: "Set FOO config vars",
			                      previous_data: { "status" => "pending" })
			expect(described_class.new(event).dispatch.client_payload[:status]).to eq("failed")
		end

		it "ignores a release still running its release phase" do
			event = release_event(action: "create", status: "pending", description: "Set FOO config vars")
			expect(described_class.new(event).dispatch).to be_nil
		end

		it "ignores an update that did not change the status" do
			event = release_event(action: "update", status: "succeeded", description: "Set FOO config vars",
			                      previous_data: { "current" => false })
			expect(described_class.new(event).dispatch).to be_nil
		end

		# Code deploys are followed from their build event instead.
		it "ignores a code deploy release" do
			event = release_event(action: "update", status: "succeeded", description: "Deploy 3ad11eb8",
			                      previous_data: { "status" => "pending" })
			expect(described_class.new(event).dispatch).to be_nil
		end
	end

	it "ignores other resources" do
		expect(described_class.new({ "resource" => "dyno", "action" => "create", "data" => {} }).dispatch).to be_nil
	end
end
