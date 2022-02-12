class AddStructureToTransactions < ActiveRecord::Migration[7.0]
  add_column :transactions, :transaction_type, :integer

  def change
    def up
      execute <<-SQL
      CREATE TYPE transaction_type AS ENUM ('debito', 'boleto', 'financiamento', 'credito', 
      'recebimento_emprestimo','vendas', 'recebimento_TED', 'recebimento_DOC', 'aluguel')
      SQL
    end

    def down
      remove_column :transactions, :transaction_type
      execute <<-SQL
      DROP TYPE transaction_type;
      SQL
    end

    add_column :transactions, :date, :string
    add_column :transactions, :value, :decimal
    add_column :transactions, :cpf, :string
    add_column :transactions, :card_number, :string
    add_column :transactions, :transaction_time, :string
    add_column :transactions, :store_owner, :string
    add_column :transactions, :store_name, :string

    add_index :transactions, :transaction_type
  end
end
