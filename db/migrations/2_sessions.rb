Sequel.migration do
  change do
    create_table(:user_sessions) do
      primary_key :id, type: :Bignum
      foreign_key :user_id, :users, type: :Bignum, index: true, null: false

      column :uuid, :uuid, index: true, null: false

      column :created_at, 'timestamp(6) without time zone', null: false
      column :updated_at, 'timestamp(6) without time zone', null: false
    end
  end
end
