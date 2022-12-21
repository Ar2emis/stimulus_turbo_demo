# frozen_string_literal: true

class QuotesController < ApplicationController
  include Pagy::Backend
  include GenericResponsesHelper

  before_action :find_quote, only: %i[update edit destroy show]
  before_action :find_quotes, only: %i[index paginate]

  def index; end

  def paginate; end

  def show; end

  def new; end

  def edit; end

  def create
    @quote = Quote.create(quote_params)
    return if @quote.invalid?

    redirect_back_or_to(quotes_path)
  end

  def update
    @quote.update(quote_params)
  end

  def destroy
    @quote.destroy!
    from?(:show) ? redirect_to(quotes_path) : redirect_back_or_to(quotes_path)
  end

  private

  def find_quote
    @quote = Quote.find(params[:id])
  end

  def find_quotes
    query = quotes_params[:query]
    order = Quote::ORDER_TYPES.fetch(quotes_params[:order].to_s.to_sym, Quote::ORDER_TYPES[:'A-Z'])
    @quotes = Quote.order(**order)
    @quotes = @quotes.search_by_text(query) if query.present?
    @pagy, @quotes = pagy(@quotes)
  end

  def quotes_params
    params.permit(:page, :query, :order)
  end

  def quote_params
    params.require(:quote).permit(:text)
  end
end
