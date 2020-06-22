RSpec.describe UserSessions::CreateService do
  subject { described_class }

  context 'valid parameters' do
    let!(:user) do
      create(:user, email: 'bob@example.com', password: 'givemeatoken', password_confirmation: 'givemeatoken')
    end

    it 'creates a new session' do
      expect { subject.call(email: 'bob@example.com', password: 'givemeatoken') }
          .to change { UserSession.where(user_id: user.id).count }.from(0).to(1)
    end

    it 'assigns session' do
      result = subject.call(email: 'bob@example.com', password: 'givemeatoken')

      expect(result.session).to be_kind_of(UserSession)
    end
  end

  context 'missing user' do
    it 'does not create session' do
      expect { subject.call(email: 'bob@example.com', password: 'givemeatoken') }
          .not_to change { UserSession.count }
    end

    it 'adds an error' do
      result = subject.call(email: 'bob@example.com', password: 'givemeatoken')

      expect(result).to be_failure
      expect(result.errors).to include('Сессия не может быть создана')
    end
  end

  context 'invalid password' do
    let!(:user) do
      create(:user, email: 'bob@example.com', password: 'givemeatoken',  password_confirmation: 'givemeatoken')
    end

    it 'does not create session' do
      expect { subject.call(email: 'bob@example.com', password: 'invalid') }
          .not_to change { UserSession.count }
    end

    it 'adds an error' do
      result = subject.call(email: 'bob@example.com', password: 'invalid')

      expect(result).to be_failure
      expect(result.errors).to include('Сессия не может быть создана')
    end
  end
end