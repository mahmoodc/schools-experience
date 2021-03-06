require 'rails_helper'

describe ApplicationHelper, type: :helper do
  context 'Breadcrumbs' do
    let(:args) do
      {
        'page one' => '/page/one',
        'page two' => '/page/two',
        'page three' => '/page/three',
        'page four' => nil
      }
    end
    let(:hyperlink_breadcrumbs) { args.reject { |_k, v| v.nil? } }

    let(:breadcrumb_count) { args.count }
    let(:hyperlink_breadcrumb_count) { hyperlink_breadcrumbs.count }

    before { helper.breadcrumbs = args }
    subject { Nokogiri.parse(helper.breadcrumbs) }

    specify 'the generated list should contain GOV.UK breadcrumb-compliant markup' do
      selector = [
        'nav.govuk-breadcrumbs',
        'ol.govuk-breadcrumbs__list',
        'li.govuk-breadcrumbs__list-item',
        'a.govuk-breadcrumbs__list--link'
      ].join(' > ')
      expect(subject.css(selector)).not_to be_nil
    end

    specify 'it should generate the correct total number of breadcrumbs' do
      selector = 'li.govuk-breadcrumbs__list-item'
      expect(subject.css(selector).count).to eql(breadcrumb_count)
    end

    specify 'it should generate the correct number of breadcrumbs with hyperlinks' do
      selector = 'li.govuk-breadcrumbs__list-item > a.govuk-breadcrumbs__list--link'
      expect(subject.css(selector).count).to eql(hyperlink_breadcrumb_count)
    end

    specify 'breadcrumbs should contain the correct text in the right order' do
      args.keys.each.with_index do |text, i|
        expect(subject.css('li')[i].text).to eql(text)
      end
    end

    specify 'breadcrumbs should contain the correct links in the right order' do
      hyperlink_breadcrumbs.values.each.with_index do |path, i|
        expect(subject.css('li > a')[i]['href']).to eql(path)
      end
    end
  end
end
