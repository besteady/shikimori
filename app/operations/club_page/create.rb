# frozen_string_literal: true

class ClubPage::Create < ServiceObjectBase
  pattr_initialize :params, :user

  def call
    club_page = ClubPage.create @params

    generate_topic club_page if club_page.persisted?
    club_page
  end

private

  def generate_topic club_page
    Topics::Generate::Topic.call(
      club_page,
      @user,
      club_page.club.locale
    )
  end
end
