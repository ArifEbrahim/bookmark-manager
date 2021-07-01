require 'pg'

def persisted_data(table:, id:)
  con = PG.connect(dbname: 'bookmark_manager_test')
  result = con.exec("SELECT * FROM #{table} WHERE id = #{id};")
  result.first
end