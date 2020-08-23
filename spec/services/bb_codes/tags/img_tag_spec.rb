describe BbCodes::Tags::ImgTag do
  subject { described_class.instance.format text, text_hash }

  let(:text_hash) { 'hash' }
  let(:url) { 'http://site.com/site-url' }
  let(:text) { "[img]#{url}[/img]" }
  let(:camo_url) { UrlGenerator.instance.camo_url url }

  context 'common case' do
    it do
      is_expected.to eq(
        <<-HTML.squish.strip
          <a href='#{url}'
            data-href='#{camo_url}'
            rel='#{text_hash}'
            class='b-image unprocessed'><img
              src='#{camo_url}'
              class='check-width'
              loading='lazy'></a>
        HTML
      )
    end
  end

  context 'no-zoom' do
    let(:text) { "[img no-zoom]#{url}[/img]" }
    it do
      is_expected.to eq(
        <<-HTML.squish.strip
          <span class='b-image no-zoom'><img src='#{camo_url}'
            class='check-width' loading='lazy'></span>
        HTML
      )
    end
  end

  context 'multiple images' do
    let(:url_2) { 'http://site.com/site-url-2' }
    let(:text) { "[img]#{url}[/img] [img]#{url_2}[/img]" }
    let(:camo_url_2) { UrlGenerator.instance.camo_url url_2 }

    it do
      is_expected.to eq(
        <<-HTML.squish.strip
          <a href='#{url}' data-href='#{camo_url}'
            rel='#{text_hash}'
            class='b-image unprocessed'><img
              src='#{camo_url}'
              class='check-width'
              loading='lazy'></a>
            <a
            href='#{url_2}'
            data-href='#{camo_url_2}'
            rel='#{text_hash}' class='b-image unprocessed'><img
              src='#{camo_url_2}'
              class='check-width'
              loading='lazy'></a>
        HTML
      )
    end
  end

  context 'with sizes' do
    let(:text) { "[img 400x500]#{url}[/img]" }
    it { is_expected.to include "width='400' height='500' loading='lazy'></a>" }
  end

  context 'with width' do
    let(:text) { "[img w=400]#{url}[/img]" }
    it { is_expected.to include "width='400' loading='lazy'></a>" }
  end

  context 'with height' do
    let(:text) { "[img h=500]#{url}[/img]" }
    it { is_expected.to include "height='500' loading='lazy'></a>" }
  end

  context 'with width&height' do
    let(:text) { "[img width=400 height=500]#{url}[/img]" }
    it { is_expected.to include "width='400' height='500' loading='lazy'></a>" }
  end

  context 'with class' do
    let(:text) { "[img class=zxc]#{url}[/img]" }
    it { is_expected.to include "class='b-image unprocessed zxc'" }
  end

  context 'inside url' do
    let(:text) { "[url=#{link}][img]#{url}[/img][/url]" }

    context 'normal link' do
      let(:link) { '/test' }
      it do
        is_expected.to eq(
          "<a href='#{link}' data-href='#{camo_url}' rel='hash' "\
            "class='b-image unprocessed'><img src='#{camo_url}' "\
            "class='check-width' loading='lazy'></a>"
        )
      end
    end

    context 'link to shiki image' do
      let(:link) { 'http://shikimori.test/test.jpg' }
      let(:camo_link_url) { UrlGenerator.instance.camo_url link }

      it do
        is_expected.to eq(
          "<a href='#{link}' data-href='#{camo_link_url}' rel='hash' "\
            "class='b-image unprocessed'><img src='#{camo_url}' "\
            "class='check-width' loading='lazy'></a>"
        )
      end
    end
  end
end
