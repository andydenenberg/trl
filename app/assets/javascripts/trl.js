
  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-36365274-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();


$(function () {
        $('.pagination a').click(function () {
		   Type_is = document.getElementById('type_is').value ;
                $.get(this.href, {type_is:Type_is}, null, 'script');
                return false;
        });
        $('#category').change(function () {
		   Search_criteria = document.getElementById('search_criteria').value ;
		   Category = document.getElementById('category').value ;
		   Type_is = 'Documents' ;
                $.get('/posts', {category:Category, type_is:Type_is, search_criteria:Search_criteria} , null, 'script');
                return false;
        });
        $('#search_by_description').click(function () {
		   Search_criteria = document.getElementById('search_criteria').value ;
		   Category = document.getElementById('category').value ;
		   Type_is = 'Documents' ;
                $.get(this.href, {category:Category, type_is:Type_is, search_criteria:Search_criteria}, null, 'script');
                return false;
        });

});

function AddComment(Post) {
	$('#add_comment_button').hide()
    $.get('/posts/add_comment', 
          { post:Post, type_is:'<%= @type_is %>' },         
          function(data) {
            $("#comment").html(data);
          });
  }

function AddAttachment(Post) {
	$('#add_comment_button').hide()
    $.get('/posts/add_attachment', 
          { post:Post, type_is:'<%= @type_is %>' },         
          function(data) {
            $("#comment").html(data);
          });
  }
