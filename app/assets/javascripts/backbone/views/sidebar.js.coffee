class Youngagrarians.Views.Sidebar extends Backbone.Marionette.View
  tagName: 'ul'
  className: 'nav nav-stacked nav-pills'

  events:
    'click li.category' : 'showHide'

  initialize: () ->
    @options.locations.on 'reset', @reset, @

  reset: (col,data) =>
    title = @make('li', {'class': 'nav-header'}, 'Categories')
    @$el.empty()
    @$el.append title
    @addAll()

  addAll: (col,data) =>
    @types = window.Categories.pluck 'name'
    _(@types).each @addOne

  addOne: (type) =>
    a = @make 'a', {href: '#'}, type
    li =  @make 'li', {class: 'category active', 'data-type': type}, a
    @$el.append li

  make: (tagName, attributes, content) ->
    $el = Backbone.$ "<" + tagName + "/>"
    if attributes
      $el.attr attributes
    if content != null
      $el.html content
    $el[0]

  render: =>
    @reset()

  showHide: (ev) =>
    target = $ ev.target.parentNode
    type = target.data 'type'
    target.toggleClass 'active'

    filter = @types

    $(ev.target.parentNode.parentNode).find("li.category").each (index,li) =>
      if not $(li).hasClass 'active'
        filter = _(filter).without $(li).data 'type'

    @trigger 'filter', filter