class Transaction < ApplicationRecord
  has_one_attached :cnab

  enum transaction_type: { debito: 1, boleto: 2, financiamento: 3, credito: 4, recebimento_emprestimo: 5, vendas: 6,
  recebimento_TED: 7, recebimento_DOC: 8, aluguel: 9 }

end
