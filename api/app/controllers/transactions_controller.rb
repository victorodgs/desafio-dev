class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show update destroy ]

  # GET /transactions
  def index
    @transactions = Transaction.all

    render json: @transactions
  end

  # GET /transactions/1
  def show
    render json: @transaction
  end

  # POST /transactions
  def create
    # rest of params

    fileExtension = File.extname(params[:cnab].original_filename)

    if fileExtension.eql? '.txt'
      File.readlines(params[:cnab]).each do |line|
        # Verify if line is not empty
        if line.length >= 10
          cnabLine = line.encode('UTF-8', 'UTF-8')

          @transaction = Transaction.new do |t|
            t.transaction_type = cnabLine.to_s[0,1]
            t.value = cnabLine.to_s[9,18]
          end

          @transaction.save
        end
      end

      if @transaction.save
        render json: {message: 'Transactions saved successfully.'}, status: :created, location: @transaction
      else
        render json: @transaction.errors, status: :unprocessable_entity
      end

    else
      render json: {message: 'Only txt files are supported.'}, status: :unprocessable_entity
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.fetch(:cnab)
    end
end
