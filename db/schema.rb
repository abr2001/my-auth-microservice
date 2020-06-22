Sequel.migration do
  change do
    create_table(:schema_info) do
      Integer :version, :default=>0, :null=>false
    end

    create_table(:users, :ignore_index_errors=>true) do
      primary_key :id, :type=>:Bignum
      column :name, "character varying", :text=>true, :null=>false
      column :email, "character varying", :text=>true, :null=>false
      column :password_digest, "character varying", :text=>true, :null=>false
      column :created_at, 'timestamp(6) without time zone', null: false
      column :updated_at, 'timestamp(6) without time zone', null: false

      index [:email], :name=>:users_email_key, :unique=>true
    end

    create_table(:user_sessions, :ignore_index_errors=>true) do
      primary_key :id, :type=>:Bignum
      foreign_key :user_id, :users, :type=>:Bignum, :null=>false, :key=>[:id]
      column :uuid, "uuid", :null=>false
      column :created_at, 'timestamp(6) without time zone', null: false
      column :updated_at, 'timestamp(6) without time zone', null: false

      index [:user_id]
      index [:uuid]
    end
  end
end
