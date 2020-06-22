Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id, type: :Bignum

      column :name, String, null: false
      column :email, String, unique: true, null: false
      column :password_digest, String, null: false

      column :created_at, 'timestamp(6) without time zone', null: false
      column :updated_at, 'timestamp(6) without time zone', null: false
    end
  end
end
