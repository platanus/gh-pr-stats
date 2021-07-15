class CreateAssignationMetrics < ActiveRecord::Migration[6.0]
  def change
    create_table :assignation_metrics do |t|
      t.bigint :from, null: false
      t.references :github_user, null: false, foreign_key: true
      t.references :pull_request, null: false, foreign_key: true

      t.timestamps
    end
    add_index :assignation_metrics, [:github_user_id,:pull_request_id], unique: true, name: :index_metrics_on_ghuser_and_pr
  end
end
