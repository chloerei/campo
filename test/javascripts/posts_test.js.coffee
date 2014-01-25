module('Posts')

test 'should acitve reply-to button', ->
  $fixture = $('#qunit-fixture')
  $fixture.append("""
  <a data-post-reply-to="@user #1"></a>
  <div id="new_post">
    <textarea></textarea>
  </div>
  """)
  $fixture.find('a').trigger 'click'
  equal( $fixture.find('textarea').val(), '@user #1 ')
