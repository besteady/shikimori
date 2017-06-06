describe Api::V1::ClubsController, :show_in_doc do
  let(:club) { create :club }

  describe '#index' do
    include_context :timecop

    let!(:club_en) { create :club, :with_topics, locale: :en, id: 1 }
    let!(:club_1) { create :club, :with_topics, id: 2 }
    let!(:club_2) { create :club, :with_topics, id: 3 }
    let!(:club_3) { create :club, :with_topics, id: 4 }

    before do
      get :index,
        params: {
          page: 1,
          limit: 1,
          search: ''
        },
        format: :json
    end

    it do
      expect(response).to have_http_status :success
      expect(response.content_type).to eq 'application/json'
      expect(collection).to eq [club_1, club_2]
    end
  end

  describe '#show' do
    include_context :authenticated, :user

    let(:club) { create :club, :with_topics }
    before do
      club.members << user
      club.animes << create(:anime)
      club.mangas << create(:manga)
      club.characters << create(:character)
      club.images << create(:club_image, user: build_stubbed(:user), club: club)
    end
    let(:make_request) { get :show, params: { id: club.id }, format: :json }

    context 'club locale == locale from domain' do
      before { make_request }
      it { expect(response).to have_http_status :success }
    end

    context 'club locale != locale from domain' do
      before { allow(controller).to receive(:ru_host?).and_return false }
      it { expect { make_request }.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe '#animes' do
    before { club.animes << create(:anime) }
    before { get :animes, params: { id: club.id }, format: :json }

    it { expect(response).to have_http_status :success }
  end

  describe '#mangas' do
    before { club.mangas << create(:manga) }
    before { get :mangas, params: { id: club.id }, format: :json }

    it { expect(response).to have_http_status :success }
  end

  describe '#ranobe' do
    before { club.mangas << create(:ranobe) }
    before { get :ranobe, params: { id: club.id }, format: :json }

    it { expect(response).to have_http_status :success }
  end

  describe '#characters' do
    before { club.characters << create(:character) }
    before { get :characters, params: { id: club.id }, format: :json }

    it { expect(response).to have_http_status :success }
  end

  describe '#members' do
    before { club.members << create(:user) }
    before { get :members, params: { id: club.id }, format: :json }

    it { expect(response).to have_http_status :success }
  end

  describe '#images' do
    before { club.images << create(:club_image, user: build_stubbed(:user), club: club) }
    before { get :images, params: { id: club.id }, format: :json }

    it { expect(response).to have_http_status :success }
  end

  describe '#join' do
    include_context :authenticated, :user
    before { post :join, params: { id: club.id }, format: :json }

    it do
      expect(club.member? user).to be true
      expect(response).to have_http_status :success
    end
  end

  describe '#leave' do
    include_context :authenticated, :user
    let!(:club_role) { create :club_role, club: club, user: user }
    before { post :leave, params: { id: club.id }, format: :json }

    it do
      expect(club.member? user).to be false
      expect(response).to have_http_status :success
    end
  end
end
