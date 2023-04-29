class AddAutoIncrementToServicerequest < ActiveRecord::Migration[7.0]
    def up
    execute <<-SQL
      CREATE SEQUENCE servicerequests_id_seqq START 10001;
      ALTER TABLE servicerequests ALTER COLUMN id SET DEFAULT nextval('servicerequests_id_seqq');
    SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE servicerequests ALTER COLUMN id SET DEFAULT NULL;
      DROP SEQUENCE servicerequests_id_seqq;
    SQL
  end
end
