module('Posts')

test 'should update liks by ids', ->
  $fixture = $('#qunit-fixture')
  $fixture.append("""
  <div id="post_1">
    <a class="post-like" data-method="post"></a>
  </div>
  <div id="post_2">
    <a class="post-like" data-method="post"></a>
  </div>
  <div id="post_3">
    <a class="post-like" data-method="post"></a>
  </div>
  """)
  campo.Posts.updateLikes([1,2])
  ok($fixture.find('#post_1 .post-like').hasClass('active'))
  equal($fixture.find('#post_1 .post-like').data('method'), 'delete')
  ok($fixture.find('#post_2 .post-like').hasClass('active'))
  equal($fixture.find('#post_2 .post-like').data('method'), 'delete')
  ok(!$fixture.find('#post_3 .post-like').hasClass('active'))
  equal($fixture.find('#post_3 .post-like').data('method'), 'post')



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
