# frozen_string_literal: true

module PagyHelper
  include Pagy::Frontend

  PAGINATE_ROUTE = 'paginate'
  PAGINATE_REGEX = %r{/#{PAGINATE_ROUTE}\??}

  def pagy_url_for(pagy, page, absolute: false, html_escaped: false, separate_route: false)
    url = super(pagy, page, absolute:, html_escaped:)
    return url if !separate_route || url.match?(PAGINATE_REGEX)

    path, query_params = url.split('?', 2)
    "#{path}/#{PAGINATE_ROUTE}?#{query_params}"
  end

  def pagy_next_link(pagy, text: pagy_t('pagy.nav.next'), link_extra: '', separate_route: false)
    if pagy.next
      %(<span class="page next"><a href="#{
          pagy_url_for(pagy, pagy.next, html_escaped: true, separate_route:)
        }" rel="next" aria-label="next" #{
          pagy.vars[:link_extra]
        } #{link_extra}>#{text}</a></span>)
    else
      %(<span class="page next disabled">#{text}</span>)
    end
  end
end
