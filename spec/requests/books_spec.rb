require 'rails_helper'

RSpec.describe '/books', type: :request do
  describe 'GET /index' do
    let!(:books) { create_list(:book, 3) }
    subject(:get_books) { get books_path }

    it 'returns a succesful response' do
      get_books

      expect(response).to have_http_status :ok
    end

    it 'returns a list of books' do
      get_books

      expect(JSON.parse(response.body).count).to eq 3
    end
  end

  describe 'POST /create' do
    let(:params) do
      {
        books: {
          title: 'Talyssoff',
          body: 'Mais um dia de JS'
        }
      }
    end
    subject(:create_book) { post books_path, params: params, as: :json }

    it 'returns a successful response' do
      create_book

      expect(response).to have_http_status :created
    end

    it 'creates a book' do
      expect { create_book }.to change { Book.count }.by(1)
    end

    it 'creates a book with correct attributes' do
      create_book

      expect(JSON.parse(response.body)).to include(
        {
          title: 'Talyssoff',
          body: 'Mais um dia de JS'
        }.as_json
      )
    end
  end
end
